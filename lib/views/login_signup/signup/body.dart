import '../../../services/language/generated/key_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../services/constant/path_images.dart';
import '../component/radius_select.dart';
import 'component/buyer/reg_buyer.dart';
import 'component/seller/reg_seller.dart';

class SelecltBuyerORSeller extends StatelessWidget {
  const SelecltBuyerORSeller({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(
              image: const AssetImage(PathImage.rigeter),
              width: size.width / 2,
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 23.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Sign Up\n \t \t as a?',
                style: TextStyle(
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 40),
              ).animate().fadeIn().slideX(),
            ),
            //*Buyer Text
            const SizedBox(height: 15),
            InkWell(
                onTap: () {
                  var route = MaterialPageRoute(
                      builder: (context) => const RegisterBuyer());
                  Navigator.push(context, route);
                },
                child: const RadiusSelectSellerOrBuyer(user: KeyLang.buyer)
                    .animate()
                    .fadeIn()
                    .slideY()),
            //*Seller text
            const SizedBox(height: 15),
            InkWell(
                onTap: () {
                  var route = MaterialPageRoute(
                      builder: (context) => const RigesterSeller());
                  Navigator.push(context, route);
                },
                child: const RadiusSelectSellerOrBuyer(user: KeyLang.seller)
                    .animate()
                    .fadeIn()
                    .scaleXY())
          ]).animate().flipV(),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.moveTo(0, 400);
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
