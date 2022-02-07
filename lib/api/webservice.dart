import 'dart:convert';
import 'package:covid_tracer/api/header.dart';
import 'package:covid_tracer/model/model.dart';
import 'package:http/http.dart' as http;

Future<Model> fetch() async {
//
//   Your api key should looks like these
//   final header = {
//   'x-rapidapi-key': 'YOURAPIKEY',
//   'x-rapidapi-host': 'YOURAPIKEY'
// };
//

  final url =
      Uri.parse('https://covid-19-data.p.rapidapi.com/country?name=indonesia');
  final resp = await http.get(
    url,
    headers: header,
  );

  if (resp.statusCode == 200) {
    return Model.fromJson(jsonDecode(resp.body)[0]);
  } else {
    throw Exception('Failed to load data');
  }
}
