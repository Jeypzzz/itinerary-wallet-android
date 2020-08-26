import 'package:flutter/material.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/Contact.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/profile_page/change_password.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/profile_page/profile.dart';
import 'package:itinerary_wallet/pages/forgot_password_page/forgot_password.dart';
import 'package:itinerary_wallet/pages/home_page/home.dart';
import 'package:itinerary_wallet/pages/itinerary_page/document.dart';
import 'package:itinerary_wallet/pages/itinerary_page/itinerary.dart';
import 'package:itinerary_wallet/pages/login_page/login.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/notification_page/notifications.dart';
import 'package:itinerary_wallet/pages/search_page/search.dart';
import 'package:itinerary_wallet/pages/splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF04294b),
        accentColor: Color(0xffFFBE22),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => Login(),
        '/forgot_password': (context) => ForgotPassword(),
        '/home': (context) => Home(),
        // '/itinerary': (context) => Itinerary(
        //       data: [],
        //     ),
        '/document': (context) => Document(
              icon: '',
            ),
        '/contact': (context) => Contact(),
        '/profile': (context) => Profile(),
        '/change_password': (context) => ChangePassword(),
        '/notifications': (context) => Notifications(),
        '/search': (context) => Search()
      },
    ));
