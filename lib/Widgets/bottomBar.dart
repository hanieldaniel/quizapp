import 'package:boro_boro/constants/strings.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final void Function() resetButtonCallback;
  final void Function() validateButtonCallback;
  BottomBar(this.resetButtonCallback, this.validateButtonCallback);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        makeButton(Colors.orange,AppStrings.resetButton,resetButtonCallback),
        makeButton(Colors.blue,AppStrings.validateButton,validateButtonCallback)
      ],
    );
  }


  Widget makeButton(Color color, String txt, void Function() callback){
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            // background color
            primary: color,
            padding: EdgeInsets.symmetric(horizontal: 30),
            textStyle: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            callback();
          },
          child: Text(txt),
        );
  }
}
