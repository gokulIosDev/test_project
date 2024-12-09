import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as httpClint;
import 'package:project/App_Exception/app_exception.dart';

class ApiHelper {
  Future<dynamic> getAPI({required String url}) async {
    var uri = Uri.parse(url);
    try {
      var response = await httpClint.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );
      return returnJsonResponse(response);

    } on SocketException catch (ex) {
     throw(FetchDataException(errormsg: "No Internet!"));
    }
  }

  Future<dynamic> postAPI(
      {required String url, Map<String, dynamic>? bodyParams}) async {
    var uri = Uri.parse(url);
    var response = await httpClint.post(uri, body: bodyParams ?? {});
    if (response == 200) {
      var mData = jsonDecode(response.body);

    } else {
      return null;
    }
  }

  dynamic returnJsonResponse(httpClint.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var mData = jsonDecode(response.body);
          return mData;
        }
      case 300:
      case 400:
        throw BadRequestException(errormsg: response.body.toString());
      case 401:
      case 403:
      throw UnauthorizedException(errormsg: response.body.toString());
      case 500:

      case 502:
      default:
      throw FetchDataException(errormsg: "error occur");
    }
  }
}
