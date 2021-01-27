import 'package:flutter/material.dart';
import 'package:rapi_car_app/src/models/car_model.dart';
//import 'package:rapi_car_app/src/pages/car-list/car_list.dart';
import 'package:rapi_car_app/ui/components/drawer_app.dart';

import 'package:rapi_car_app/src/providers/api_car_provider.dart';
import 'package:rapi_car_app/src/providers/local_provider.dart';
import 'package:rapi_car_app/ui/components/app_pages.dart';
import 'package:rapi_car_app/r.g.dart';

class HomeCardPage extends StatefulWidget {
    @override
    _HomeCardPageState createState() => _HomeCardPageState();
}

class _HomeCardPageState extends State<HomeCardPage> with SingleTickerProviderStateMixin {
    String _selectedYear = 'Todos';
    String _selectedBrand = 'Todos';
    String _selectedCity = 'Todos';
    
    @override
    Widget build(BuildContext context) {
      return AppPages(
        drawer: DrawerApp(),
        body: Container(
          child: Column(
            children: <Widget>[
              _containerFiltersWidget(),
              _listCars()
            ],
          )
        )
      );
    }

    Widget _listCars() {
      var localProv = LocalProvider();
      
      return FutureBuilder(
        future: localProv.loadCars(),
        builder: (BuildContext context, AsyncSnapshot<List<CarModel>> snapshot) {
          if(!snapshot.hasData) {
            return Text(_selectedYear);
          }
          return Expanded(child:ListView.builder(
            itemBuilder: (context, index) {
              return _targetItem(data: snapshot.data[index]);
            },
            itemCount: snapshot.data.length,
          ));
        }                
      );
    }

    Widget _dropDownYear() {
      var apiCar = new ApiCarProvider();
      return FutureBuilder(
        future: apiCar.years(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Text(_selectedYear);
          }

          return DropdownButton(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            value: _selectedYear,
            items: snapshot.data.map((value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              print(value);
                    setState(() {
                      _selectedYear = value;
                    });
                  }
          );
        },
      );
    }

    Widget _dropDownBrand() {
      var apiCar = new ApiCarProvider();
      return FutureBuilder(
        future: apiCar.brands(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Text(_selectedYear);
          }

          return DropdownButton(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            value: _selectedBrand,
            items: snapshot.data.map((value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
                    setState(() {
                      _selectedBrand = value;
                    });
                  }
          );
        },
      );
    }

    Widget _dropDownCity() {
      var apiCar = new ApiCarProvider();
      return FutureBuilder(
        future: apiCar.cities(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Text(_selectedYear);
          }

          return DropdownButton(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            value: _selectedCity,
            items: snapshot.data.map((value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  }
          );
        },
      );
    }

    _filterSearch() {
      showDialog(
        context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.close),
                          backgroundColor: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Ciudad: '),
                              _dropDownCity()
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Año: '),
                              _dropDownYear()
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Marca: '),
                              _dropDownBrand()
                            ],
                          )
                        ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Buscar"),
                                  onPressed: () {
                                    //if (_formKey.currentState.validate()) {
                                      //_formKey.currentState.save();
                                    //}
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
    }

    Widget _containerFiltersWidget() {
      return Container(
        margin: EdgeInsets.only(left:30, right: 30, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _filterWidget('Ordenar'),
            _filterWidget('Filtros'),
            _filterWidget('Mapa')
          ],
        )
      );
    }

    Widget _filterWidget(text) {
      return Container(
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
      );
    }

    Widget _targetItem({CarModel data}) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'car_detail', arguments: data);
        },
        child: Container(
          margin: EdgeInsets.only(left:35, right: 35, bottom: 40, top: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  image: NetworkImage(data.path),
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
                      Text('Managua, Nicaragua', style: TextStyle(fontSize: 13, ),),
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
}