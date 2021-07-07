
import 'package:flutter/material.dart';

class formattedContainers extends StatelessWidget {

  final double height;
  final Color color;
  formattedContainers(this.height, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      color: color,
    );
  }
}