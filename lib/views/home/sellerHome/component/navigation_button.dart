import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class NavigationConvexAppBarSeller extends StatelessWidget {
  const NavigationConvexAppBarSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.notifications, title: 'Notification'),
        TabItem(icon: Icons.add, title: 'Add Product'),
        TabItem(icon: Icons.message, title: 'chat'),
        TabItem(icon: Icons.people, title: 'Profile')
      ],
      onTap: (int value) => print('click index : $value'),
    );
  }
}
