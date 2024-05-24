import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/login/data/googlesignin.dart';
import 'package:weather_app/features/weather/presentation/pages/home_page.dart';
class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  GoogleSignInButtonState createState() => GoogleSignInButtonState();
}

class GoogleSignInButtonState extends State<GoogleSignInButton> {

  void showButtonPressDialog(BuildContext context, String provider) {
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
        onPressed: ()async{await signInWithGoogle();
          if(context.mounted && FirebaseAuth.instance.currentUser!=null){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WeatherPage())
            );
          }
        },
      ),
    );
  }
}
