import 'package:flutter/material.dart';
import 'package:rapi_car_app/src/models/car_model.dart';

import '../../r.g.dart';

class CarSwiperHorizontal extends StatelessWidget {
  final CarModel car;

  CarSwiperHorizontal({@required this.car});

  @override
  Widget build(BuildContext context) {
    //final _screenSize = MediaQuery.of(context).size;
    car.paths.add(car.path);
    car.paths.add(car.path);
    car.paths.add(car.path);
    car.paths.add(car.path);
    return Container(
      margin: EdgeInsets.only(top:10),
      height: 110,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _targets(),
      ),
    );
  }

  List<Widget> _targets() {
    return car.paths.map((path) {
      //print(path);
      return Container(
        margin: EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child:
            FadeInImage(
              image: path.contains('https') ? NetworkImage(path) : AssetImage(path),
              placeholder: R.image.no_image_jpg(),
              fit: BoxFit.cover,
              height: 100,
            ))
          ],
        ),
      );
    }).toList();
  }
}