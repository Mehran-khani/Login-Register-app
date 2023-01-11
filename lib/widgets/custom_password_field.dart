import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_register_app/widgets/custom_container.dart';

class CustomPassfield extends StatefulWidget {
  CustomPassfield({
    super.key,
    required this.controller,
    this.onChanged,
    required this.hintText,
  });
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  bool isSecured = true;

  @override
  State<CustomPassfield> createState() => _CustomPassfieldState();
}

class _CustomPassfieldState extends State<CustomPassfield> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: TextField(
        obscureText: widget.isSecured,
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.isSecured = !widget.isSecured;
              });
            },
            child: widget.isSecured
                ? const Icon(
                    CupertinoIcons.eye,
                    color: Color(0xFf6A707C),
                  )
                : const Icon(
                    CupertinoIcons.eye_slash,
                    color: Color(0xFF6A707C),
                  ),
          ),
        ),
      ),
    );
  }
}
