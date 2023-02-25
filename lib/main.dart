import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/responsive/phoneScreenLayout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/webScreenLayout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAE-GQj1OqgjghcYwWLMmeIUnxYDwEKfcQ",
            appId: "1:949747285217:web:6bb6d76fc454efd6664ba0",
            messagingSenderId: "949747285217",
            projectId: "instagram-clone-8dba3",
            storageBucket: "instagram-clone-8dba3.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // providers: [
      //   ChangeNotifierProvider(
      //     create: (_) => UserProvider(),
      //   ),
      // ],
      // child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Instagram",
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: ResponsiveLayout(
        //   webScreenLayout: WebScreenLayout(),
        //   phoneScreenLayout: PhoneScreenLayout(),
        // ),
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.active) {
        //       if (snapshot.hasData) {
        //         return const ResponsiveLayout(
        //           webScreenLayout: WebScreenLayout(),
        //           phoneScreenLayout: PhoneScreenLayout(),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Center(
        //           child: Text('${snapshot.error.toString()}'),
        //         );
        //       }
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(
        //           color: primaryColor,
        //         ),
        //       );
        //     }
        //     return const LoginScreen();
        //   },
        // ),
        home: SignUpScreen(),
      // ),
    );
  }
}
