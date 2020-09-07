import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/def_button.dart';
import 'package:itinerary_wallet/common/def_textfield.dart';
import 'package:dio/dio.dart';
import 'package:itinerary_wallet/common/def_textfield_obscured.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // emailController.text = "qa2@dreamdomainz.com";
    // passwordController.text = "123456";
    return Container(
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFF04294b),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: <Widget>[titleContainer(), formContainer()],
                      ),
              ),
            )),
      ),
    );
  }

  setPreferences(String customerId, String firstName, String lastName,
      String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('customerId') == null ||
        prefs.getString('firstName') == null ||
        prefs.getString('lastName') == null ||
        prefs.getString('email') == null)
    // || prefs.getString('email')==null)
    //|| prefs.getString('firstName')==null || prefs.getString('lastName')==null);
    {
      await prefs.setString('customerId', customerId);
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setString('email', email);
    }
  }

  login(String email, password) async {
    // print(email);
    // print(password);
    try {
      setState(() {
        _isLoading = true;
      });
      Response response = await Dio().post(
          "https://www.travezl.com/mobile/api/login.php",
          data: {"email": email, "password": password});
      print(response);
      if (response.statusCode == 200) {
        final res = json.decode(response.data);
        if (response.data.contains("error")) {
          setState(() {
            _isLoading = false;
          });
          showAlertDialog(context, res['message']);
        } else {
          setState(() {
            _isLoading = false;
          });
          setPreferences(
              res['id'], res['first_name'], res['last_name'], res['email']);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
        }
      }
    } catch (error) {
      showAlertDialog(context, error.message);
    }
  }

  Container titleContainer() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            width: 150,
            height: 150,
            child: Image.asset('assets/Images/logo.png')),
        SizedBox(height: 40),
        Text(
          "ITINERARY WALLET",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }

  Container formContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          DefTextField(
              controller: emailController,
              textHint: 'Email',
              icon: 'assets/Icons/email.png'),
          SizedBox(height: 20),
          DefTextFieldObscured(
            controller: passwordController,
            textHint: 'Password',
            icon: 'assets/Icons/lock.png',
          ),
          SizedBox(height: 20),
          DefButton(
            onPressed: () => login(emailController.text.toString(),
                passwordController.text.toString()),
            //Navigator.pushNamed(context, '/home'),
            textTitle: 'Login',
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.lightGreen),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/forgot_password')),
          ),
        ],
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
