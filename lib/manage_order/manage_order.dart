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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(), // Show loading indicator
              SizedBox(height: 16),
              Text('Loading data..', style: TextStyle(fontSize: 16)),
            ],
          ),
        )
            : Row(
          children: [
            CategorySideBar(),
            Expanded(
              child: MenuContent(),
            ),
          ],
        ),
      ),
    );
  }
}

