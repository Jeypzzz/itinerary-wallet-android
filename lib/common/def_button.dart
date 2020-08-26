import 'package:flutter/material.dart';

class DefButton extends StatelessWidget {
  final Function onPressed;
  final String textTitle;

  DefButton({this.onPressed,this.textTitle});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
            onPressed: onPressed ,
            color:Theme.of(context).accentColor,
            minWidth: double.infinity,
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.transparent)),
            child: Text(textTitle,
            style: TextStyle(color: Colors.white),),
          );
  }
}