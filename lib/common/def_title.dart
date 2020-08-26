import 'package:flutter/material.dart';

class DefTitle extends StatelessWidget {
  final String title;

  DefTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
