import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mynu/manage_order/servies/orderProvider.dart';
import 'package:provider/provider.dart';

import 'OrderScreen.dart';

class FoodMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final foodItems = orderProvider.menuItems ?? [];

        return Container(
          // padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue, // Set your desired color
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: foodItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle item tap here
                          print('Item tapped: ${foodItems[index].id}');
                          OrderItem item = OrderItem(
                            price: double.parse(foodItems[index].price!),
                            name: foodItems[index].name!,
                            id: "",
                          );
                          orderProvider.addItem(item);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors
                                      .green, // Set your desired border color
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://source.unsplash.com/random/?food',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.5), // Set your desired overlay color
                                ),
                                child: Text(
                                  Uri.decodeComponent(foodItems[index].name!),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FoodItem {
  final String name;
  final String description;

  FoodItem({required this.name, required this.description});
}

class FoodItemCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodItemCard({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red, // Set red background color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Menu',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          // Other content related to FoodItemCard
        ],
      ),
    );
  }
}
