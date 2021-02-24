import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/models/payment.dart';

Widget carDetailInfo(Car data, {bool showPrice = true}) {
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
            Text('${data.passengers} pasajeros'),
            Text('${data.fuelType}'),
            Text('${data.transmissionType}'),
            Text('Motor ${data.engine}'),
            SizedBox(height: 5),
            clasificationWidget(data.classification),
            Row(
              children: [
                Text('Aire acondicionado'),
                data.airConditioner ? Icon(Icons.done, color: Colors.pinkAccent) : Icon(Icons.not_interested),
              ],
            ),
            Row(
              children: [
                Text('Reproductor de musica'),
                data.musicPlayer ? Icon(Icons.done, color: Colors.pinkAccent) : Icon(Icons.not_interested),
              ],
            ),
            Row(
              children: [
                Text('Bluetooth'),
                data.bluetooth ? Icon(Icons.done, color: Colors.pinkAccent) : Icon(Icons.not_interested),
              ],
            )
          ],
        ),
        showPrice ? _priceWidget(data.price) : Container()
      ]
    )
  );
}

Widget clasificationWidget(int numStart){
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

  Widget _priceWidget(int price) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
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
          Text('\$${price}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ]
      ),
    );
  }

Widget rentCarDetailInfo(Car data, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 30, top: 20, bottom: 20),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemDetailRent('Marca:', data.brand, context),
            _itemDetailRent('Modelo:', data.model, context),
            _itemDetailRent('Pasajeros:', data.passengers.toString(), context),
            _itemDetailRent('Combustible:', data.fuelType, context),
            _itemDetailRent('Transmisión:', data.transmissionType, context),
            _itemDetailRent('Motor:', data.engine.toString(), context),
            _itemIconDetailRent('Aire acondicionado', data.airConditioner, context),
            _itemIconDetailRent('Reproductor de musica', data.musicPlayer, context),
            _itemIconDetailRent('Bluetooth', data.bluetooth, context),
            _itemDetailRent('Precio por día:', '\$${data.price}', context),
          ],
        ),
      ]
    )
  );
}

Widget rentCarDetailInfoResume(Car data, Payment payment, double priceDriveInclude, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 30, top: 20, bottom: 20),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemDetailRent('Marca:', data.brand, context),
            _itemDetailRent('Modelo:', data.model, context),
            _itemDetailRent('Pasajeros:', data.passengers.toString(), context),
            _itemDetailRent('Combustible:', data.fuelType, context),
            _itemDetailRent('Transmisión:', data.transmissionType, context),
            _itemDetailRent('Motor:', data.engine.toString(), context),
            _itemIconDetailRent('Aire acondicionado', data.airConditioner, context),
            _itemIconDetailRent('Reproductor de musica', data.musicPlayer, context),
            _itemIconDetailRent('Bluetooth', data.bluetooth, context),
            _itemDetailRent('Precio por día:', '\$${data.price}', context),
            _itemDetailRent('Cantidad de días:', '\$${payment.countDays}', context),
            _itemDetailRent('Precio por chofer incluido:', '\$${priceDriveInclude}', context),
          ],
        ),
      ]
    )
  );
}

Widget _itemDetailRent(String label, String value, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width -(130),
    height: 25,
    child: Stack(
      children: [
        Positioned(child: Text(label),),
        Positioned(child: Text(value, style: TextStyle(fontWeight: FontWeight.bold)), right: 0),
      ],
    )
  );
}

Widget _itemIconDetailRent(String label, bool value, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width -(130),
    height: 25,
    child: Stack(
      children: [
        Positioned(child: Text(label),),
        Positioned(child: value ? Icon(Icons.done, color: Colors.pinkAccent) : Icon(Icons.not_interested), right: 0),
      ],
    )
  );
}