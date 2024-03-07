import 'dart:convert';
import 'package:http/http.dart' as http;

class API {

  static Future<String?> getIPAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return jsonData['ip'];
      } else {
        throw Exception('Failed to fetch IP address');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<void> testInternetSpeed() async {
    const url = 'https://www.google.com';

    final stopwatch = Stopwatch()..start();

    try {
      final response = await http.get(Uri.parse(url));
      final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
      
      final elapsedSeconds = elapsedMilliseconds / 1000;
      final speedBps = (response.contentLength! * 8) / elapsedSeconds;
      final speedMbps = speedBps / (1024 * 1024);
      
      print('Internet speed: ${speedMbps.toStringAsFixed(2)} Mbps');
    } catch (e) {
      print('Error occurred: $e');
    }
  }

}
