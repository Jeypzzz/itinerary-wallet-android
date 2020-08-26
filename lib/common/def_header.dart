import 'package:flutter/material.dart';
import 'package:itinerary_wallet/common/def_title.dart';

class DefHeader extends StatelessWidget implements PreferredSize {
  final double _prefferedHeight = 82.0;
  final Function onPressed;
  final bool visibility;
  DefHeader({this.onPressed, this.visibility});

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(120),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Images/logo.png',
                  scale: 6,
                ),
                Visibility(
                  visible: visibility,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: new Image.asset('assets/Icons/back.png'),
                      onPressed: onPressed,
                    ),
                  ),
                )
              ],
            ),
          ),
          // DefTitle(title:'CHANGE PASSWORD')
        ],
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => null;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}
