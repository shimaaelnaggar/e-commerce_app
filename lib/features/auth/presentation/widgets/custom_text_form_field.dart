import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    this.suffixIcon,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.onChanged,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.onSaved,
    required this.label,
    required this.hint,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            onSaved: onSaved,
            obscureText: obscureText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autocorrect: true,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              label: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  // fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 9),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
