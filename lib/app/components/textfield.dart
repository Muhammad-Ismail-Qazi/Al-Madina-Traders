import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String hint;
  final int? maxLine;
  final bool readOnly;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.textFieldController,
    required this.hint,
    this.maxLine,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.validator, required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: textFieldController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hint,
      ),
      maxLines: maxLine,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
    );
  }
}