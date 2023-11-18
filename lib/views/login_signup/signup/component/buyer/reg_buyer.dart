import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/services/Firebase/buyer_firestore.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:provider/provider.dart';

import '../../../component/button.dart';
import '../../../component/text_username.dart';
import '../verifiication/verify.dart';
import '../../../../../services/language/generated/key_lang.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../services/themes/app_color.dart';
import '../../../component/text_pass.dart';
import '../../../login/login.dart';

class RegisterBuyer extends StatefulWidget {
  const RegisterBuyer({super.key});

  @override
  State<RegisterBuyer> createState() => _RegisterBuyerState();
}

class _RegisterBuyerState extends State<RegisterBuyer> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserAuth auth = Provider.of<UserAuth>(context);
    final BuyersFirestore buyer = Provider.of<BuyersFirestore>(context);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Buyer', style: TextStyle(color: AppColors.bgwhite)),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Welcome back, Create your account !',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.bgwhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //*textFiald : fill the name user
                          TextFieldUseAll(
                              controller: nameController,
                              hint: KeyLang.nameUser,
                              iconuse: Icons.person,
                              type: TextInputType.name),
                          const SizedBox(height: 10),
                          //************************textField :email user */
                          TextFieldUseAll(
                            controller: emailController,
                            hint: KeyLang.email,
                            iconuse: Icons.email,
                            type: TextInputType.emailAddress,
                          ),

                          //**********************************************Textfailed password and confirm
                          const SizedBox(height: 10),
                          TextFieldPassword(
                              KeyLang.password, passwordController),
                          const SizedBox(height: 10),

                          //************************************************************button login

                          const SizedBox(height: 40),
                          InkWell(
                              onTap: () async {
                                User? user = await auth.signUp(
                                    emailController.text,
                                    passwordController.text);
                                if (user != null) {
                                  print(
                                      'Buyer signed up successfully: ${user.uid}');
                                  await buyer.addBuyer(
                                      username: nameController.text,
                                      email: emailController.text);
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pageverified(
                                          email: emailController.text),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: auth.errorMessage.split(']')[1],
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 50,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  print('Buyer sign up failed');
                                }
                              },
                              child: const Button(textButton: KeyLang.signup)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: const Divider(color: Colors.grey, height: 2),
                          ),
                          InkWell(
                            onTap: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => const LoginPage());
                              Navigator.push(context, route);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.bottomCenter,
                              child: const Text(
                                'alredy Account ! click here',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
