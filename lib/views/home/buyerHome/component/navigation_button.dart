import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class NavigationConvexAppBar extends StatefulWidget {
  const NavigationConvexAppBar({super.key});

  @override
  State<NavigationConvexAppBar> createState() => _NavigationConvexAppBarState();
}

class _NavigationConvexAppBarState extends State<NavigationConvexAppBar> {
  int indexPage = 0;
  // final List<Widget> _page = const [];
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: indexPage,
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.add_business_sharp, title: 'Item'),
        TabItem(icon: Icons.notifications, title: 'Notification'),
        TabItem(icon: Icons.shopping_cart_sharp, title: 'cart'),
        TabItem(icon: Icons.people, title: 'Profile')
      ],
      onTap: (int value) {
        setState(() {
          indexPage = value;
        });
      },
    );
  }
}
