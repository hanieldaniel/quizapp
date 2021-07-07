import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {

  String name;

  Page2(this.name);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [Center(
            child: Text(
              'Page2 ' + widget.name
            ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.pop(context, "content from page 2");
          }, child: Text(
            'Go Back'
          ))
          ]
        ),
      ),
    );
  }
}
