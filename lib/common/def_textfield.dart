import 'package:flutter/material.dart';

class DefTextField extends StatelessWidget {
  final String textHint;
  final String icon;
  final bool withShadow;
  final String Function(String) validator;
  final TextInputType type;
  final TextEditingController controller;

  DefTextField({
    this.textHint,
    this.icon,
    this.withShadow = false,
    this.validator,
    this.type,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: (withShadow) ? 3.0 : 0,
        shadowColor: Colors.grey[100],
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        child: TextFormField(
          keyboardType: type,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Container(
                width: 40,
                margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                  ),
                ),
                child: Image.asset(icon, color: Colors.black,),
              ),
              enabledBorder: outlineBorder(),
              focusedBorder: outlineBorder(),
              hintText: textHint),
        ),
      ),
    );
  }
}

OutlineInputBorder outlineBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  );
}
