import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController controller;

  const NameTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      keyboardType: TextInputType.name,
      controller: controller,
      autofocus: false,
      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintText: 'First or full name',
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
