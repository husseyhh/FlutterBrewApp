import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  BrewTile({this.brew});
  final Brew? brew;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew?.strength ?? 0],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew?.name ?? "No name"),
          subtitle: Text('Takes ${brew?.sugars ?? '0'} sugar(s)'),
        ),
      ),
    );
  }
}
