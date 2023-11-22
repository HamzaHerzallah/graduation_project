import 'package:flutter/material.dart';
import 'package:graduation_project/services/constant/path_images.dart';
import 'package:graduation_project/views/login_signup/component/button.dart';

class ProfilePageSeller extends StatelessWidget {
  const ProfilePageSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image user
            Container(
              width: 200,
              height: 200,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: const Image(
                fit: BoxFit.fill,
                image: AssetImage(PathImage.userImage),
              ),
            )
            //* user name
            ,
            const SizedBox(
              height: 15,
            ),
            const Text(
              'user name',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
            //* email user
            ,
            const Text(
              'Email address@.com ',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            )
            //*button edit Profile
            ,
            const SizedBox(height: 15),
            const Button(textButton: 'Edit Profile')

            //*setting
            ,
            const ProfileMenuWidget(
                title: 'Setting', icon: Icons.settings_outlined),
            const ProfileMenuWidget(title: 'dark', icon: Icons.dark_mode),
            const ProfileMenuWidget(title: 'information', icon: Icons.info),
            const ProfileMenuWidget(
                title: 'Log out', icon: Icons.logout, endIcon: false)
            //*
          ],
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      this.endIcon = true});
  final String title;
  final IconData icon;
  // final Function onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(20)),
            child: Icon(icon)),
        title: Text(title),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[300]),
                child:
                    const Icon(Icons.arrow_right, color: Colors.grey, size: 18),
              )
            : null);
  }
}
