import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:rapi_car_app/r.g.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> images;

  CardSwiper({ @required this.images });

  @override
  Widget build(BuildContext context) {
    final _screenSize =   MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.4,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            images[index],
            fit: BoxFit.fitWidth,
          );
        },
        itemWidth: 300,
        itemHeight: 200,
        itemCount: images.length,
        //viewportFraction: 0.8,
        //scale: 0.9,
        //layout: SwiperLayout.TINDER,
        pagination: SwiperPagination(),
        //indicatorLayout: PageIndicatorLayout.COLOR,
        //control: SwiperControl()
      )
        //padding: EdgeInsets.only(top: 10),
        /*child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.3,
          itemBuilder: (BuildContext context, int index) {
            //return ClipRRect(
              //borderRadius: BorderRadius.circular(20.0),
              return /*child:*/ FadeInImage(
                image: NetworkImage(images[index]),
                placeholder: R.image.loading_gif(),
                fit: BoxFit.fill,
              ); 
            //);
          },
          itemCount: images.length,
          //indicatorLayout: PageIndicatorLayout.COLOR,
          //pagination: SwiperPagination(alignment: Alignment.bottomCenter),
          viewportFraction: 0.8,
          scale: 0.9
          //control: SwiperControl()
        )*/
      );
  }
}