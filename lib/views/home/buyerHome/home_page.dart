import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:graduation_project/views/home/buyerHome/component/pageNav/cart_buyer.dart';
import 'package:graduation_project/views/home/buyerHome/component/pageNav/home_buyer.dart';
import 'package:graduation_project/views/home/buyerHome/component/pageNav/buyer_orders_page.dart';
import 'package:graduation_project/views/home/buyerHome/component/pageNav/profile_buyer.dart';
import 'package:flutter/material.dart';

class PageHomeBuyer extends StatefulWidget {
  const PageHomeBuyer({super.key});

  @override
  State<PageHomeBuyer> createState() => _PageHomeBuyerState();
}

class _PageHomeBuyerState extends State<PageHomeBuyer> {
  int indexPage = 0;
  List<Widget> pageNav = [
    const HomePageBuyer(),
    const BuyerOrdersPage(),
    Container(),
    const ProfilePageBuyer()
  ];
  static List<String> pageTitle = [
    'Home',
    'Orders',
    'Chat',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: bulidAppBar(context),
        body: pageNav[indexPage],
        floatingActionButton: indexPage == 0
            ? FloatingActionButton.extended(
                backgroundColor: Colors.deepPurple,
                label: const Text('Cart'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPageBuyer(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 25,
                ),
              )
            : null,
        bottomNavigationBar: covexBottomNav(),
      ),
    );
  }

  AppBar bulidAppBar(context) {
    return AppBar(
      title: searchText(context),
      centerTitle: true,
      backgroundColor: Colors.deepPurple[400],
    );
  }

  Container searchText(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.deepPurple[400]),
          icon: Icon(
            Icons.search,
            color: Colors.deepPurple[400],
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.black),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  ConvexAppBar covexBottomNav() {
    return ConvexAppBar(
      backgroundColor: Colors.deepPurple[400],
      elevation: 10,
      initialActiveIndex: indexPage,
      items: [
        TabItem(
            icon: Icon(Icons.home,
                size: 25,
                color: indexPage == 0 ? Colors.deepPurple[400] : Colors.white),
            title: 'Home'),
        TabItem(
            icon: Icon(Icons.list,
                size: 25,
                color: indexPage == 1 ? Colors.deepPurple[400] : Colors.white),
            title: 'Orders'),
        TabItem(
            icon: Icon(Icons.message,
                size: 25,
                color: indexPage == 2 ? Colors.deepPurple[400] : Colors.white),
            title: 'Chat'),
        TabItem(
            icon: Icon(Icons.person,
                size: 25,
                color: indexPage == 3 ? Colors.deepPurple[400] : Colors.white),
            title: 'Profile')
      ],
      onTap: (int value) {
        setState(() {
          indexPage = value;
        });
      },
    );
  }
}
