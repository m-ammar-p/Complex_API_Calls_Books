import 'package:flutter/material.dart';

class AppTextFields extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? hintText;
  final bool isPassField;

  const AppTextFields({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.isPassField = false,
  }) : super(key: key);

  @override
  _AppTextFieldsState createState() => _AppTextFieldsState();
}

class _AppTextFieldsState extends State<AppTextFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2)),
          ]),
      // If u want to increase height of a container Center widget will center
      // hintText, and icons
      child: Center(
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isPassField,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  } // build
} // _AppTextFieldsState Class