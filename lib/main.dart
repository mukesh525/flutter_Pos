import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mynu/manage_order/servies/menu_model.dart';
import 'package:mynu/manage_order/servies/orderProvider.dart';
import 'package:provider/provider.dart';

import 'manage_order/servies/menu_model.dart';
import 'manage_order/servies/menu_model.dart';
import 'manage_table/main/home_screen.dart';
import 'manage_table/servies/model.dart' as MyNuModel;
import 'manage_order/servies/menu_model.dart' as MyNewModel;
import 'manage_table/servies/tableProvider.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<MyNuModel.TableGroup>(MyNuModel.TableGroupAdapter());
  Hive.registerAdapter<MyNuModel.Table>(MyNuModel.TableAdapter());

  Hive.registerAdapter<MyNewModel.Category>(MyNewModel.CategoryAdapter());
  Hive.registerAdapter<MyNewModel.Group>(MyNewModel.GroupAdapter());
  Hive.registerAdapter<MyNewModel.Item>(MyNewModel.ItemAdapter());
  Hive.registerAdapter<MyNewModel.ImageInfo>(MyNewModel.ImageInfoAdapter());
  Hive.registerAdapter<MyNewModel.MenuResponse>(
      MyNewModel.MenuResponseAdapter());
  Hive.registerAdapter<MyNewModel.Result>(
      MyNewModel.ResultAdapter());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TableProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ManageTable(),
      ),
    ),
  );
}
