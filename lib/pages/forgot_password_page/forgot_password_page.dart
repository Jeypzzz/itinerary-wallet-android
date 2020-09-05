import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/def_textfield2.dart';
import 'package:itinerary_wallet/common/def_title.dart';
import 'package:itinerary_wallet/validators.dart';
import 'package:dio/dio.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

final emailController = TextEditingController();
forgotPassword(String email) async {
  try {
    Response response = await Dio().post(
        "https://www.travezl.com/mobile/api/forgot_password.php",
        data: {"email": email});
    print(response);
    if (response.statusCode == 200) {
      final res = json.decode(response.data);
      if (response.data.contains("error")) {
        //alert box
      } else {
        //success
      }
    }
  } catch (error) {
    print(error);
    //alertbox
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffF5F5F5),
          appBar: DefHeader(
            onPressed: () => Navigator.of(context).pop(),
            visibility: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DefTitle(
                    title: 'FORGOT PASSWORD',
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        color: Colors.white,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Enter your email address registered with Active Travel. We'll send you an email with a link to reset your password",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(height: 30),
                              DefTextField2(
                                textHint: 'Email',
                                type: TextInputType.emailAddress,
                                validator:
                                    Validators().forgotPasswordEmailValidator,
                                controller: emailController,
                              ),
                              SizedBox(height: 30),
                              ButtonTheme(
                                minWidth: double.infinity,
                                height: 50,
                                child: FlatButton(
                                  onPressed: () =>
                                      forgotPassword(emailController.text),
                                  color: Color(0xffFFBE22),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.transparent),
                                  ),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  onSubmitPressed() {
    if (_formKey.currentState.validate()) {}
  }
}
