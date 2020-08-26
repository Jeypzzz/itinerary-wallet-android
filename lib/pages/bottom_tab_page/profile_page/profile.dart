import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/bottom_tabs.dart';
import 'package:itinerary_wallet/common/def_button.dart';
import 'package:itinerary_wallet/common/def_header.dart';
import 'package:itinerary_wallet/common/def_textfield2.dart';
import 'package:itinerary_wallet/common/def_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

String firstName;
String lastName;
String email;

bool _isLoading = false;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        final prefs = snapshot.data;
        firstName = (prefs.getString('firstName'));
        lastName = (prefs.getString('lastName'));
        email = (prefs.getString('email'));

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: DefHeader(
              onPressed: () => Navigator.of(context).pop(),
              visibility: true,
            ),
            body: SingleChildScrollView(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                height: MediaQuery.of(context).size.height -
                    (82 + MediaQuery.of(context).padding.top),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DefTitle(title: 'USER PROFILE'),
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
    );
  }

  Padding formContainer() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DefTextField2(
              initialValue: firstName,
              textHint: 'First name',
              enabled: false,
              type: TextInputType.text,
            ),
            SizedBox(height: 20),
            DefTextField2(
              initialValue: lastName,
              textHint: 'Last name',
              enabled: false,
              type: TextInputType.text,
            ),
            SizedBox(height: 20),
            DefTextField2(
              initialValue: email,
              textHint: 'Email',
              enabled: false,
              type: TextInputType.emailAddress,
            ),
            // SizedBox(height: 20),
            // DefTextField2(
            //   textHint: 'Password',
            //   enabled: false,
            //   initialValue: 'ellacruz',
            //   obscured: true,
            //   type: TextInputType.text
            // ),
            SizedBox(height: 20),
            DefButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/change_password'),
                textTitle: 'Change Password'),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, '')),
            ),
          ],
        ),
      ),
    );
  }
}
