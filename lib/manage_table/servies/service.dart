import 'dart:convert';

import 'package:hive/hive.dart';

import 'model.dart';
import 'package:http/http.dart' as http;

class TableService {
  Future<List<TableGroup>> fetchDataFromUrl() async {
    print("Check if Hive box is empty");
    // Check if Hive box is empty
    bool hiveIsEmpty = await isHiveEmpty();

    if (hiveIsEmpty) {
      const sampleUrl =
          'https://sputnik.mynu.app/api/v1/pos/tables?restaurantId=5d68ad588085a04652357431'; // Replace with your sample URL
      try {
        final response = await http.get(Uri.parse(sampleUrl));

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          List<TableGroup> tableGroups =
              (jsonData['result']['tableGroups'] as List)
                  .map((tableGroup) => TableGroup.fromJson(tableGroup))
                  .toList();

          // Save data to Hive
          await saveDataToHive(tableGroups);

          print("API called and data saved to Hive");

          return tableGroups; // Return the fetched data
        } else {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print("Hive is not empty, skipping API call.");
    }

    // If Hive is not empty or an error occurs, return the stored data
    return retrieveDataFromHive(); // Return an empty list if Hive is not empty or if an error occurs
  }

  Future<bool> isHiveEmpty() async {
    // Open Hive box (assuming you have a TableGroup HiveTypeAdapter)
    var box = await Hive.openBox<TableGroup>('tableGroupBox');

    // Check if the box is empty
    bool isEmpty = box.isEmpty;

    // Close the box
    await box.close();

    return isEmpty;
  }

  Future<void> saveDataToHive(List<TableGroup> data) async {
    // Open Hive box (assuming you have a TableGroup HiveTypeAdapter)
    var box = await Hive.openBox<TableGroup>('tableGroupBox');

    // Clear existing data
    await box.clear();

    // Save new data
    await box.addAll(data);

    // Close the box
    await box.close();
  }

  Future<List<TableGroup>> retrieveDataFromHive() async {
    var box = await Hive.openBox<TableGroup>("tableGroupBox");
    List<TableGroup> storedData = List.from(box.values);
    await box.close();
    return storedData;
  }
}
