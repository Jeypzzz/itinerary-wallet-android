import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatefulWidget {
@override
_SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _pos = 1;
  Timer _timer;

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        checkAuthenticated();
      });
    });

    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {
        _pos += 1;
        if(_pos > 12)
          _pos = 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFF04294b),
            body: Container(
              padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
              child:  Center(
                child:  content(),
              ),
            ),
          ),
        )
    );
  }


  Container content() {
    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 150),
            Text(
              "Tours, Activities and Attraction Tickets",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Container(
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/Splashscreen/flip_batch_red_$_pos.png'),
                )
            ),
            SizedBox(height: 150),
            Text(
              "Your local travel explorer",
              style: TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Container(
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/Splashscreen/logo.png'),
                )
            ),
            SizedBox(height: 100),
            Text(
              "Powered by Travelz ©",
              style: TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ));
  }

  checkAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('customerId') != null ||
        prefs.getString('firstName') != null ||
        prefs.getString('lastName') != null ||
        prefs.getString('email') != null) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
    } else
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
  }
}