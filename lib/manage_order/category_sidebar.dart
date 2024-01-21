// Import necessary packages and files

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynu/manage_order/servies/category_model.dart';
import 'package:mynu/manage_order/servies/menu_model.dart';
import 'package:mynu/manage_order/servies/orderProvider.dart';
import 'package:provider/provider.dart';

class CategorySideBar extends StatelessWidget {
  const CategorySideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return Container(
      width: 220.0,
      color: Colors.white60,
      height: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: orderProvider.categories.length,
        itemBuilder: (BuildContext context, int categoryIndex) {
          Category category = orderProvider.categories[categoryIndex];
          int selectedMenuItemIndex =
              orderProvider.selectedMenuItems[categoryIndex] ?? -1;

          return ExpansionPanelList(
            elevation: 1,
            dividerColor: Colors.blue,
            expansionCallback: (int panelIndex, bool isExpanded) {
              orderProvider.toggleCategoryExpansion(categoryIndex);
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    color: isExpanded ? Colors.white : Colors.white60,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      tileColor: category.isExpanded
                          ? Colors.orangeAccent
                          : Colors.white60,
                      leading: Icon(
                        Icons.add_box,
                        color: Colors.grey,
                      ),
                      title: Container(
                        width: double.infinity,
                        child: Transform.translate(
                          offset: const Offset(-10, 0),
                          child: Text(
                            category.name!,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Handle category selection
                        orderProvider.setSelectedCategory(categoryIndex);
                      },
                    ),
                  );
                },
                body: Column(
                  children: [
                    for (int menuIndex = 0;
                        menuIndex < category.groups!.length;
                        menuIndex++)
                      Container(
                        color: menuIndex == selectedMenuItemIndex
                            ? Colors
                                .orangeAccent // Set your desired selected color
                            : Colors.grey,
                        child: ListTile(
                          title: Text(
                            category.groups![menuIndex].name!,
                            style: TextStyle(
                                color: Colors
                                    .white // Set your desired selected color
                                ),
                          ),
                          onTap: () {
                            // Handle menu item click
                            print(
                                'Menu Item Clicked: ${category.groups![menuIndex].name}');
                            orderProvider.setSelectedMenuItem(
                                categoryIndex, menuIndex);
                          },
                        ),
                      ),
                  ],
                ),
                isExpanded: category.isExpanded,
              ),
            ],
          );
        },
      ),
    );
  }
}
