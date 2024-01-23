import 'package:hive/hive.dart';

import 'menu_model.dart';

class HiveService {
  Future<void> saveMenuResponseToHive(MenuResponse menuResponse) async {
    // Open Hive box for MenuResponse
    var box = await Hive.openBox<MenuResponse>('menu_response_');

    // Clear existing data
    await box.clear();

    // Save MenuResponse to Hive
    await box.add(menuResponse);

    // Close the box
    await box.close();
  }

  Future<MenuResponse> getSavedMenuResponseFromHive() async {
    // Open Hive box for MenuResponse
    var box = await Hive.openBox<MenuResponse>('menu_response_');

    // Get MenuResponse from Hive
    MenuResponse menuResponse = box.values.first;

    // Close the box
    await box.close();

    return menuResponse;
  }
}
