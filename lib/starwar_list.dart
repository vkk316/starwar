import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarwarList extends StatefulWidget {

  @override
  _StarwarListState createState() => _StarwarListState();
}

class _StarwarListState extends State<StarwarList> {
  final List<String> entries = <String>['A', 'B', 'C'];

final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        });
  }
}
