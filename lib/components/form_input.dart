import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  const FormInput({
    this.controller,
    this.label,
    this.hint,
    this.icon
  });

  getIcon() {
    return (this.icon != null) ? Icon(this.icon) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: getIcon(),
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}