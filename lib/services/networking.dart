import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  http.Response? response;

  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    if (response!.statusCode == 200) {
      String data = response!.body;
      final decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response!.statusCode);
    }
  }
}
