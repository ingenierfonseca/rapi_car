import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/models/response/car_response.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/models/city.dart';
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
  List<String> _carTypeItems = ['Automovil', 'Camioneta', 'Suv', 'Moto', 'Otros'];

  String _fuelType = 'Gasolina';
  String _transmissionType = 'Mecanico';
  String _carType = 'Automovil';
  String _year = DateTime.now().year.toString();
  bool _airConditioner = false;
  bool _musicPlayer = false;
  bool _bluetooth = false;

  TextEditingController _typeController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _passengersController = TextEditingController();
  TextEditingController _engineController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _mileageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final carService = Provider.of<CarService>(context, listen: false);
    final userService = Provider.of<AuthService>(context, listen: false);

    if (carService.isEditOrNew) {
      car = carService.car;
    } else {
      final carArg = context.getArguments();

      if (carArg == null) {
        carService.isEditOrNew = true;
        car.country = City();
        car.city =City();
        car.user = userService.user.uui;
        car.fuelType = _fuelType;
        car.transmissionType = _transmissionType;
        car.year = _year;
        car.airConditioner = false;
        car.musicPlayer = false;
        car.bluetooth = false;
        car.country.id = '602309bac41c0953e41b1feb';
        car.city.id = '60230b4c244b1a22207cede4';
        car.paths = [];
      } else {
        car = carArg;
        _carType = car.type;
        _year = car.year;
        _transmissionType = car.transmissionType;
        _fuelType = car.fuelType;
        _airConditioner = car.airConditioner;
        _musicPlayer = car.musicPlayer;
        _bluetooth = car.bluetooth;
      }
      carService.car = car;
    }

    _typeController.text = car.type;
    _brandController.text = car.brand;
    _modelController.text = car.model ?? '';
    _passengersController.text = car.passengers != null ? car.passengers.toString() : '';
    _engineController.text = car.engine != null ? car.engine.toString() : '';
    _countryController.text = car.country != null ? car.country.name : '';
    _cityController.text = car.city != null ? car.city.name : '';
    _locationController.text = car.location;
    _priceController.text = car.price != null ? car.price.toString() : '';
    _mileageController.text = car.mileage != null ? car.mileage.toString() : '';

    _typeController.addListener(() {
      carService.car.type = _typeController.text;
     });

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
      //carService.car.country.id = _countryController.text;
    });

    _cityController.addListener(() {
      //carService.car.city.id = _cityController.text;
    });

    _locationController.addListener(() {
      carService.car.location = _locationController.text;
    });

    _priceController.addListener(() {
      carService.car.price = int.parse(_priceController.text);
    });

    _mileageController.addListener(() {
      carService.car.mileage = int.parse(_mileageController.text);
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
    _typeController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _passengersController.dispose();
    _engineController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _mileageController.dispose();

    final carService = Provider.of<CarService>(context, listen: false);
    carService.car = null;
    carService.loading = false;
    //carService.isEditOrNew = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final carService = Provider.of<CarService>(context, listen: true);

    _countryController.text = 'Nicaragua';
    _cityController.text = 'Masaya';
    _locationController.text = '12.129969, -86.260198';

    return Scaffold(
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
                  car.paths != null && car.paths.length > 0 ? 
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
                      child: Icon(Icons.camera_alt),
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
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                child: _dropDowList('Tipo de vehiculo', _carTypeItems, _carType, carService.car),
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
                    Text(_carType, style:TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextFieldCustom(placeHolder: 'Marca', textController: _brandController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Modelo', textController: _modelController, isValidator: true),
                    SizedBox(height: 20),
                    _dropDowList('Año', List<String>(), _year, carService.car),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Pasajeros', textController: _passengersController, keyboardType: TextInputType.number, isValidator: true),
                    SizedBox(height: 20),
                    _dropDowList('Tipo de combustible', _fuelTypeItems, _fuelType, carService.car),
                    SizedBox(height: 20),
                    _dropDowList('Tipo de transmision', _transmissionTypeItems, _transmissionType, carService.car),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Motor', textController: _engineController, keyboardType: TextInputType.number, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Pais', textController: _countryController, isValidator: true, enabled: false),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Ciudad', textController: _cityController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Ubicacion', textController: _locationController, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Precio por dia', textController: _priceController, keyboardType: TextInputType.number, isValidator: true),
                    SizedBox(height: 20),
                    TextFieldCustom(placeHolder: 'Kilometraje', textController: _mileageController, keyboardType: TextInputType.number, isValidator: true),
                    SizedBox(height: 20),
                    _checkBox(_airConditioner, 'Aire acondicionado', carService.car),
                    _checkBox(_musicPlayer, 'Reproductor de musica', carService.car),
                    _checkBox(_bluetooth, 'Bluetooth', carService.car)
                  ]
                )
              )),
              ButtonApp(text: 'Guardar', callback: carService.loading ? null :() async {
                if (_formKey.currentState.validate()) {
                  CarResponse response;
                  if (car.uui == null) {
                    response = await carService.create(car);
                  } else {
                    response = await carService.edit(car);
                  }

                  if (response.ok) {
                    car.uui = response.data.uui;
                    if (car.paths != null) {
                      carService.loading = true;
                      for (var path in car.paths) {
                        if (!path.contains(car.uui)) {
                          await carService.sendImage(car.uui, path, false);
                        }
                      }
                    }
                    carService.isEditOrNew = false;
                    carService.loading = false;
                    carService.update = true;
                    context.pop();
                  } else {
                    carService.loading = false;
                    showAlert(context, 'Registro', 'Revise que los datos enviados sean correctos');
                  }
                }
              })
            ],
          )
        )),
      ));
  }

  Widget _dropDowList(String label, List<String> listData, String valueChange, Car car) {
    if (label == 'Año') {
      final now = DateTime.now();
      listData.clear();
      for (int i = now.year - 7; i <= now.year; i++) {
        listData.add(i.toString());
      }
    }

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
            setState(() {
              switch(label) {
                case 'Tipo de vehiculo':
                  _carType = value;
                  car.type = _carType;
                break;
                case 'Tipo de combustible':
                  _fuelType = value;
                  car.fuelType = _fuelType;
                break;
                case 'Tipo de transmision':
                  _transmissionType = value;
                  car.transmissionType = _transmissionType;
                break;
                case 'Año':
                  _year = value;
                  car.year = _year;
                break;
              }
            })
          }
        ))))
      ],
    );
  }

  Widget _checkBox(bool val, String text, Car car) {
    return Row(
      children: [
        Checkbox(
          value: val,
          onChanged: (value) {
            setState(() {
              switch(text) {
                case 'Aire acondicionado':
                  _airConditioner = !_airConditioner;
                  car.airConditioner = _airConditioner;
                break;
                case 'Reproductor de musica':
                  _musicPlayer = !_musicPlayer;
                  car.musicPlayer = _musicPlayer;
                break;
                case 'Bluetooth':
                  _bluetooth = !_bluetooth;
                  car.bluetooth = _bluetooth;
                break;
              }
            });
          }
        ),
        Text(text)
      ],
    );
  }
}