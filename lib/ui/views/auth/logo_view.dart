import 'package:flutter/material.dart';
import 'package:rapi_car_app/r.g.dart';

class LogoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double height = 300;

    return Container(
      height: height,
      color: Color.fromRGBO(49, 39, 79, 1),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: -10,
            child: Container(
              height: 100,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              )
            ),
          )
        ]
      )
                  /*Positioned(child: _circle(400), top: -100, left: -120),
                  Positioned(child: _circle(400), top: -160, right: -120),
                  Positioned(
                    top: -40,
                    height: height,
                    width: width,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: R.image.background(),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    height: height,
                    width: width+20,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: R.image.background(),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  )
                ]
              )*/
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color.fromRGBO(49, 39, 79, 1),
        borderRadius: BorderRadius.circular(size/2)
      ),
    );
  }
}