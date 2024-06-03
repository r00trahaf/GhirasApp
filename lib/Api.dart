import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<http.Response> checkImageType({
    bool isImageFromCamera = false,
    required dynamic? imageData,
  }) async {
    try {
      String url =
          "http://172.20.10.3:8000/predict";
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      String? result;
      var request = http.MultipartRequest('POST', Uri.parse(url));

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var file = await imageData.readAsBytes();
      var fileName = imageData.name;

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          file,
          filename: fileName,
        ),
      );

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      http.Response response =
      await http.Response.fromStream(await request.send());
      debugPrint('checkImageType Request URL: $url');
      debugPrint('checkImageType Request Headers: $headers');
      debugPrint('checkImageType statusCode::: ${response.statusCode}');
      debugPrint('checkImageType Response Body::: ${response.body}');
      debugPrint('checkImageType Response request::: ${response.request}');

      return response;
    } catch (error) {
      debugPrint("checkImageType Error ::: $error");
      return http.Response('error', 405);
    }
  }

  static Future<http.Response> humidityUpdateUrl() async {
    try {
      String url = "https://api.thingspeak.com/channels/2500233/feeds.json?api_key=0WL37AYEKC2CQEFH&results=1";
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      debugPrint('humidityUpdateUrl Request URL: $url');
      debugPrint('humidityUpdateUrl Request Headers: $headers');
      debugPrint('humidityUpdateUrl statusCode::: ${response.statusCode}');
      debugPrint('humidityUpdateUrl Response Body::: ${response.body}');
      debugPrint('humidityUpdateUrl Response request::: ${response.request}');
      if (response.statusCode == 200) {
        return response;
      } else {
        debugPrint('humidityUpdateUrl Error: HTTP request failed with status code ${response.statusCode}');
        return http.Response('HTTP request failed', response.statusCode);
      }
    } catch (error) {
      debugPrint("humidityUpdateUrl Error: $error");
      return http.Response('An unexpected error occurred', 500);
    }
  }

  static Future<http.Response> weatherApi({required String location}) async {

    try {
      String url = "https://api.tomorrow.io/v4/timelines?location=$location&fields=temperature,humidity,precipitationProbability,weatherCode&timesteps=1h&apikey=U3wucTc8mKhPWtXTXQGPlJwmt4pKBXPN";


      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      http.Response response = await http.get(Uri.parse(url), headers: headers);

      debugPrint('weatherApi Request URL: $url');
      debugPrint('weatherApi Request Headers: $headers');
      debugPrint('weatherApi statusCode::: ${response.statusCode}');
      debugPrint('weatherApi Response Body::: ${response.body}');
      debugPrint('weatherApi Response request::: ${response.request}');

      if (response.statusCode == 200) {
        return response;
      } else {
        debugPrint('weatherApi Error: HTTP request failed with status code ${response.statusCode}');
        return http.Response('HTTP request failed', response.statusCode);
      }
    } catch (error) {
      debugPrint("weatherApi Error: $error");

      return http.Response('An unexpected error occurred', 500);
    }
  }
}
