import 'package:flutter/material.dart';
import 'package:mynu/manage_order/servies/orderProvider.dart';
import 'package:provider/provider.dart';

import 'category_sidebar.dart';
import 'menu_content.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: orderProvider.categories.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text("Loading data..."),
            ],
          ),
        )
            : OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildPortraitLayout()
                : _buildLandscapeLayout();
          },
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return const Scaffold(
        body: Center(
        child: Text('Rotate device to landscape mode',style: TextStyle(fontSize: 40,color: Colors.redAccent),),
    ));
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        CategorySideBar(),
        Expanded(
          child: MenuContent(),
        ),
        // Additional widget for landscape mode, if needed
      ],
    );
  }
}
