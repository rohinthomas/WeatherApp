import 'package:flutter/material.dart';
import 'package:weather_app/features/login/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(), // Route to login page
        // Add more routes if needed
      },
    );
  }
}



// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//         Icon(Icons.search_outlined,color: Colors.white,),
//         Text("Weather App",style: TextStyle(color: Colors.white,fontSize: 25),),
//         Icon(Icons.person_2_rounded,color: Colors.white,),
//         ],), 
//         backgroundColor:Color.fromARGB(255, 0, 0, 0),
        
//       ),
//     );
//   }
// }