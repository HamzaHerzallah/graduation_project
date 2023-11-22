import 'package:flutter/material.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/component/emptyPage.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/component/pageAfterPost.dart';

class AddProductSeller extends StatefulWidget {
  const AddProductSeller({super.key});

  @override
  State<AddProductSeller> createState() => _AddProductSellerState();
}

class _AddProductSellerState extends State<AddProductSeller> {
  static int index = 0; //*must index increment one
  static List<Widget> pageItem = const [EmptyPagePost(), PageAfterCreatePost()];
  @override
  Widget build(BuildContext context) {
    return pageItem[index];
  }
}
