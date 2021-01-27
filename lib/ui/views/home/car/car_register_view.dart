import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/src/models/car_model.dart';
import 'package:rapi_car_app/ui/components/button_app.dart';
import 'package:rapi_car_app/ui/components/card_swiper.dart';
import 'package:rapi_car_app/ui/components/text_field_custom.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/home/car/add_image_item_view.dart';

class CarRegisterView extends StatefulWidget {

  @override
  _CarRegisterViewState createState() => _CarRegisterViewState();
}

class _CarRegisterViewState extends State<CarRegisterView> {
  CarModel car = CarModel();

  List<String> _transmissionTypeItems = ['Automatico', 'Mecanico'];
  List<String> _fuelTypeItems = ['Diesel', 'Gasolina'];

  String _fuelType = 'Gasolina';
  String _transmissionType = 'Mecanico';

  TextEditingController _brandController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _passengersController = TextEditingController();
  TextEditingController _engineController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final carService = Provider.of<CarService>(context, listen: false);

    _countryController.text = '6010904b798009665cbed763';
    _cityController.text = 'Managua';
    _locationController.text = '12.129969, -86.260198';

    return Scaffold(
        appBar: AppBar(
          title: Text('Registro de Vehículo'),
          backgroundColor: Colors.black
        ),
        body: SingleChildScrollView(
        child:Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  car.paths != null ? 
                  CardSwiper(
                    images: car.paths,
                  ) :
                  Container(
                    height: _screenSize.height * 0.3,
                    color: Colors.blueGrey,
                  ),
                  Positioned(
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Colors.pinkAccent,
                      //color: Colors.white,,
                      onPressed: () => context.push(page: AddImageItemView()),
                    ),
                    bottom: _screenSize.height * 0.01,
                    right: 0,
                  )
                  
                ],
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 0,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]
                ),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Datos Públicos', style:TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextFieldCustom(placeHolder: 'Marca', textController: _brandController),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Modelo', textController: _modelController),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Cantidad de personas', textController: _passengersController, keyboardType: TextInputType.number),
                    SizedBox(height: 20),
                    _dropDowList('Tipo de combustible', _fuelTypeItems, _fuelType),
                    SizedBox(height: 20),
                    _dropDowList('Tipo de transmision', _transmissionTypeItems, _transmissionType),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Motor', textController: _engineController, keyboardType: TextInputType.number),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Pais', textController: _countryController),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Ciudad', textController: _cityController),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Ubicacion', textController: _locationController),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Precio por dia', textController: _priceController, keyboardType: TextInputType.number),
                    SizedBox(height: 20),
                  ]
                )
              ),
              ButtonApp(text: 'Guardar', callback: carService.loading ? null :() async {
                final response = await carService.create(
                  _brandController.text.trim(), 
                  _modelController.text.trim(), 
                  int.parse(_passengersController.text.trim()), 
                  _fuelType, 
                  _transmissionType, 
                  double.parse(_engineController.text.trim()), 
                  double.parse(_priceController.text.trim()), 
                  _countryController.text.trim(), 
                  _cityController.text.trim(), 
                  _locationController.text.trim(), 
                  'paths'
                );

                if (response) {
                  //
                } else {
                  showAlert(context, 'Registro', 'Revise que los datos enviados sean correctos');
                }
              })
            ],
          )
        )),
      );
  }

  Widget _dropDowList(String label, List<String> listData, String valueChange) {
    return Row(
      children: [
        Text(label),
        Container(child: Expanded(child:
        DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: valueChange,
          items: listData.map((String e) {
            return DropdownMenuItem<String>(
              child: Center(child: Text(e)),
              value: e,
            );
          }).toList(), 
          onChanged: (value) => {
            valueChange = value
          }
        ))))
      ],
    );
  }
}