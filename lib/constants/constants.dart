import 'package:flutter/material.dart';

const kBorderColor = Color(0xFFE7E7E7);
const kTextColor = Color(0xFF636363);

class Functions {
  static void showSuccessSnackBar(BuildContext context, String text,
      [Function()? onVisible]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        onVisible: onVisible,
        content: Row(
          children: [
            const Icon(
              Icons.check,
            ),
            Expanded(child: Text(text))
          ],
        ),
      ),
    );
  }

  static void showFailureSnackBar(BuildContext context, String text,
      [Function()? onVisible]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        onVisible: onVisible,
        content: Row(
          children: [
            const Icon(
              Icons.error,
            ),
            Expanded(child: Text(text))
          ],
        ),
      ),
    );
  }
}
