import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/services/constant/path_images.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/s_chat.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/s_home.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/s_notification.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/s_profile.dart';

class PageHomeSeller extends StatefulWidget {
  const PageHomeSeller({super.key});

  @override
  State<PageHomeSeller> createState() => _PageHomeSellerState();
}

class _PageHomeSellerState extends State<PageHomeSeller> {
  int indexPage = 0;
  static List<Widget> pageSelect = [
    const HomePageSeller(),
    const NotificationPageSeller(),
    const ChatSeller(),
    const ProfilePageSeller()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: appBarSeller(),
      body: pageSelect[indexPage],
      bottomNavigationBar: navigationButtonSeller(),
    );
  }

  AppBar appBarSeller() {
    return AppBar(
      elevation: 10,
      title: const Text('Seller Page'),
      actions: const [
        CircleAvatar(backgroundImage: AssetImage(PathImage.splashPhoto)),
      ],
    );
  }

  ConvexAppBar navigationButtonSeller() {
    return ConvexAppBar(
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.notifications, title: 'Notification'),
        TabItem(icon: Icons.message, title: 'chat'),
        TabItem(icon: Icons.people, title: 'Profile')
      ],
      onTap: (int value) {
        if (value != 2) {
          setState(() {
            indexPage = value;
          });
        }
      },
    );
  }
}
