import 'package:flutter/material.dart';
import 'package:rapi_car_app/src/models/car_model.dart';

import '../../../r.g.dart';

class CarList extends StatelessWidget {
  final CarModel data;

  CarList({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left:20, right: 20, bottom: 5, top: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.deepPurple, width: 3)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('${data.brand} ${data.model}', 
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Managua, Nicaragua')
            ),
            _cardPadding(
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _carinfo(data, context),
              )
              
            ),
            Container(height: 3, color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(3))
                  ),
                  child: Text('Reserva desde aqui', style: TextStyle(color: Colors.white),),
                ),
                SizedBox(width: 10),
                Text('\$${data.price}', style: TextStyle(fontSize: 30)),
                Text('/día'),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.deepPurple),
                  onPressed: () {
                    Navigator.pushNamed(context, 'car_detail', arguments: data);
                  },
                )
              ],
            )
          ],
        ),
      );
  }

  Widget _cardPadding(Widget widget) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: widget,
    );
  }

  List<Widget> _carinfo(CarModel data, BuildContext context) {
    final _screenSize =   MediaQuery.of(context).size;
    List<Widget> classification = [];
    for(int i=0; i<5; i++) {
      if (i < data.classification)
        classification.add(Icon(Icons.star, color: Colors.deepPurpleAccent));
      else
        classification.add(Icon(Icons.star, color: Colors.grey[300]));
    }

    var container = [
      Image.network(data.path, width: _screenSize.width * 0.3),
      SizedBox(width: 10),
      Column(
        children: [
          Container(
            width: _screenSize.width * 0.5,
            child:Column(
              children:[ 
                Row(
                  children: [
                    Icon(Icons.forum, color: Colors.deepPurple),
                    Text('200'),
                    SizedBox(width: 10),
                    Image(image:R.image.car_door(), width: 16, color: Colors.deepPurple),
                    Text('5')
                  ]
                )
              ]
            )
          ),
          Container(
            width: _screenSize.width * 0.5,
            child: Row(
              children: classification,
            )
          )
        ],
      )
    ];
      
    return container;
  }
}