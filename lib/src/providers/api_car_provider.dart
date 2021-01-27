import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCarProvider {
  final String _url = 'http://api.carmd.com';
  final String _partnerToken = '05d02dbcc8db4d1f8f224cb2d4d96b1a';
  final String _authorization = 'Basic MjI3ZjdkMmEtYjBiNi00OWQ4LWI1ODMtZDM0MWJjNTJlN2Fi';

    Future<List<dynamic>> years() async {
        final url = '$_url/v3.0/year';

        final response = await http.get(url, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'authorization': _authorization,
            'partner-token': _partnerToken
        });

        //final Map<String, dynamic> decodeData = json.decode(response.body);

        List<dynamic> data = new List();
        data.addAll(['Todos', '2015', '2016', '2017', '2018', '2019', '2020']);

        //print(decodeData);
        /*decodeData.forEach((key, value) {
            //value.foreach
            if (key == 'data') {
                data = value;
            }
        });*/
        //print(data);

        return data;
    }

    Future<List<dynamic>> brands() async {
        final url = '$_url/v3.0/year';

        final response = await http.get(url, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'authorization': _authorization,
            'partner-token': _partnerToken
        });

        //final Map<String, dynamic> decodeData = json.decode(response.body);

        List<dynamic> data = new List();
        data.addAll(['Todos', 'Nissan', 'Toyota', 'yaris', 'Kia', 'Mitsubishi', 'Suzuki']);

        //print(decodeData);
        /*decodeData.forEach((key, value) {
            //value.foreach
            if (key == 'data') {
                data = value;
            }
        });*/

        return data;
    }

    Future<List<dynamic>> cities() async {
        final url = '$_url/v3.0/year';

        final response = await http.get(url, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'authorization': _authorization,
            'partner-token': _partnerToken
        });

        //final Map<String, dynamic> decodeData = json.decode(response.body);

        List<dynamic> data = new List();
        data.addAll(['Todos', 'Leon', 'Managua', 'Masaya', 'Rivas', 'Carazo', 'Granada']);

        //print(decodeData);
        /*decodeData.forEach((key, value) {
            //value.foreach
            if (key == 'data') {
                data = value;
            }
        });*/

        return data;
    }
}