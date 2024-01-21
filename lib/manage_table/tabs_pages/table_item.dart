import 'package:flutter/material.dart';


class TableItem extends StatefulWidget {
  const TableItem({
    Key? key,
    required this.name,
    required this.animate,
    required this.color,
    required this.onItemTap,
  }) : super(key: key);

  final String name;
  final bool animate;
  final Color color;
  final Function( BuildContext, String) onItemTap;

  @override
  _TableItemState createState() => _TableItemState();
}

class _TableItemState extends State<TableItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _blinkAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.5),
          weight: 0.5,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.5, end: 1.0),
          weight: 0.5,
        ),
      ],
    ).animate(_animationController);

    // Automatically start the animation if animate is initially true
    if (widget.animate) {
      _startBlinkAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startBlinkAnimation() {
    _animationController
      ..reset()
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onItemTap(context, widget.name);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _blinkAnimation.value,
            child: Container(
              width: 150.0, // Set the desired width
              height: 100.0, // Set the desired height
              decoration: BoxDecoration(
                color: widget.animate ? widget.color : Colors.white60,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Center(
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: widget.animate ? Colors.black : Colors.black54,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
