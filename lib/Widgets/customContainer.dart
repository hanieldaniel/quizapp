
import 'package:flutter/material.dart';

class FormattedContainers extends StatelessWidget {

  final double height;
  final Color color;
  FormattedContainers(this.height, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      color: color,
    );
  }
}