import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final Color backgroundColor;
  final void Function() onPressed;

  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          backgroundColor,
        ),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.of(context).size.width, 50),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: text,
    );
  }
}
