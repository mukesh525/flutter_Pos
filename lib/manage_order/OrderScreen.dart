import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mynu/manage_order/servies/orderProvider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OrderProvider>(builder: (context, orderProvider, child) {
        final orderItems = orderProvider.orderItems ?? [];
        if (orderItems.isEmpty) {
          return Center(
            child: Text(
              'Add orders to proceed',
              style: TextStyle(fontSize: 18.0),
            ),
          );
        }
        return Column(
          children: [
            // Fixed Header
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Slno',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.0),
                  Expanded(
                    child: Container(
                      //color: Colors.red,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Name",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Container(
                      //  color: Colors.green,
                      //padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' Quantity',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Container(
                      // color: Colors.blue,
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Price',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  return buildRow(
                      orderItems[index],
                      index,
                      () => {orderProvider.addQuantity(orderItems[index])},
                      () => {orderProvider.reduceQuantity(orderItems[index])});
                },
              ),
            ),
            // Fixed Footer
            TotalValue(orderItems: orderProvider.orderItems),
          ],
        );
      }),
    );
  }

  Widget buildRow(OrderItem item, int index, onAdd, onSub) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${(index + 1).toString().padLeft(2, '0')}',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          SizedBox(width: 1.0),
          Expanded(
            child: Container(
              //color: Colors.red,
              padding: EdgeInsets.all(8.0),
              child: Text(
                Uri.decodeComponent(item.name),
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Expanded(
            child: Container(
              //  color: Colors.green,
              //padding: EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(Icons.remove), onPressed: onSub),
                    Text(
                      ' ${item.quantity}',
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(icon: Icon(Icons.add), onPressed: onAdd),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Expanded(
            child: Container(
              // color: Colors.blue,
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '\$ ${item.quantity * item.price}' ,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem {
  final String id;
  final String name;
  final double price;
  int quantity = 1;

  OrderItem({
    required this.name,
    required this.price,
    required this.id,
  });
}

class TotalValue extends StatelessWidget {
  final List<OrderItem> orderItems;

  const TotalValue({Key? key, required this.orderItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalValue = orderItems.fold(
        0.0, (sum, item) => sum + (item.quantity * item.price).toDouble());

    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey, // Set the background color here
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Value: \$${totalValue.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white)),
          ElevatedButton(
            onPressed: () {
              // Show the order details when the button is pressed
              showOrderDialog(context, orderItems, totalValue);
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }

  void showOrderDialog(
      BuildContext context, List<OrderItem> orderItems, double totalValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Column(
            children: [
              // Display order details in the dialog
              for (var item in orderItems)
                ListTile(
                  title: Text(
                      '${Uri.decodeComponent(item.name)} x${item.quantity}'),
                  subtitle: Text(
                      '\$${(item.quantity * item.price).toStringAsFixed(2)}'),
                ),
              Divider(),
              ListTile(
                title: Text('Total Value: \$${totalValue.toStringAsFixed(2)}'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle placing the order, e.g., send it to a server
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Place Order'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
