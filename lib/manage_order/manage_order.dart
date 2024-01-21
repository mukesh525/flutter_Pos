import 'package:flutter/material.dart';
import 'package:mynu/manage_order/servies/orderProvider.dart';
import 'package:provider/provider.dart';

import 'category_sidebar.dart';
import 'menu_content.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            // Include your CategorySideBar widget here
            CategorySideBar(),
            // Consumer<OrderProvider>(
            //
            //   builder: (context, controller, child) {
            //     return Expanded(
            //       child: MenuContent(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}




