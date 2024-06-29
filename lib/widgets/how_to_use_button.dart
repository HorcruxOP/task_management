import 'package:flutter/material.dart';

class HowToUseButton extends StatelessWidget {
  const HowToUseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "• Use add button for creating a new task.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "• Single tap for updating the task.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "• Long-press to delete the task.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Text(
        "How to use?",
      ),
    );
  }
}
