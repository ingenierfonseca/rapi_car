import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/services/app_service.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/ui/views/home/car/car_detail.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/ui/views/home/dashboard_pages/filter_map_view.dart';
import 'package:rapi_car_app/ui/views/permission/access_gps_view.dart';

import 'package:rapi_car_app/global/enviroment.dart';

class DashboardApp extends StatefulWidget {
  static const String id = 'dashboard_app';

  @override
  _DashboardAppState createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  Size screenSize;
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int currentPage = 0;
  List<Car> listData = [];

  String filterType = '';
  Map<String, Color> menuNav = {
    'Automovil': Colors.grey,
    'Camioneta': Colors.grey,
    'Suv': Colors.grey,
    'Otros': Colors.grey,
    'Todos': Colors.white
  };

  @override
  void initState() {
    super.initState();
    final carService = Provider.of<CarService>(context, listen: false);

    if (carService.update) {
      carService.currentPage = 0;
      carService.listData.clear();
    } else if (carService.currentPage == 0) {
      carService.update = true;
    }

    currentPage = carService.currentPage;
    listData = carService.listData;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchData(context, true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carService = Provider.of<CarService>(context, listen: false);
    screenSize =   MediaQuery.of(context).size;
    if (carService.update && !carService.loading) {
      _fetchData(context, false);
    }

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.white,//Color(0xffF2F2F2),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _typeCarFilter(),
            //_containerFiltersWidget(),
            Expanded(
              child: Stack(
                children: [
                  _listCars(),
                  _loading()
                ],
              )
            )
          ],
        )
      )      
    );
  }

  Widget _typeCarFilter() {
    return Container(
      color: Colors.black,
      //height: 3,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left:30, right: 30, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: menuNav.entries.map((entry) {
          return _textFilterWidget(entry.key);
        }).toList()
      )
    );
  }

  Widget _textFilterWidget(String label) {
    final carService = Provider.of<CarService>(context, listen: false);

    return GestureDetector(
      child: Text(label, style: TextStyle(color: menuNav[label])),
      onTap: () {
        if (filterType == label) return;

        carService.currentPage = 0;
        carService.listData.clear();
        carService.update = true;
        setState(() {
          currentPage = 0;
          listData.clear();
          filterType = label;
          filterType = label == 'Todos' ? '' : filterType;
        });

        if (filterType == '') {
          menuNav.forEach((key, value) {
            if (key == 'Todos')
              menuNav.update(key, (value) => Colors.white);
            else
              menuNav.update(key, (value) => Colors.grey);
          });
        } else {
          menuNav.forEach((key, value) {
            if (key == label)
              menuNav.update(key, (value) => Colors.white);
            else
              menuNav.update(key, (value) => Colors.grey);
          });
        }
        
        setState(() {});
        _fetchData(context, false);
      },
    );
  }

  Widget _containerFiltersWidget() {
    return Container(
      margin: EdgeInsets.only(left:4, right: 4, top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _filterWidget('Vehiculod', null),
          _filterWidget('Camionetas', null),
          _filterWidget('Suv', null),
          _filterWidget('Otros', null),
          _filterWidget('Filtros', () => context.push(page: AccessGpsView())),
          _filterWidget('Mapa', () => context.push(page: FilterMapView(), arguments: LatLng(12.128264, -86.264012)))
        ],
      )
    );
  }

  Widget _filterWidget(text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
        ),
        child: Text(text, style: TextStyle(fontSize: 11, color: Colors.black)),
      )
    );
  }

  Widget _listCars() {
    return ListView.builder(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _targetItem(data: listData[index]);
      },
      itemCount: listData.length,
    );
  }

  Widget _loading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 15)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _targetItem({Car data}) {
    return GestureDetector(
      onTap: () {
        context.push(page: CarDetail(), arguments: data);
      },
      child: Container(
        margin: EdgeInsets.only(left:35, right: 35, bottom: 40, top: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: data.paths != null && data.paths.length > 0 ? FadeInImage(
                height: screenSize.height * 0.25,
                width: screenSize.width,
                image: NetworkImage('${Enviroment.carUrl}/${data.paths[0]}'),
                placeholder: R.image.loading_gif(),
                fit: BoxFit.fill,
              ) : Container(
                height: screenSize.height * 0.25,
                width: screenSize.width,
                color: Colors.grey[300],
                child: Icon(Icons.camera_alt, size: 100, color: Colors.white)
              )
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.brand, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('${data.model}', 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    Text('${data.city.name}, ${data.country.name}', style: TextStyle(fontSize: 13, ),),
                    Row(
                      children: [
                        Text('AC', style: TextStyle(fontWeight: FontWeight.bold, color: data.airConditioner ? Colors.blue : Colors.grey[300])),
                        SizedBox(width: 10),
                        Icon(Icons.bluetooth, size: 13, color: data.bluetooth ? Colors.blue : Colors.grey[300]),
                        SizedBox(width: 10),
                        Icon(Icons.music_video, size: 13, color: data.bluetooth ? Colors.blue : Colors.grey[300]),
                        SizedBox(width: 10),
                        Icon(Icons.star, size: 13, color: Colors.red),
                        Text(data.classification.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                ),
                Container(
                  width: 100,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
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
                      Text('el día desde', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                      Text('\$${data.price}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                    ]
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Future<List<Car>> _loadMore(List<Car> data) async {
    final carService = Provider.of<CarService>(context, listen: false);

    if (data.length > 0) {
      listData.addAll(data);
      currentPage++;
      carService.currentPage = currentPage;
      carService.listData = listData;
    }
    carService.update = false;
    _isLoading = false;
    setState(() {});
    return listData;
  }

  Future _fetchData(BuildContext context, bool isScroll) async {
    _isLoading = true;
    setState(() {});

    final params = await generateFilters(isScroll);

    final carService = Provider.of<CarService>(context, listen: false);
    
    if (currentPage == 0) {
      final data = await carService.getAll(page: (currentPage + 1).toString(), filters: params);
      
      _loadMore(data.car);
    } else {
      final data = await carService.getAll(page: (currentPage + 1).toString(), filters: params);
      
      _loadMore(data.car);
    }
  }

  Future generateFilters(bool isScroll) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    if (filterType != '' && !isScroll)
      params['type'] = filterType;
    
    final filterPrice = await AppService.getPrice();
    if (filterPrice != null) {
      final filterPriceJson = jsonDecode(filterPrice);
      if (filterPriceJson['min'] != '' || filterPriceJson['max'] != '') {
        params['priceMin'] = filterPriceJson['min'] == '' ? 0 : double.parse(filterPriceJson['min']);
        params['priceMax'] = filterPriceJson['max'] == '' ? 0 : double.parse(filterPriceJson['max']);
      }
    }

    final filterOrder = await AppService.getOrder();
    if (filterOrder != null) {
      params['order'] = filterOrder;
    }

    return params;
  }
}