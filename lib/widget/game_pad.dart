import 'package:flutter/material.dart';

class GamePad extends StatelessWidget {
  final int index;
  final List<String> elements;
  final Function tapped;

  const GamePad(this.index, this.elements, this.tapped, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final defaultColor = Colors.grey[300];
    return GestureDetector(
      onTap: () {
        tapped(index);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: elements[index] != ''
                ? [
                    colorTheme.primary,
                    colorTheme.secondary,
                  ]
                : [
                    defaultColor!,
                    defaultColor,
                  ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(elements[index]),
        ),
      ),
    );
  }
}
