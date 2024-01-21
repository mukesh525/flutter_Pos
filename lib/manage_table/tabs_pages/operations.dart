import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils.dart';

class OperationContent extends StatelessWidget {
  const OperationContent({Key? key, required this.title, required this.header})
      : super(key: key);
  final String title;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
        const SizedBox(
          height: 300,
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: getRandomColor(),
              wordSpacing: 8,
            ),
          ),
        ),
      ],
    );
  }
}
