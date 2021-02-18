import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapi_car_app/core/services/app_service.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/core/services/config_service.dart';
import 'package:rapi_car_app/ui/bloc/map/map_bloc.dart';
import 'package:rapi_car_app/ui/bloc/my_location/my_location_bloc.dart';

import 'package:rapi_car_app/core/providers/app_page_manager.dart';

class FilterCarView extends StatefulWidget {
  FilterCarView({Key key}) : super(key: key);

  @override
  _FilterCarViewState createState() => _FilterCarViewState();
}

class _FilterCarViewState extends State<FilterCarView> {
  LatLng latLng;
  double radio = 20000;
  Set<Circle> _circles = HashSet<Circle>();

  final minController = TextEditingController();
  final maxController = TextEditingController();

  bool openPrice = false;
  bool openOrder = false;
  String valuePrice = 'Cualquiera';
  String valueOrder = 'Recomendados';

  Map<String, int> menuOrder = {
    'Recomendados': 1,
    'Precio: más bajo': 2,
    'Precio: más alto': 3,
    //'Distancia: más cerca': 4,
    //'Distancia: más lejos': 5,
    'Fecha de publicación: más recientes': 6
  };

  int group = 1;
  
  @override
  void initState() {
    context.read<MyLocationBloc>().startTracking();

    super.initState();
    latLng = LatLng(12.128264, -86.264012);//await carService.getLocation();//context.getArguments();
    _setCricleMarker(latLng);

    getConfig();
  }

  Future getConfig() async {
    final price = await AppService.getPrice();
    if (price != null) {
      final json = jsonDecode(price);
      if (json['min'] != '' || json['max'] != '') {
        minController.text = json['min'];
        maxController.text = json['max'];

        valuePrice = 'De \$${json['min'] == '' ? '0' : json['min']} a \$${json['max'] == '' ? 'Max' : json['max']}';
      }
    }

    group = await AppService.getOrderId();

    valueOrder = menuOrder.keys.elementAt(group - 1);

    setState(() {});
  }

  @override
  void dispose() {
    context.read<MyLocationBloc>().finishTracking();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          child: Stack(
            children: [
              BlocBuilder<MyLocationBloc, MyLocationState>(
                builder: (context, state) => _mapGoogle(state)
              ),
              Positioned(
                left: 50,
                right: 50,
                bottom: 10,
                child: Container(
                  //width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text('Arrasta el mapa para elegir una ubicación', style: TextStyle(color: Colors.white), textAlign: TextAlign.center)
                )
              )
            ]
          )
        ),
        BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return Positioned(
              bottom: 30,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                      child:Slider(
                      value: radio,
                      min: 5000,
                      max: 40000,
                      onChanged: (value) async {
                        setState(() => radio = value);

                        _setCricleMarker(state.centerLocation != null ? state.centerLocation : latLng);
                      }
                    )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text('${(radio/400).toInt()} km'),
                  )
                ]
              )
            );
          }
        ),
        openPrice || openOrder
        ? _openFilters()
        : Column(
          children: [
            ListTile(
              title: Text('Precio'),
              subtitle: Text(valuePrice),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => setState((){ openPrice = true; }),
            ),
            ListTile(
              title: Text('Ordenar'),
              subtitle: Text(valueOrder),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => setState((){ openOrder = true; })
            )
          ]
        )
      ],
    ));
  }

  Widget _mapGoogle(MyLocationState state) {
    final mapBloc =  BlocProvider.of<MapBloc>(context);

    final cameraPosition = CameraPosition(
      target: (state.location != null) ? state.location : latLng,
      zoom: 12
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
      ].toSet(),
      onMapCreated: mapBloc.initMap,
      //myLocationEnabled: true,
      zoomControlsEnabled: false,
      onCameraMove: (cameraPosition) {
        mapBloc.add(OnCangedCenterMap(cameraPosition.target));
        _setCricleMarker(cameraPosition.target);
      },
      circles: _circles,
    );
  }

  void _setCricleMarker(LatLng point) {
    setState(() {
      _circles.clear();
      _circles.add(Circle(
        circleId: CircleId('1'),
        center: point,
        radius: radio,
        fillColor: Colors.blueAccent.withOpacity(0.5),
        strokeWidth: 0
      ));
    });
  }

  Widget _openFilters() {
    if (openOrder)
      return _generateFilterOrder();
    else if (openPrice)
      return _generateFilterPrice();
  }

  Widget _generateFilterPrice() {
    final configService = Provider.of<ConfigService>(context, listen: false);
    final carService = Provider.of<CarService>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Icon(Icons.keyboard_backspace, color: Colors.black, size: 30),
            onTap: () => setState(() { openPrice = false; }),
          ),
          Center(
            child: Text('Precio', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Min:'),
              Container(
                width: 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: minController,
                )
              ),
              Text('Max:'),
              Container(
                width: 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: maxController,
                )
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('Aplicar', style: TextStyle(color: Colors.white)),
                color: Color.fromRGBO(49, 39, 79, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))
                ),
                onPressed: () async {
                  final price = {
                    'min': minController.text,
                    'max': maxController.text
                  };

                  await configService.savePrice(jsonEncode(price));
                  carService.update = true;
                  carService.loading = false;

                  if (price['min'] != '' || price['max'] != '')
                    valuePrice = 'De ${price['min'] == '' ? '0' : price['min']} a ${price['max'] == '' ? 'Max' : price['max']}';
                  else
                    valuePrice = 'Cualquiera';

                  setState(() { openPrice = false; });
                }
              ),
              RaisedButton(
                child: Text('Reset', style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1))),
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))
                ),
                onPressed: (){
                  minController.text = '';
                  maxController.text = '';

                  setState((){});
                }
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _generateFilterOrder() {
    final configService = Provider.of<ConfigService>(context, listen: false);
    final carService = Provider.of<CarService>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Icon(Icons.keyboard_backspace, color: Colors.black, size: 30),
            onTap: () => setState(() { openOrder = false; }),
          ),
          Center(
            child: Text('Orden', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ),
          SizedBox(height: 30),
          Column(
            children: menuOrder.entries.map((e) => 
              ListTile(
                title: Text(e.key),
                trailing: Radio(
                  value: e.value,
                  groupValue: group,
                  onChanged: (T) async {
                    setState(() {
                      group = T;
                      valueOrder = menuOrder.keys.elementAt(group - 1);
                    });

                    carService.update = true;
                    carService.loading = false;

                    var v = '-clasification';
                    switch(group) {
                      case 1:
                        v = '-classification';
                      break;
                      case 2:
                        v = 'price';
                      break;
                      case 3:
                        v = '-price';
                      break;
                      case 4:
                        v = 'location desc';
                      break;
                      case 5:
                        v = 'location desc';
                      break;
                      case 6:
                        v = '-createdAt';
                      break;
                    }
                    
                    await configService.saveOrderId(group);
                    await configService.saveOrder(v);
                  },
                ),
              )
            ).toList()
          )
        ]
      )
    );
  }
}