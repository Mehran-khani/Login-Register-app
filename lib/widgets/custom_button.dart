import 'package:flutter/material.dart';

class CutsomButtom extends StatelessWidget {
  const CutsomButtom({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const LinearGradient(colors: [
      Color(0xff9668F7),
      Color(0xff84ABF9),
    ]),
    this.borderColor,
    this.buttonBackGround = Colors.transparent,
    this.wantBorder = false,
    this.textColor,
  });

  final String text;
  final VoidCallback onPressed;
  final LinearGradient? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? buttonBackGround;
  final bool wantBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 255,
      height: 50,
      decoration: BoxDecoration(
          gradient: backgroundColor, borderRadius: BorderRadius.circular(25)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBackGround,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: wantBorder
                ? const BorderSide(
                    width: 1,
                    color: Color(0xff825EF6),
                  )
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
