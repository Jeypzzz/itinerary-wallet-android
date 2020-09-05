import 'package:flutter/material.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/contact_page.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/profile_page/change_password_page.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/profile_page/profile_page.dart';
import 'package:itinerary_wallet/pages/forgot_password_page/forgot_password_page.dart';
import 'package:itinerary_wallet/pages/home_page/home_page.dart';
import 'package:itinerary_wallet/pages/itinerary_page/document_page.dart';
import 'package:itinerary_wallet/pages/itinerary_page/itinerary_page.dart';
import 'package:itinerary_wallet/pages/login_page/login_page.dart';
import 'package:itinerary_wallet/pages/bottom_tab_page/notification_page/notification_page.dart';
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
        '/login': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(),
        '/contact': (context) => ContactPage(),
        '/profile': (context) => ProfilePage(),
        '/change_password': (context) => ChangePasswordPage(),
        '/notifications': (context) => NotificationPage(),
        '/search': (context) => Search()
      },
    ));
