import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {
  final Color backColor;
  final String title;
  final String startDate;
  final String endDate;
  final String document;
  final String icon;

  DocumentCard(
      {this.backColor,
      this.title,
      this.startDate,
      this.endDate,
      this.document,
      this.icon});

  String get imgIcon {
    return (backColor == Colors.white)
        ? 'assets/Icons/card_icons/${icon.toString()}.png'
        : 'assets/Icons/card_icons/${icon.toString()}3.png';
  }

  String get paperIcon {
    return (backColor == Colors.white)
        ? 'assets/Icons/card_icons/paper.png'
        : 'assets/Icons/card_icons/paper3.png';
  }

  Color get textColor {
    return (backColor == Colors.white) ? Colors.black87 : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: backColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(imgIcon, scale: 3),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(color: textColor),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/Icons/card_icons/paper.png',
                  scale: 3,
                  color: Colors.transparent,
                ),
                SizedBox(width: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        startDate + " to\n" + endDate,
                        style: TextStyle(fontSize: 13, color: textColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  paperIcon,
                  scale: 3,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    document,
                    style: TextStyle(
                      color: (backColor == Colors.white)
                          ? Color(0xFF61AAE6)
                          : Colors.yellow[200],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
