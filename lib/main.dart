import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graduation_project/services/Firebase/buyer_firestore.dart';
import 'package:graduation_project/services/Firebase/chat_firestore.dart';
import 'package:graduation_project/services/Firebase/item_firestore.dart';
import 'package:graduation_project/services/Firebase/order_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:graduation_project/views/home/buyerHome/component/pageNav/buyer_chat_page.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/seller_chat_page.dart';
import 'package:graduation_project/views/splash/body_splash.dart';
import 'package:provider/provider.dart';

import 'services/themes/custom_theme.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'sk_test_51PBvPa2LQllEX5HhIrnuxMIsPk64Y2z6YY45Q1I6wTw50JnX9veAt2HaHweo9yuaUzFA5YSehxSdKLEbLOCtLy5c001WHxUX2x';
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  dynamic createPayment(String amount, String currency) async {
    try {
      final body = {
        'amount': amount,
        'currency': currency,
      };
      final response = await http.post(
          Uri.parse('http://192.168.1.82:5050/payment'),
          body: body,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Paid Successfully')))
              })
          .onError((error, stackTrace) => {throw Exception(error)});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MultiProvider(
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
          ChangeNotifierProvider(
            create: (context) => ItemFirestore(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderFirestore(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChatsFirestore(),
          ),
        ],
        child: MaterialApp(
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme(context),
          darkTheme: CustomTheme.darkTheme(context),
          routes: {
            BuyerChatPage.routeName: (context) => const BuyerChatPage(),
            SellerChatPage.routeName: (context) => const SellerChatPage(),
          },
          home: const PageSplachScreen(),
        ),
      ),
    );
  }
}
