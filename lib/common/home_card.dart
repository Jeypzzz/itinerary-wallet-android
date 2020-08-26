import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String date;
  final List<String> icons;
  final Color color;
  final Color textColor;
  final Function onTap;

  HomeCard(
      {this.title,
      this.date,
      this.icons,
      this.color,
      this.textColor,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: Material(
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      this.title,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  Container(
                      // padding: EdgeInsets.all(10),
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(this.date),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(icons[0]),
                          for (var icon in icons)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 6),
                              child: Image.asset(
                                'assets/Icons/card_icons/${icon.toString()}.png',
                                scale: 3,
                              ),
                            ),

                          Visibility(
                            visible: (icons.length != 9),
                            child: Expanded(
                              child: Container(),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                ],
              )),
        ),
      ),
    );
  }
}
