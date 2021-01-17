import 'dart:convert';

import 'package:http/http.dart' as http;

class Validate {
  final log;
  final pass;

  final apiUrlLogIn =
      'https://trello.backend.tests.nekidaem.ru/api/v1/users/login/';

  Validate({this.log, this.pass});

  Future<dynamic> validate() async {
    try {
      return await http.post(apiUrlLogIn,
          body: {'username': '$log', 'password': '$pass'}).then((data) {
        if (data.statusCode == 200) {
          final jsonDataToken = json.decode(data.body); // работает
          final userToken = jsonDataToken['token'];
          var returnToken = [];
          returnToken.add(data.statusCode);
          returnToken.add(userToken);
          return returnToken;
        } else if (data.statusCode == 400) {
          final errorData = utf8.decode(data.bodyBytes);
          var jsMap = jsonDecode(errorData);
          var error = [];
          
          error.add(data.statusCode);
          error.add(jsMap); //
          
          return error;
        }
      });
    } catch (e) {
          var error = [];         
          error.add('conect');
          error.add('$e'); //
      return error;
    }
  }
}