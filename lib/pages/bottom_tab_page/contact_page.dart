import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/def_title.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefHeader(
          onPressed: () => Navigator.of(context).pop(),
          visibility: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[DefTitle(title: 'Contact'), contactContainer(),BottomTabs(active: 'contact',)],
          ),
        ),
      ),
    );
  }

  Expanded contactContainer() {
    return Expanded(
          child: Container(
        padding: EdgeInsets.all(40),
        child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Color(0xFF04294b),
                  child: Text(
                    'ACTIVE TRAVEL',
                    style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            'Palko Bldg.\nG16/27 Lonsdate Street\nBraddon ACT 2612 AUSTRALIA',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.phone, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            '+61 (2) 6249 6122',
                            style: TextStyle(color: Colors.lightGreen),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.email, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            'askus@activetravel.com.au\n\ngroups@activetravel.com.au',
                            style: TextStyle(color: Colors.lightGreen),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.timer, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            'Monday to Friday\n9am to 5:30pm\n\nSaturday\n10am to 3pm',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
