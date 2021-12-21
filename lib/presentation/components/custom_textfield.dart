import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final int? maxLength;
  final int? minLines;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.validator,
    this.formatters,
    this.keyboardType,
    this.textAlign,
    this.maxLength,
    this.minLines,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        maxLines: minLines != null ? minLines! + 3 : 1,
        minLines: minLines,
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
          labelText: label,
          counterText: "",
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'RaleWay',
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
