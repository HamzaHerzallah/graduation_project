import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/services/Firebase/buyer_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:provider/provider.dart';

import 'services/themes/custom_theme.dart';
import 'views/splash/body_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserAuth(),
        ),
        ChangeNotifierProvider(
          create: (context) => BuyersFirestore(),
        ),
        ChangeNotifierProvider(
          create: (context) => SellerFirestore(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme(context),
        darkTheme: CustomTheme.darkTheme(context),
        home: const PageSplachScreen(),
      ),
    );
  }
}
