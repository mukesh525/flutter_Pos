import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynu/manage_order/food_menu.dart';

import 'OrderScreen.dart';

class MenuContent extends StatelessWidget {
  const MenuContent({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Expanded widget to take remaining vertical space equally
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: FoodMenu(),
              ),
              SizedBox(width: 0), // No spacing between Menu and Order
              Expanded(
                child: OrderScreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuScreen1 extends StatelessWidget {
  const MenuScreen1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red, // Set red background color
          //border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            'Menu',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class OrderScreen1 extends StatelessWidget {
  const OrderScreen1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange, // Set orange background color
          //border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            'Order',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
