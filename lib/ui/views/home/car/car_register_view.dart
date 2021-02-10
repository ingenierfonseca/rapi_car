import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/ui/components/button_app.dart';
import 'package:rapi_car_app/ui/components/card_swiper.dart';
import 'package:rapi_car_app/ui/components/text_field_custom.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/home/car/add_image_item_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CarRegisterView extends StatefulWidget {

  @override
  _CarRegisterViewState createState() => _CarRegisterViewState();
}

class _CarRegisterViewState extends State<CarRegisterView> with WidgetsBindingObserver  {
  Car car = Car();

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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final carService = Provider.of<CarService>(context, listen: false);
    if (carService.isEditOrNew) {
      car = carService.car;
    } else {
      carService.isEditOrNew = true;
      carService.car = car;
    }

    _brandController.text = carService.car.brand;
    _modelController.text = carService.car.model ?? '';
    _passengersController.text = carService.car.passengers != null ? carService.car.passengers.toString() : '';
    _engineController.text = carService.car.engine != null ? carService.car.engine.toString() : '';
    _countryController.text = carService.car.country != null ? carService.car.country.name : '';
    _cityController.text = carService.car.city != null ? carService.car.city.name : '';
    _locationController.text = carService.car.location;
    _priceController.text = carService.car.price != null ? carService.car.price.toString() : '';

    _brandController.addListener(() {
      carService.car.brand = _brandController.text;
    });

    _modelController.addListener(() {
      carService.car.model = _modelController.text;
    });

    _passengersController.addListener(() {
      carService.car.passengers = int.parse(_passengersController.text);
    });

    _engineController.addListener(() {
      carService.car.engine = double.parse(_engineController.text);
    });

    _countryController.addListener(() {
      carService.car.country.id = _countryController.text;
    });

    _cityController.addListener(() {
      carService.car.city.id = _cityController.text;
    });

    _locationController.addListener(() {
      carService.car.location = _locationController.text;
    });

    _priceController.addListener(() {
      carService.car.price = int.parse(_priceController.text);
    });
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final carService = Provider.of<CarService>(context, listen: false);
      car = carService.car;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _brandController.dispose();
    _modelController.dispose();
    _passengersController.dispose();
    _engineController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _locationController.dispose();
    _priceController.dispose();

    final carService = Provider.of<CarService>(context, listen: false);
    carService.car = null;
    carService.loading = false;
    carService.isEditOrNew = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final carService = Provider.of<CarService>(context, listen: true);
    final userService = Provider.of<AuthService>(context, listen: false);

    _countryController.text = 'Nicaragua';
    _cityController.text = 'Masaya';
    _locationController.text = '12.129969, -86.260198';

    return Scaffold(
        appBar: AppBar(
          title: Text('Registro de Vehículo'),
          backgroundColor: Colors.black
        ),
        body: ModalProgressHUD(
        inAsyncCall: carService.loading,
        progressIndicator: CircularProgressIndicator(),
        child:SingleChildScrollView(
        child:Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  car.paths != null ? 
                  CardSwiper(
                    images: car.paths,
                    isFile: !car.paths.contains(car.uui),
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
                child:Form(key: _formKey, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Datos Públicos', style:TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextFieldCustom(placeHolder: 'Marca', textController: _brandController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Modelo', textController: _modelController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Cantidad de personas', textController: _passengersController, keyboardType: TextInputType.number, isValidator: true),
                    SizedBox(height: 20),
                    _dropDowList('Tipo de combustible', _fuelTypeItems, _fuelType),
                    SizedBox(height: 20),
                    _dropDowList('Tipo de transmision', _transmissionTypeItems, _transmissionType),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Motor', textController: _engineController, keyboardType: TextInputType.number, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Pais', textController: _countryController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Ciudad', textController: _cityController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Ubicacion', textController: _locationController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Precio por dia', textController: _priceController, keyboardType: TextInputType.number, isValidator: true),
                    SizedBox(height: 20),
                  ]
                )
              )),
              ButtonApp(text: 'Guardar', callback: carService.loading ? null :() async {
                /*if (car.paths != null) {
                      for (var path in car.paths) {
                          await carService.sendImage('60233aee3b019620b87823b2', path, false);
                      }
                    }*/
                if (_formKey.currentState.validate()) {
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
                    'paths',
                    userService.user.uui
                  );

                  if (response.ok) {
                    carService.loading = true;
                    car.uui = response.data.uui;
                    if (car.paths != null) {
                      for (var path in car.paths) {
                        if (!path.contains(car.uui)) {
                          await carService.sendImage(car.uui, path, false);
                        }
                      }
                    }
                    carService.isEditOrNew = false;
                    carService.loading = false;
                    context.pop();
                  } else {
                    showAlert(context, 'Registro', 'Revise que los datos enviados sean correctos');
                  }
                }
              })
            ],
          )
        )),
      ));
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