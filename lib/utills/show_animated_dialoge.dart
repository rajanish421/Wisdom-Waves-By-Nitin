import 'package:flutter/material.dart';

class AnimatedDialog {
  /// Show a reusable animated dialog.
  /// [context] - BuildContext
  /// [title] - Title of the dialog
  /// [message] - Message body
  /// [primaryButtonText] - Text for primary action button
  /// [primaryButtonAction] - Callback for primary action
  /// [secondaryButtonText] - Text for secondary action button
  /// [secondaryButtonAction] - Callback for secondary action
  static void show(
      BuildContext context, {
        required String title,
        required String message,
        String primaryButtonText = "OK",
        VoidCallback? primaryButtonAction,
        String? secondaryButtonText,
        VoidCallback? secondaryButtonAction,
      }) {
    showGeneralDialog(
      barrierLabel: title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.info_outline, size: 60, color: Colors.blue),
                  const SizedBox(height: 15),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (secondaryButtonText != null)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            if (secondaryButtonAction != null) secondaryButtonAction();
                          },
                          child: Text(secondaryButtonText),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (primaryButtonAction != null) primaryButtonAction();
                        },
                        child: Text(primaryButtonText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.elasticOut),
          child: child,
        );
      },
    );
  }
}
