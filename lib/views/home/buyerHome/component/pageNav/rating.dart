import 'package:flutter/material.dart';
import 'package:graduation_project/Models/seller_model.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rating extends StatefulWidget {
  const Rating({super.key, required this.projectName, required this.sellerId});

  final String projectName;
  final String sellerId;

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late SellerFirestore sellerFirestore;
  SellerModel? seller;

  void getSeller() async {
    seller = await sellerFirestore.getSellerByID(sellerID: widget.sellerId);
  }

  @override
  void initState() {
    super.initState();
    sellerFirestore = Provider.of<SellerFirestore>(context, listen: false);
    getSeller();
  }

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: Text(
        'Did you like ordering from ${widget.projectName}?\n Rate them!',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.deepPurple,
        ),
      ),
      submitButtonText: 'Submit',
      submitButtonTextStyle: const TextStyle(
        color: Colors.deepPurple,
      ),
      onSubmitted: (p0) async {
        await sellerFirestore.updateSellerByID(
          sellerID: widget.sellerId,
          ratingCount: (int.parse(seller!.ratingCount!) + 1).toString(),
          rating: ((double.parse(seller!.ratingSum!) + p0.rating) /
                  (int.parse(seller!.ratingCount!) + 1))
              .toString(),
          ratingSum: (double.parse(seller!.ratingSum!) + p0.rating).toString(),
        );
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('rated', true);
      },
      enableComment: false,
      starSize: 30,
    );
  }
}
