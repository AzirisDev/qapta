import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final int? maxLength;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.validator,
    this.formatters,
    this.keyboardType,
    this.textAlign,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        maxLength: maxLength,
        textAlign: textAlign != null ? textAlign! : TextAlign.start,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        cursorColor: Colors.blue,
        cursorHeight: 20,
        controller: controller,
        cursorWidth: 1.5,
        validator: validator,
        decoration: InputDecoration(
          counterText: "",
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
