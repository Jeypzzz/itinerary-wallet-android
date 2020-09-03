import 'package:flutter/material.dart';

class ItineraryCard extends StatelessWidget {
  final Function onPressed;
  final String iconName;
  final bool active;
  final int count;

  Color get containerColor {
    return (active) ? Color(0xFF61AAE6) : Color.fromRGBO(220, 230, 240, 1);
  }

  ItineraryCard({this.onPressed, this.iconName, this.active, this.count});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: containerColor,
        boxShadow: [
          if (active)
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3.0, 3.0), //(x,y)
              blurRadius: 2.0,
            ),
        ],
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
        onPressed: onPressed,
        // child: Center(
        //   child: Image.asset('assets/Icons/card_icons/airplane.png'),
        // ),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Align(
              alignment: Alignment.center,

              child: Image.asset(
                'assets/Icons/card_icons/${iconName.toString()}2.png',
                width: 50,
                height: 50,
              ),

              // child: Text(iconName),
            ),
            Visibility(
              visible: active,
              child: Positioned(
                top: 0,
                right: -2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Text(count.toString(), style: TextStyle(color: Colors.orange)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
