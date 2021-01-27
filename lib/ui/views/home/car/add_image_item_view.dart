import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rapi_car_app/ui/components/button_app.dart';
import 'package:rapi_car_app/src/models/car_model.dart';

class AddImageItemView extends StatefulWidget {
  AddImageItemView({Key key}) : super(key: key);

  @override
  _AddImageItemViewState createState() => _AddImageItemViewState();
}

class _AddImageItemViewState extends State<AddImageItemView> {
  CarModel car = CarModel();
  List<File> _images = List(6);
  final picker = ImagePicker();
  int indexPath = 0;

  List<String> paths = List.from(['','','','','','','']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Fotos de portada'),
          backgroundColor: Colors.black
      ),
      body: Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Subir fotos del vehículo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Text('0/6', style: TextStyle(fontSize: 11))
              ]
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _containerImage(0),
                _containerImage(1)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _containerImage(2),
                _containerImage(3)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _containerImage(4),
                _containerImage(5)
              ],
            ),
            SizedBox(height: 60),
            ButtonApp(text: 'Guardar', callback: (){})
          ],
        ),
      ),
    );
  }

  Widget _containerImage(int index) {
    final _screenSize = MediaQuery.of(context).size;
    final _width = (_screenSize.width - 70) / 2; 

    return GestureDetector(
        onTap: () => _showPicker(context, index),
        child: Container(
          width: _width,
          height: _width * 0.6,
          color: Colors.blueGrey,
          child: paths[index] == '' 
          ? Center(
            child: Icon(Icons.add, color: Colors.white),
          )
          : paths[index].contains('http') ? Image.network(
            paths[index],
            fit: BoxFit.fitWidth,
          ) : Image.file(_images[index], fit: BoxFit.fitWidth)
        )
    );
  }

  Future _imgFromGallery(int index) async {
    setState(() {
      indexPath = index;
    });

    _processImage(ImageSource.gallery);
  }

  Future _imgFromCamera(int index) async {
    setState(() {
      indexPath = index;
    });

    _processImage(ImageSource.camera);
  }

  Future _processImage(ImageSource type) async {
    final pickedFile = await picker.getImage(source: type);

    setState(() {
      if (pickedFile != null) {
        _images[indexPath] = File(pickedFile.path);
        paths[indexPath] = _images[indexPath].path;
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _imgFromCamera(index);
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}