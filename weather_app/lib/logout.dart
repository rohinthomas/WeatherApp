import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/login/presentation/pages/login_page.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
                        alignment: Alignment.topRight,
                        child: 
                        GestureDetector(
                          onLongPress: () {
                          const Text("Logout");
                          },
                          onTap: () {
                              FirebaseAuth.instance.signOut();                        
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage())
                            );
                          },
                         child: const Icon(Icons.logout_rounded, color: Colors.white),
                        )
                      );
  }
}