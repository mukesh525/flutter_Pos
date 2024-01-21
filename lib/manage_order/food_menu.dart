import 'package:flutter/material.dart';

class FoodMenu extends StatelessWidget {
  const FoodMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:4, // Number of columns in the grid
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                ),
                itemCount: sampleFoodItems.length,
                itemBuilder: (context, index) {
                  return FoodItemCard(foodItem: sampleFoodItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
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
    return Card(
      elevation: 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(foodItem.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text(foodItem.description, style: TextStyle(fontSize: 12.0)),
        ],
      ),
    );
  }
}

final List<FoodItem> sampleFoodItems = [
  FoodItem(name: 'Pizza', description: 'Delicious pizza with cheese and toppings'),
  FoodItem(name: 'Burger', description: 'Juicy burger with lettuce, tomato, and special sauce'),
  FoodItem(name: 'Pasta', description: 'Classic pasta with marinara sauce and Parmesan cheese'),
  FoodItem(name: 'Salad', description: 'Fresh salad with mixed greens and vinaigrette dressing'),
  FoodItem(name: 'Pizza', description: 'Delicious pizza with cheese and toppings'),
  FoodItem(name: 'Burger', description: 'Juicy burger with lettuce, tomato, and special sauce'),
  FoodItem(name: 'Pasta', description: 'Classic pasta with marinara sauce and Parmesan cheese'),
  FoodItem(name: 'Salad', description: 'Fresh salad with mixed greens and vinaigrette dressing'),
  FoodItem(name: 'Pizza', description: 'Delicious pizza with cheese and toppings'),
  FoodItem(name: 'Burger', description: 'Juicy burger with lettuce, tomato, and special sauce'),
  FoodItem(name: 'Pasta', description: 'Classic pasta with marinara sauce and Parmesan cheese'),
  FoodItem(name: 'Salad', description: 'Fresh salad with mixed greens and vinaigrette dressing'),
  FoodItem(name: 'Pizza', description: 'Delicious pizza with cheese and toppings'),
  FoodItem(name: 'Burger', description: 'Juicy burger with lettuce, tomato, and special sauce'),
  FoodItem(name: 'Pasta', description: 'Classic pasta with marinara sauce and Parmesan cheese'),
  FoodItem(name: 'Salad', description: 'Fresh salad with mixed greens and vinaigrette dressing'),
  // Add more sample food items as needed
];
