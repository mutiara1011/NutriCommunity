import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final bool obscure;
  final VoidCallback? onToggle;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.obscure = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscure : false,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: onToggle,
              )
            : null,
      ),
    );
  }
}
