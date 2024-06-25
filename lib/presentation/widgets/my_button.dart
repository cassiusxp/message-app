import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.maxFinite,
      child: TextButton(
        onPressed: () {
          if (onTap != null) {
            onTap!();
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: theme.inversePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.secondary,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
