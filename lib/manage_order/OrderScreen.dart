import 'package:flutter/material.dart';

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
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16), // Adjust the top padding as needed
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
  List<DummyOrderItem> dummyItems = [
    DummyOrderItem(name: 'Burger', price: 10.0),
    DummyOrderItem(name: 'Pizza', price: 15.0),
    DummyOrderItem(name: 'Salad', price: 20.0),
    // Add more dummy items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          DataTable(
            columns: DummyOrderItem.columns,
            rows: [
              for (var item in dummyItems)
                item.buildDataRow(
                  () => updateQuantity(item),
                  item.quantity,
                ),
            ],
          ),
          SizedBox(height: 16.0), // Add some space between DataTable and TotalValue
          Align(
            alignment: FractionalOffset.bottomRight,
            child: TotalValue(dummyItems: dummyItems),
          )
        ],
      ),


    );
  }

  void updateQuantity(DummyOrderItem item) {
    setState(() {});
  }
}

class DummyOrderItem extends StatefulWidget {
  final String name;
  final double price;
  int quantity = 1;

  DummyOrderItem({
    required this.name,
    required this.price,
  });

  DataRow buildDataRow(VoidCallback updateQuantity, int quantity) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
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

class _DummyOrderItemState extends State<DummyOrderItem> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [], // Empty columns as we want to reuse the header
      rows: [
        widget.buildDataRow(() => updateQuantity(widget), widget.quantity),
      ],
    );
  }

  void updateQuantity(DummyOrderItem item) {
    setState(() {});
  }
}
class TotalValue extends StatelessWidget {
  final List<DummyOrderItem> dummyItems;

  const TotalValue({Key? key, required this.dummyItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalValue = dummyItems.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey, // Set the background color here
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Value: \$${totalValue.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
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