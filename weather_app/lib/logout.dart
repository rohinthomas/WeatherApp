import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
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
                          onTap: () async{
                              await FirebaseAuth.instance.signOut();                        
                            if(context.mounted){
                              context.go("/login");
                            }
                          },
                         child: const Icon(Icons.logout_rounded, color: Colors.white),
                        )
                      );
  }
}