import 'package:flutter/material.dart';

class DefTextField2 extends StatelessWidget {
  final String textHint;
  final TextInputType type;
  final String Function(String) validator;
  final String errorMessage;
  final bool enabled;
  final String initialValue;
  final bool obscured;
  final TextEditingController controller;

  DefTextField2({
    this.textHint,
    this.type,
    this.validator,
    this.errorMessage,
    this.enabled = true,
    this.initialValue,
    this.obscured = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Material(
              elevation: 3.0,
              shadowColor: Colors.grey[100],
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              child: Container(
                height: 48,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextFormField(
              initialValue: initialValue,
              keyboardType: type,
              enabled: enabled,
              validator: validator,
              obscureText: obscured,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: outlineBorder(),
                disabledBorder: outlineBorder(),
                focusedBorder: outlineBorder(),
                errorBorder: outlineBorder(),
                focusedErrorBorder: outlineBorder(),
                prefixIcon: Container(
                  width: 90,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.black12,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textHint,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Visibility(
          //   visible: false,
          //   child: Text('message'),
          // )
        ],
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
