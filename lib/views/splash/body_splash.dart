import 'dart:async';

import '../login_signup/body.dart';
import '../../services/constant/path_images.dart';
import '../../services/language/generated/key_lang.dart';
import '../../services/themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PageSplachScreen extends StatefulWidget {
  const PageSplachScreen({super.key});

  @override
  State<PageSplachScreen> createState() => _PageSplachScreenState();
}

class _PageSplachScreenState extends State<PageSplachScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      var route = MaterialPageRoute(
        builder: (context) => const PageEnter(),
      );
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //*images (LOGO)
            const Image(
              image: AssetImage(PathImage.splashPhoto),
            ).animate(target: 1).fade(end: 0.8).scaleXY(end: 1.1),
            //*Text Application name
            const SizedBox(height: 40),
            Text(
              KeyLang.appName.tr(),
              style: AppTheme.hsmall(context),
            )
                .animate()
                .fadeIn(delay: const Duration(seconds: 1))
                .rotate(delay: const Duration(seconds: 1))
          ],
        ).animate().fadeIn().scale(),
      ),
    );
  }
}
