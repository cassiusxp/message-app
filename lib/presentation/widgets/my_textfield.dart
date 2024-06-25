import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  const MyTextField({
    this.hintText,
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "",
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
      ),
    );
  }
}
