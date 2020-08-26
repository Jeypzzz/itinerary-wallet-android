import 'package:flutter/material.dart';

class BottomTabs extends StatelessWidget {
  final String active;

  BottomTabs({this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 70,
      child: Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: (active == 'search')
                  ? Image.asset('assets/Icons/search2.png')
                  : Image.asset('assets/Icons/search.png'),
              onPressed: (active == 'search')
                  ? null
                  : () {
                      (active == null)
                          ? Navigator.pushNamed(context, '/search')
                          : Navigator.popAndPushNamed(context, '/search');
                    },
            ),
            IconButton(
                icon: (active == 'notify')
                    ? Image.asset('assets/Icons/notify2.png')
                    : Image.asset('assets/Icons/notify.png'),
                onPressed: (active == 'notify')
                    ? null
                    : () {
                        (active == null)
                            ? Navigator.pushNamed(context, '/notifications')
                            : Navigator.popAndPushNamed(
                                context, '/notifications');
                      }),
            IconButton(
                icon: (active == 'contact')
                    ? Image.asset('assets/Icons/call2.png')
                    : Image.asset('assets/Icons/call.png'),
                onPressed: (active == 'contact')
                    ? null
                    : () {
                        (active == null)
                            ? Navigator.pushNamed(context, '/contact')
                            : Navigator.popAndPushNamed(context, '/contact');
                      }),
            IconButton(
                icon: (active == 'profile')
                    ? Image.asset('assets/Icons/profile2.png')
                    : Image.asset('assets/Icons/profile.png'),
                onPressed: (active == 'profile')
                    ? null
                    : () {
                        (active == null)
                            ? Navigator.pushNamed(context, '/profile')
                            : Navigator.popAndPushNamed(context, '/profile');
                      }),
          ],
        ),
      ),
    );
  }
}
