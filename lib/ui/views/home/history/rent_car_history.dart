import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/res/colors.dart';
import 'package:rapi_car_app/ui/util/decoration_util.dart';


class RentCarHistory extends StatelessWidget {
  const RentCarHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 20,
                bottom: 10),
            child: Text("Historial Transacciones",
                textAlign: TextAlign.left,
                //style: customStyleBold(16.0.sf(), 0.21, Colors.black)
            ),
          ),
          //SizedBox(height: 10.0),
          Expanded(child: _createListHistory()),

          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> _transactions() async {
    await Future.delayed(Duration(seconds: 10));
    List<dynamic> list = [];
    return list;
  }

  Widget _createListHistory() {
    return FutureBuilder(
      future: _transactions(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Ocurrió un error al traer los datos :(',
            style: Theme.of(context).textTheme.headline5,
          );
        } else if (snapshot.hasData) {
          final histories = snapshot.data;
          // print('cantidad de datos ' + histories.length.toString());

          if (histories.length > 0) {
            //Si hay registros
            return Column(
              children: <Widget>[
                //_createHeaderHistory(),
                Expanded(
                  child: ListView.builder(
                    itemCount: histories.length,
                    itemBuilder: (context, i) =>
                        _itemHistory(context, histories[i]),
                  ),
                )
              ],
            );
          } else {
            return _generateNoRegisters();
          }
        } else {
          return Center(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text("Obteniendo historial de transacciones",
                  //style: customStyle(16.0.sf(), 1.77, Colors.black)
              ),
              SizedBox(
                height: 10.0,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey,
              )
            ],
          ));
        }
      },
    );
  }

  Widget _itemHistory(BuildContext context, Map history) {
    return Container(
      margin:
          EdgeInsets.only(left: 30, right: 30, top: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text("${history['operation_type']}",
                //style:
                    //customStyle(14.0.sf(), 0.19, BiccosColors.biccosBlueColor)
            ),
          ),
          Expanded(
            child: Text('\$ ${history["total"].toString()}',
                //style:
                    //customStyle(14.0.sf(), 0.19, BiccosColors.biccosBlueColor)
            ),
          ),
          FlatButton(
            onPressed: () {
              //context.push(screen: DetailOperation(), arguments: history);
            },
            child: Text('Ver', /*style: styleHistoryLink*/),
          )
        ],
      ),
    );
  }

  Widget _generateNoRegisters() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 50),
      child: Center(
          child: Column(
        children: <Widget>[
          Icon(
            Icons.assignment,
            size: 50,
            color: AppColors.biccosGrayColor,
          ),
          Text(
            "Usted no tiene registros en este momento",
            //style: customStyle(15, 0, AppColors.biccosBlueColor),
          ),
        ],
      )),
    );
  }
}