import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/ui/views/home/car/car_detail.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/ui/views/home/dashboard_pages/filter_map_view.dart';
import 'package:rapi_car_app/ui/views/permission/access_gps_view.dart';

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

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_){
      //_loadInitData(context);
    //});

    _scrollController.addListener(() {
      print('scrollController');
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchData(context);
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
    screenSize =   MediaQuery.of(context).size;
    if (currentPage == 0) {
      _fetchData(context);
    }

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body:Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _containerFiltersWidget(),
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

  Widget _containerFiltersWidget() {
    return Container(
      margin: EdgeInsets.only(left:30, right: 30, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _filterWidget('Ordenar', null),
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
    /*return FutureBuilder(
      future: _fetchData(context),
      builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
        if(!snapshot.hasData) {
          return Text('no data');
        }*/
        return ListView.builder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _targetItem(data: listData[index]);
          },
          itemCount: listData.length,
        );
      //}                
    //);
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
              child: FadeInImage(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                image: NetworkImage(data.paths[0]),
                placeholder: R.image.loading_gif(),
                fit: BoxFit.fill,
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
                    Text('${data.cityId}, ${data.countryId}', style: TextStyle(fontSize: 13, ),),
                    Row(
                      children: [
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
    listData.addAll(data);
    currentPage++;
    _isLoading = false;
    setState(() {});
    return listData;
  }

  Future _fetchData(BuildContext context) async {
    _isLoading = true;
    setState(() {});

    final carService = Provider.of<CarService>(context, listen: false);
    if (currentPage == 0) {
      final data = await carService.getAll(page: (currentPage + 1).toString());
      //if (currentPage + 1 <= data.totalPages) {
        _loadMore(data.car);
      //} return;
    } else {
      final data = await carService.getAll(page: (currentPage + 1).toString());
      /*_scrollController.animateTo(
        _scrollController.position.pixels + 100, 
        duration: Duration(milliseconds: 250), 
        curve: Curves.fastOutSlowIn
      );*/

      //if (currentPage + 1 <= data.totalPages) {
        _loadMore(data.car);
      ///} return;
    }
  }
}