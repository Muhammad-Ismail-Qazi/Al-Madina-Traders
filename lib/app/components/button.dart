import 'package:flutter/material.dart';
import '../constants/fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: CustomFontStyle.heading,
            elevation: 2,
          ),
          onPressed: onPressed,
          child: Text(text), // Use the text passed to the constructor
        ),
      ),
    );
  }
}