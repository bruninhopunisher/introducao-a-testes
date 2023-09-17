import 'dart:convert';

import 'package:http/http.dart' as http;

class ViaCEP {
  Future <Map<dynamic, dynamic>> retornarCEP (String cep) async {
    var uri = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    var retorno = await http.get(uri);
    var jsonResponse = jsonDecode(retorno.body) as Map;
    print(jsonResponse);
    return jsonResponse;
  }
}