import 'package:http/http.dart' as http;

class CustomHttpClient {
  http.Client client = http.Client();

  Future<http.Response> get(Uri url) async {
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
    });
    return response;
  }
}
