import 'dart:convert';
import 'package:http/http.dart' as http;

import 'menu_model.dart';

class TableService {
  Future<MenuResponse> fetchDataFromUrl() async {
    final apiUrl =
        'https://sputnik.mynu.app/api/v1/pos/menu/5d68ad588085a04652357431?client=app';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('fetching  jsonData data from API: ' + jsonData.toString());
      final MenuResponse menuResponse = MenuResponse(
        status: jsonData['status'],
        result: Result.fromJson(jsonData['result']),
      );
      print('fetching Model data from API: ' + menuResponse.toString());
      // Save MenuResponse to Hive

      return menuResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
