import 'component/button.dart';
import 'login/login.dart';
import 'signup/body.dart';
import '../../services/constant/path_images.dart';
import '../../services/language/generated/key_lang.dart';
import 'package:flutter/material.dart';

class PageEnter extends StatefulWidget {
  const PageEnter({super.key});

  @override
  State<PageEnter> createState() => _PageEnterState();
}

class _PageEnterState extends State<PageEnter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(
              flex: 2,
              child: Image(
                image: AssetImage(PathImage.splashPhoto),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // const Image(
                  //     image: AssetImage(PathImage.splashPhoto),
                  //     width: 100,
                  //     height: 100),
                  // //******************************************************* */ name app

                  // const Text(
                  //   KeyLang.appName,
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  // ).animate().fadeIn().rotate(delay: const Duration(seconds: 2)),
                  //************************************************************ */ weclome
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Welcome to our community! We\'re here to support and engage with you.',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  // .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  // .fadeOut(curve: Curves.easeInBack),

                  //********************************button login and push to another page
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const SizedBox(
                            child: Text(
                              'Already have an\n account ?',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  wordSpacing: 2),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              var route = MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              );
                              Navigator.push(context, route);
                            },
                            child: const Text(
                              KeyLang.login,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      /////***********************************************signUP  and push to another page*/

                      InkWell(
                        onTap: () {
                          var route = MaterialPageRoute(
                            builder: (context) => const SelecltBuyerORSeller(),
                          );
                          Navigator.push(context, route);
                        },
                        child: const Button(textButton: 'Get Started'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
