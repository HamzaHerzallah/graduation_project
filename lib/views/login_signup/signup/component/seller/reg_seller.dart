import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:graduation_project/views/login_signup/signup/component/verifiication/verify.dart';
import 'package:provider/provider.dart';

import 'dropmenu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../services/language/generated/key_lang.dart';
import '../../../component/button.dart';
import '../../../component/text_pass.dart';
import '../../../component/text_username.dart';
import '../../../login/login.dart';

class RegisterSeller extends StatefulWidget {
  const RegisterSeller({super.key});

  @override
  State<RegisterSeller> createState() => _RegisterSellerState();
}

class _RegisterSellerState extends State<RegisterSeller> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  String selectedCategory = 'Food';
  final TextEditingController phoneController = TextEditingController();

  void handleCategorySelection(String category) {
    selectedCategory = category;
  }

  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final UserAuth auth = Provider.of<UserAuth>(context);
    final SellerFirestore seller = Provider.of<SellerFirestore>(context);

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[400],
            title: const Text(KeyLang.seller),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //*textFiald : fill the name user
                        TextFieldUseAll(
                          hint: KeyLang.userName,
                          iconuse: Icons.person,
                          type: TextInputType.name,
                          controller: nameController,
                        ),
                        const SizedBox(height: 10),
                        //************************textField :email user */
                        TextFieldUseAll(
                          hint: KeyLang.email,
                          iconuse: Icons.email,
                          type: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        const SizedBox(height: 10),
                        TextFieldUseAll(
                          hint: KeyLang.projectName,
                          iconuse: Icons.work,
                          type: TextInputType.text,
                          controller: projectNameController,
                        ),

                        const SizedBox(height: 10),
                        TextFieldUseAll(
                          hint: KeyLang.phone,
                          iconuse: Icons.phone,
                          type: TextInputType.phone,
                          controller: phoneController,
                        ),

                        //**********************************************Textfailed password and confirm
                        const SizedBox(height: 10),
                        TextFieldPassword(KeyLang.password, passwordController),
                        const SizedBox(height: 10),
                        DropDownMenuDepart(
                          onCategorySelected: handleCategorySelection,
                          dismissKeyboard: _dismissKeyboard,
                        ),
                        //************************************************************button signUp

                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () async {
                            User? user = await auth.signUp(
                                emailController.text, passwordController.text);
                            if (user != null) {
                              // ignore: avoid_print
                              print(
                                  'Seller signed up successfully: ${user.uid}');
                              await seller.addSeller(
                                  username: nameController.text,
                                  projectName: projectNameController.text,
                                  category: selectedCategory,
                                  phoneNumber: phoneController.text,
                                  email: emailController.text);
                              if (mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pageverified(
                                        email: auth.currentUser.email ?? ''),
                                  ),
                                );
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: auth.errorMessage.split(']')[1],
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 50,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              // ignore: avoid_print
                              print('Seller sign up failed');
                            }
                          },
                          child: const Button(textButton: KeyLang.signup),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: const Divider(color: Colors.grey, height: 2),
                        ),
                        InkWell(
                          onTap: () {
                            var route = MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            );
                            Navigator.push(context, route);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.bottomCenter,
                            child: const Text(
                              'Already have account? Login',
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
