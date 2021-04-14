import 'package:flutter/material.dart';

class TopMemories extends StatefulWidget {
  @override
  _TopMemoriesState createState() => _TopMemoriesState();
}

class _TopMemoriesState extends State<TopMemories> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: () {
              print("Container clicked");
            },
            child: new Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              height: 400.0,
              width: 320.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage("images/4.jpg"),
                ),
              ),
              child: new Column(children: [
                new Text("Ableitungen"),
              ]),
            )));
  }
}
