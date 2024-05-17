import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/login/data/googlesignin.dart';
class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {

  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Button Pressed!'),
        backgroundColor: Colors.black26,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInButton(
        Buttons.google,
        onPressed: ()async{await signInWithGoogle();},
      ),
    );
  }
}
