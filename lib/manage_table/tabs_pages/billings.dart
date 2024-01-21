import 'package:flutter/material.dart';
import 'package:mynu/manage_table/tabs_pages/table_item.dart';
import 'package:provider/provider.dart';

import '../Utils.dart';
import '../servies/model.dart';
import '../servies/tableProvider.dart';

class BillingContent extends StatelessWidget {
  const BillingContent({Key? key, required this.header}) : super(key: key);
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        Consumer<TableProvider>(
          builder: (context, tableProvider, child) {
            List<TableGroup> tableGroup = tableProvider.tableGroup;
            // print('Table Data List: ${tableDataList.length}');
            // print('Table Data selectedItem: ${tableProvider.selectedItem}');
            // print(
            //     "_tableProvider Group  size ${tableProvider.tableGroup.length}");

            return Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: tableGroup.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              tableGroup[index].name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GridView.count(
                            crossAxisCount: 10,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 14,
                            physics: const NeverScrollableScrollPhysics(),
                            // to disable GridView's scrolling
                            shrinkWrap: true,
                            // You won't see infinite size error
                            children: List.generate(
                                tableGroup[index].tables.length, (subIndex) {
                              if("621677aaff99c9393c5894a2"==tableGroup[index].tables[subIndex].id){
                                print(tableGroup[index].tables[subIndex].status.toString());
                              }
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TableItem(
                                  onItemTap: (context, item) => {
                                    tableProvider.navigateToTable(context, item)
                                  },
                                  showNotification: tableGroup[index]
                                          .tables[subIndex]
                                          .status !=1,
                                  animate: tableGroup[index]
                                          .tables[subIndex]
                                          .status !=1,
                                  color: getTableStatusColor(tableGroup[index]
                                      .tables[subIndex]
                                      .status)!,
                                  name: tableGroup[index].tables[subIndex].name,
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    );
                  }),
            );
          },
        ),
      ],
    );
  }
}
