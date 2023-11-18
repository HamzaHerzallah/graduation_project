import 'dart:async';

import 'package:graduation_project/services/Firebase/buyer_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:graduation_project/views/home/buyerHome/home_page.dart';
import 'package:graduation_project/views/home/sellerHome/pagehome.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class Pageverified extends StatefulWidget {
  const Pageverified({super.key, required this.email});

  final String email;

  @override
  State<Pageverified> createState() => _PageverifiedState();
}

class _PageverifiedState extends State<Pageverified> {
  int remainingSeconds = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserAuth auth = Provider.of<UserAuth>(context);
    final BuyersFirestore buyer = Provider.of<BuyersFirestore>(context);
    final SellerFirestore seller = Provider.of<SellerFirestore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              '\t\tEmail verification has been sent to ',
              style: TextStyle(color: Colors.grey[350]),
            ),
            Row(
              children: [
                //*email address dynamic
                Text(
                  '\t\t\t\t ${widget.email}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Resend code after ',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 5),
                Text(
                  '$remainingSeconds seconds',
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: remainingSeconds <= 0
                      ? () {
                          auth.sendVerificationEmail();
                          setState(() {
                            remainingSeconds = 60;
                          });
                          _startTimer();
                        }
                      : null,
                  child: const Text('Resend'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await auth.currentUser.reload();
                    if (auth.currentUser.emailVerified) {
                      final isBuyer = await buyer.isBuyer(widget.email);
                      if (isBuyer) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PageHomeBuyer(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                      final isSeller = await seller.isSeller(widget.email);
                      if (isSeller) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PageHomeSeller(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
