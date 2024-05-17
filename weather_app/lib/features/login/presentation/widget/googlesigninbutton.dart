
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';

class Googlesigninbutton extends StatelessWidget {
  const Googlesigninbutton({super.key});

  /// Show a simple "___ Button Pressed" indicator
  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Button Pressed!'),
        backgroundColor: Colors.black26,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  /// Normally the signin buttons should be contained in the SignInPage
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
            SignInButton(
              Buttons.google,
              onPressed: () {
                _showButtonPressDialog(context, 'Google');
              },
          ),
    );
  }
}