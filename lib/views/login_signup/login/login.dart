import 'package:graduation_project/views/login_signup/component/text_pass.dart';
import 'package:graduation_project/views/login_signup/component/text_username.dart';

import '../../home/buyerHome/home_page.dart';
import '../component/button.dart';
import 'check_box.dart';
import '../../../services/language/generated/key_lang.dart';
import 'package:flutter/material.dart';

import '../signup/body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            // decoration: const BoxDecoration(
            //     gradient: LinearGradient(colors: [Colors.red, Colors.purple])),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        'Hello login!\n \t \t to your account',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(80),
                          )),
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(color: Colors.grey)),
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 30),
                            alignment: Alignment.center,
                            height: 350,
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                //*textFiald user NAme
                                TextFieldUseAll(
                                    hint: KeyLang.userName,
                                    iconuse: Icons.person,
                                    type: TextInputType.text,
                                    controller: nameController),
                                //*Textfailed password
                                const SizedBox(height: 10),
                                TextFieldPassword(
                                    KeyLang.password, passwordController),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CheckBox(),
                                    Text(
                                      'remember me later',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                //*button login],
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    var route = MaterialPageRoute(
                                      builder: (context) =>
                                          const PageHomeBuyer(),
                                    );
                                    Navigator.push(context, route);
                                  },
                                  child:
                                      const Button(textButton: KeyLang.login),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              var route = MaterialPageRoute(
                                  builder: (context) =>
                                      const SelecltBuyerORSeller());
                              Navigator.push(context, route);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.bottomCenter,
                              child: const Text(
                                'Forget your Password ? reset',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              var route = MaterialPageRoute(
                                  builder: (context) =>
                                      const SelecltBuyerORSeller());
                              Navigator.push(context, route);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.bottomCenter,
                              child: const Text(
                                'Don\'t have an account? sign Up ',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      )))
            ]),
          ),
        ),
      ),
    );
  }
}
