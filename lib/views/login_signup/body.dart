import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/services/Firebase/buyer_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:graduation_project/views/home/buyerHome/home_page.dart';
import 'package:graduation_project/views/home/sellerHome/pagehome.dart';
import 'package:provider/provider.dart';

import 'login/login.dart';
import 'signup/body.dart';
import '../../services/constant/path_images.dart';
import 'package:flutter/material.dart';

class PageEnter extends StatefulWidget {
  const PageEnter({super.key});

  @override
  State<PageEnter> createState() => _PageEnterState();
}

class _PageEnterState extends State<PageEnter> {
  @override
  Widget build(BuildContext context) {
    final UserAuth auth = Provider.of<UserAuth>(context);
    final BuyersFirestore buyer = Provider.of<BuyersFirestore>(context);
    final SellerFirestore seller = Provider.of<SellerFirestore>(context);

    Future<void> checkUserAndNavigate() async {
      bool isBuyer = await buyer.isBuyer(auth.currentUser.email ?? '');
      if (isBuyer) {
        buyer.loadBuyerData();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PageHomeBuyer(),
          ),
        );
      } else {
        seller.loadSellerData();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PageHomeSeller(),
          ),
        );
      }
    }

    return StreamBuilder<User?>(
      stream: UserAuth().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          checkUserAndNavigate();
          return const SizedBox.shrink();
        } else {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(PathImage.splashPhoto),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to Our Community!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'We\'re here to support and engage with you on your journey.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                var route = MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectBuyerOrSeller(),
                                );
                                Navigator.push(context, route);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 30,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    var route = MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    );
                                    Navigator.push(context, route);
                                  },
                                  child: const Text(
                                    ' Log in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
