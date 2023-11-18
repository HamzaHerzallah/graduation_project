import 'package:flutter/material.dart';

import 'component/navigation_button.dart';

class PageHomeSeller extends StatefulWidget {
  const PageHomeSeller({super.key});

  @override
  State<PageHomeSeller> createState() => _PageHomeSellerState();
}

class _PageHomeSellerState extends State<PageHomeSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        elevation: 10,
        title: const Text('Seller Page'),
        actions: const [
          CircleAvatar(backgroundColor: Colors.red),
        ],
      ),
      bottomNavigationBar: const NavigationConvexAppBarSeller(),
    );
  }
}
