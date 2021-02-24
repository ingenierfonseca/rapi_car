import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/models/payment.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/core/services/payment_service.dart';
import 'package:rapi_car_app/ui/components/button_app.dart';
import 'package:rapi_car_app/ui/components/card_swiper.dart';
import 'package:rapi_car_app/ui/components/car_widget.dart';
import 'package:rapi_car_app/ui/viewmodels/car_view_model.dart';
import 'package:rapi_car_app/ui/viewmodels/viewmodel_page.dart';
import 'package:rapi_car_app/ui/views/home/payment/payment_form.dart';

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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _swiperTargets(_car),
          carDetailInfo(_car),
          _mapLocation(_screenSize),
          _comment(),
          Divider(color: Colors.black, height: 20),
          ButtonApp(
            text: _car.available ? 'Rentar Ahora' : 'Rentado', 
            isActive: _car.available, 
            callback: _car.available ? () {
              final paymentService = Provider.of<PaymentService>(context, listen: false);
              paymentService.payment = Payment(car: _car.uui);
              context.push(page: PaymentForm(), arguments: _car);
            } : ()=> {})
        ],
      )
    );
  }

  Widget _swiperTargets(Car data) {
    final _screenSize =   MediaQuery.of(context).size;
      return data.paths.length > 0 ? CardSwiper(
        images: data.paths,
      ) : Container (
        height: _screenSize.height * 0.3,
        color: Colors.grey[300],
        child: Center(child: Icon(Icons.camera_alt, size: 100, color: Colors.white)),
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
                  Text('${_car.city.name}, Aproximadamente a ${distance} Km', style:TextStyle(color: Colors.white))
                ],
              )
            ),
          ],
        ),
      )
    );
  }

  Widget _comment() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  image: NetworkImage('https://avatars.githubusercontent.com/u/16735800?s=460&u=c7b12bcf27536fb5bef9c880aaa17d4b0c7ff45d&v=4'),
                  placeholder: R.image.loading_gif(),
                  fit: BoxFit.fill,
                  height: 40,
                ) 
              ),
              SizedBox(width: 10),
              Text('ingenierfonseca@gmail.com', style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 10),
          Text('Super, no los cambio, siempre alquilo ahí, muy responsables. Alquilo en Puerto Rico, y cuando viajo alquilo en Tampa, en la Florida. GRACIAS')
        ],
      ),
    );
  }
}