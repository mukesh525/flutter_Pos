import 'package:flutter/material.dart';
import 'package:mynu/manage_order/servies/orderProvider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue, // Set your desired color
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Order',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              // Adjust the top padding as needed
              child: Row(
                children: [
                  Expanded(
                    child: OrderContent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderContent extends StatefulWidget {
  const OrderContent({Key? key}) : super(key: key);

  @override
  _OrderContentState createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Row
              DataTable(
                columns: OrderItem.columns,
                rows: [
                  for (var item in orderItems)
                    item.buildDataRow(
                      () => updateQuantity(item),
                      item.quantity,
                    ),
                ],
              ),
              SizedBox(height: 16.0),
              // Add some space between DataTable and TotalValue
              Align(
                alignment: FractionalOffset.bottomRight,
                child: TotalValue(orderItems: orderItems),
              ),
            ],
          );
        },
      ),
    );
  }

  void updateQuantity(OrderItem item) {
    setState(() {});
  }
}

class OrderItem extends StatefulWidget {
  final String id;
  final String name;
  final double price;
  int quantity = 1;

  OrderItem({
    required this.name,
    required this.price, required this.id,
  });

  DataRow buildDataRow(VoidCallback updateQuantity, int quantity) {
    return DataRow(
      cells: [
        DataCell(Text(Uri.decodeComponent(name))),
        // DataCell(Icon(Icons.check)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  // setState(() {
                  //   if (quantity > 0) {
                  //     quantity--;
                  //     updateQuantity();
                  //   }
                  // }
                  // );
                },
              ),
              Text('$quantity'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // setState(() {
                  //   quantity++;
                  //   updateQuantity();
                  // });
                },
              ),
            ],
          ),
        ),
        DataCell(Text('\$${(price * quantity).toStringAsFixed(2)}')),
      ],
    );
  }

  double get totalPrice => price * quantity; // Getter for total price

  static final List<DataColumn> columns = [
    DataColumn(label: Text('Items')),
    // DataColumn(label: Text('Quantity')),
    DataColumn(
      label: Container(
        width: 100,
        //color: Colors.blue, // Set the background color here
        child: Center(
          child: Text('Qty'),
        ),
      ),
      numeric: false, // make the column numeric
      tooltip: 'Quantity',
    ),
    DataColumn(label: Text('Price')),
  ];

  @override
  _DummyOrderItemState createState() => _DummyOrderItemState();
}

class _DummyOrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [], // Empty columns as we want to reuse the header
      rows: [
        widget.buildDataRow(() => updateQuantity(widget), widget.quantity),
      ],
    );
  }

  void updateQuantity(OrderItem item) {
    setState(() {});
  }
}

class TotalValue extends StatelessWidget {
  final List<OrderItem> orderItems;

  const TotalValue({Key? key, required this.orderItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalValue =
        orderItems.fold(0.0, (sum, item) => sum + item.totalPrice);

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
              // Handle button press if needed
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
