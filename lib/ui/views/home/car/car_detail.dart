import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/ui/components/button_app.dart';
import 'package:rapi_car_app/ui/components/card_swiper.dart';
import 'package:rapi_car_app/ui/viewmodels/car_view_model.dart';
import 'package:rapi_car_app/ui/viewmodels/viewmodel_page.dart';
import 'package:rapi_car_app/ui/views/home/payment/payment_view.dart';

import '../../../../r.g.dart';

class CarDetail extends StatefulWidget with ViewModelPage<CarViewModel> {
  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  CarViewModel _viewModel;
  Car _car;
  int distance = 20;

  @override
  void initState() {
    super.initState();
    _viewModel = context.getViewModel();
    _car = context.getArguments();
    //_viewModel.selectedCar = _car;
    _viewModel.getServices();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize =   MediaQuery.of(context).size;

    return Scaffold(
        /*appBar: AppBar(
          title: Text('${_car.brand} ${_car.model}'),
          backgroundColor: Colors.black
        ),*/
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _swiperTargets(_car),
                _itemInfo(_car),
                _mapLocation(_screenSize),
                Divider(color: Colors.black, height: 20),
                ButtonApp(text: _car.available ? 'Reservar' : 'Reservado', isActive: _car.available, callback: ()=> _car.available ? context.push(page: PaymentView()) : {})
              ],
            )
          )
        ),
      );
  }

  Widget _swiperTargets(Car data) {
      return CardSwiper(
        images: data.paths,
      );
  }

  Widget _itemInfo(Car data) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(data.brand),
              SizedBox(height: 5),
              Text(data.model, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('Capacidad ${_car.passengers} pasajeros'),
              Text('Combustible ${_car.fuelType}'),
              Text('Tramsmisión ${_car.transmissionType}'),
              Text('Motor ${_car.engine}'),
              SizedBox(height: 5),
              clasificationWidget(data.classification)
              /*Row(
                children: [
                  for(var i = 0; i < data.classification; i++){
                  return Icon(Icons.star, size: 15, color: Colors.pinkAccent);
                  //Text(data.classification.toString())
                  }
                ],
              )*/
            ],
          ),
          _priceWidget()
        ]
      )
    );
  }

  Widget clasificationWidget(int numStart)
  {
    List<Widget> list = new List<Widget>();
    var dif = 10 - numStart;

    for(var i = 0; i < numStart; i++){
      list.add(Icon(Icons.star, size: 15, color: Colors.pinkAccent));
    }

    for (var j=0; j < dif; j++) {
      list.add(Icon(Icons.star, size: 15, color: Colors.grey));
    }

    return new Row(children: list);
  }

  Widget _priceWidget() {
    return Container(
      //width: 100,
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      margin: EdgeInsets.only(bottom: 10, left: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child: Column(
        children: [
          Text('el día desde', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text('\$${_car.price}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ]
      ),
    );
  }

  Widget _mapLocation(Size _screenSize) {
    return Center(
      child:Container(
        height: 150,
        margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: Stack(
          children: [
            Image(image: R.image.backgroun_location(), fit: BoxFit.fitWidth, width: _screenSize.width),
            Container(
              margin: EdgeInsets.only(left: 60, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ubicación', style:TextStyle(color: Colors.white)),
                  Text('${_car.cityId}, Aproximadamente a ${distance} Km', style:TextStyle(color: Colors.white))
                ],
              )
            ),
            /*Positioned(
              bottom: 40,
              left: 60,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'map_location', arguments: LatLng(37.810575, -122.477174));
                },
                child:Container(
                  //width: 70,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.pinkAccent
                  ),
                  child: Row(
                    children: [
                      Text('Ver Lugar', style: TextStyle(color: Colors.white)),
                      Icon(Icons.keyboard_arrow_right, size: 18, color: Colors.white)
                    ]
                  ),
                )
              )
            )*/
          ],
        ),
      )
    );
    /*return MapboxMap( 
      accessToken: ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(37.810575, -122.477174),
        zoom: 14
      ),
    );*/

    /*return Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          SizedBox(height: 10),
          Text('Ubicación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(37.810575, -122.477174),
                zoom: 14
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: LatLng(37.810575, -122.477174),
                      builder: (ctx) =>
                      Container(
                        child: Image(image: R.image.location_mark()),
                      ),
                    ),
                  ],
                ),
              ]
            )
          )
        ]
      )
    );*/
  }
}