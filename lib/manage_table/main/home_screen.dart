import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynu/manage_table/main/sidebar.dart';
import 'package:provider/provider.dart';
import '../Utils.dart';
import '../servies/tableProvider.dart';
import '../tabs_pages/billings.dart';
import '../tabs_pages/operations.dart';

class ManageTable extends StatelessWidget {
  const ManageTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Lock the screen orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    TableProvider apiControllerProvider = Provider.of<TableProvider>(context);

    void onSideBarItem(index) async {
      apiControllerProvider.fetchTableGroup(index);
    }

    return SafeArea(
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              return Row(
                children: [
                  SideBar(
                    onTableClick: (int index) {
                      onSideBarItem(index);
                    },
                  ),
                  Consumer<TableProvider>(
                      builder: (context, controller, child) {
                    return Expanded(
                      child: getTabScreen(controller.selectedItem),
                    );
                  }),
                ],
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('Rotate device to landscape mode',style: TextStyle(fontSize: 40,color: Colors.redAccent),),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          IconButton(
            iconSize: 32,
            padding: const EdgeInsets.all(0.0),
            color: Colors.black54,
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // ...
            },
          ),
          TextButton(
            style: flatButtonStyle,
            onPressed: () {
              print('Button pressed');
            },
            child: const Text('Delivery'),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            style: flatButtonStyle,
            onPressed: () {
              print('Pickup');
            },
            child: const Text('Pickup'),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            style: flatButtonStyle,
            onPressed: () {
              print('Add Table');
            },
            child: const Text('Add Table'),
          ),
          IconButton(
            iconSize: 30,
            color: Colors.black54,
            icon: const Icon(Icons.store),
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              // ...
            },
          ),
          IconButton(
            iconSize: 30,
            color: Colors.black54,
            icon: const Icon(Icons.food_bank),
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              // ...
            },
          ),
          IconButton(
            iconSize: 30,
            color: Colors.black54,
            icon: const Icon(Icons.watch_later_outlined),
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              // ...
            },
          ),
          IconButton(
            iconSize: 30,
            color: Colors.black54,
            icon: const Icon(Icons.notifications),
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              // ...
            },
          ),
        ],
      ),
    );
  }
}

Widget getTabScreen(index) {
  switch (index) {
    case 1:
      return const BillingContent(
          header: Header(
        title: "Table View",
      ));
    case 2:
      return const OperationContent(
          title: "Operations",
          header: Header(
            title: "Operations View",
          ));
    case 3:
      return const OperationContent(
          title: "Reports",
          header: Header(
            title: "Reports View",
          ));
    case 4:
      return const OperationContent(
          title: "Settings",
          header: Header(
            title: "Settings View",
          ));
    default:
      return const OperationContent(
          title: "Default",
          header: Header(
            title: "Table View",
          ));
  }
}
