import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

class SecureHttpClient {
  static final SecureHttpClient _instance = SecureHttpClient._internal();

  factory SecureHttpClient() {
    return _instance;
  }

  SecureHttpClient._internal();

  Future<String> fetchRemoteConfig() async {
    const String expectedFingerprint = "xxxx";

    HttpClient client = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        final sha256Fingerprint = base64.encode(cert.der);
        return sha256Fingerprint == expectedFingerprint;
      };

    client.findProxy = (uri) {
      return 'PROXY xx.xxx.xxx:8888;';
    };

    IOClient ioClient = IOClient(client);

    try {
      final response = await ioClient.get(
        Uri.parse("your-https"),
        headers: {
          "Authorization": "Bearer your-token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("SSL Pinning Failed: $e");
    }
  }
}
