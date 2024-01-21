import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../servies/tableProvider.dart';

class SideBar extends StatelessWidget {
  final Function(int) onTableClick;

  const SideBar({super.key, required this.onTableClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints.expand(
              height: 60,
            ),
            padding: const EdgeInsets.all(8.0),
            color: Colors.orangeAccent,
            alignment: Alignment.center,
            child: Text('Mynu',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white)),
          ),
          Consumer<TableProvider>(
            builder: (context, apiControllerProvider, child) {
              int selectedItem = apiControllerProvider.selectedItem;
              //print('selectedTable Item: $selectedItem');
              return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5.0),
                children: <Widget>[
                  SideBarItem(
                      index: 1,
                      color: selectedItem == 1 ? Colors.red : Colors.black87,
                      onTableClick: onTableClick,
                      name: 'Billings',
                      icon: Icons.question_answer_outlined),
                  Container(
                    color: Colors.grey.shade400,
                    height: 2,
                  ),
                  SideBarItem(
                      color: selectedItem == 2 ? Colors.red : Colors.black87,
                      index: 2,
                      onTableClick: onTableClick,
                      name: 'Operation',
                      icon: Icons.confirmation_number_outlined),
                  Container(
                    color: Colors.grey.shade400,
                    height: 2,
                  ),
                  SideBarItem(
                      color: selectedItem == 3 ? Colors.red : Colors.black87,
                      index: 3,
                      onTableClick: onTableClick,
                      name: 'Reports',
                      icon: Icons.query_stats_rounded),
                  Container(
                    color: Colors.grey.shade400,
                    height: 2,
                  ),
                  SideBarItem(
                      index: 4,
                      color: selectedItem == 4 ? Colors.red : Colors.black87,
                      onTableClick: onTableClick,
                      name: 'Settings',
                      icon: Icons.question_answer_outlined),
                  Container(
                    color: Colors.grey.shade400,
                    height: 2,
                  ),

                  // Add more sidebar items as needed
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class SideBarItem extends StatelessWidget {
  const SideBarItem(
      {super.key,
      required this.onTableClick,
      required this.name,
      required this.icon,
      required this.index,
      required this.color,
      required});

  final Function(int) onTableClick;
  final String name;
  final IconData icon;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 30,
      leading: Icon(
        icon,
        color: color,
        size: 25,
      ),
      title: Transform.translate(
        offset: const Offset(-10, 0),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 15.0,
            color: color,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      onTap: () {
        // Handle Table item
        onTableClick(index);
        print('Table Clicked');
      },
    );
  }
}
