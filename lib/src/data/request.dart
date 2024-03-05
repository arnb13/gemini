import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'url.dart';

class Request {
  final storage = GetStorage();
  final String url;
  final dynamic body;

  Request({required this.url, this.body});

  Future<http.Response> get() {

    return http.get(
        Uri.parse(BASE_URL + url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token')}',
        }
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      return http.Response('Error', 500);
    });
  }

  Future<http.Response> post() {
    return http.post(
        Uri.parse(BASE_URL + url),
        body: body,
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token')}',
        }
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      return http.Response('Error', 500);
    });
  }

  Future<http.Response> postWithoutHeader() {
    return http.post(
        Uri.parse(BASE_URL + url),
        body: body,
        headers: {
          //'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token')}',
        }
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      return http.Response('Error', 500);
    });
  }

  http.MultipartRequest postMultipart() {
    return http.MultipartRequest('POST', Uri.parse(BASE_URL + url));
  }
}