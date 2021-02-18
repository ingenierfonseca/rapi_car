import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/r.g.dart';

import 'package:rapi_car_app/global/enviroment.dart';
import 'package:rapi_car_app/ui/views/home/car/car_register_view.dart';

class BussinessCarView extends StatefulWidget {
  static const String id = 'dashboard_app';

  @override
  _BussinessCarViewState createState() => _BussinessCarViewState();
}

class _BussinessCarViewState extends State<BussinessCarView> {
  Size screenSize;
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int currentPage = 0;
  List<Car> listData = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
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
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          final carService = Provider.of<CarService>(context, listen: false);
          carService.car = null;
          carService.loading = false;
          carService.isEditOrNew = false;
          context.push(page: CarRegisterView());
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
        final carService = Provider.of<CarService>(context, listen: false);
        carService.car = null;
        carService.loading = false;
        carService.isEditOrNew = false;
        context.push(page: CarRegisterView(), arguments: data);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    height: screenSize.width * 0.25,
                    width: screenSize.width * 0.25,
                    image: data.paths != null && data.paths.length > 0
                      ? NetworkImage('${Enviroment.carUrl}/${data.paths[0]}')
                      : R.image.no_image_jpg(),
                    placeholder: R.image.loading_gif(),
                    fit: BoxFit.fill,
                  ) 
                ),
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
    final userService = Provider.of<AuthService>(context, listen: false);
    if (currentPage == 0) {
      final data = await carService.getUserAll(userService.user.uui, page: (currentPage + 1).toString());
        _loadMore(data.car);
    } else {
      final data = await carService.getUserAll(userService.user.uui, page: (currentPage + 1).toString());
        _loadMore(data.car);
    }
  }
}