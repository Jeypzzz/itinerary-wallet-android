import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_button.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/def_textfield.dart';
import 'package:itinerary_wallet/common/def_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  String firstName;
  String lastName;
  String email;
  String customerId;

  getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerId = (prefs.getString('customerId'));
    print(customerId);
    emailController.text = (prefs.getString('email'));
  }

  changePassword(
      String customerId, String oldPassword, String newPassword) async {
    try {
      Response response = await Dio().post(
          "https://www.travezl.com/mobile/api/user_change_password.php",
          data: {
            "customer_id": customerId,
            "old_password": oldPassword,
            "new_password": newPassword
          });
      print(response);
      if (response.statusCode == 200) {
        final res = json.decode(response.data);
        if (response.data.contains("error")) {
          showAlertDialog(context, res['message']);
        } else {
          Navigator.pushNamed(context, '/home');
        }
      }
    } catch (error) {
      print(error);
      //alertbox
    }
  }

  @override
  Widget build(BuildContext context) {
    getCustomer();
    return SafeArea(
      child: Scaffold(
        appBar: DefHeader(
          onPressed: () => Navigator.of(context).pop(),
          visibility: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                (82.0 + MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DefTitle(title: 'CHANGE PASSWORD'),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topCenter,
                          child: formContainer()),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: BottomTabs(active: 'profile')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding formContainer() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              DefTextField(
                controller: emailController,
                textHint: 'Email',
                icon: 'assets/Icons/email.png',
                withShadow: true,
                type: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              DefTextField(
                controller: currentPasswordController,
                textHint: 'Current Password',
                icon: 'assets/Icons/lock.png',
                withShadow: true,
                type: TextInputType.text,
              ),
              SizedBox(height: 20),
              DefTextField(
                controller: newPasswordController,
                textHint: 'New Password',
                icon: 'assets/Icons/lock.png',
                withShadow: true,
                type: TextInputType.text,
              ),
              SizedBox(height: 20),
              DefTextField(
                controller: newPasswordController,
                textHint: 'Confirm New Password',
                icon: 'assets/Icons/lock.png',
                withShadow: true,
                type: TextInputType.text,
              ),
              SizedBox(height: 20),
              DefButton(
                onPressed: () => changePassword(customerId,
                    currentPasswordController.text, newPasswordController.text),
                //Navigator.pushNamed(context, '/home'),
                textTitle: 'Change Password',
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
