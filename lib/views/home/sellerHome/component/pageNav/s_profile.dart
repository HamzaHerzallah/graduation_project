import 'package:flutter/material.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:graduation_project/services/constant/path_images.dart';
import 'package:graduation_project/views/login_signup/component/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ProfilePageSeller extends StatelessWidget {
  const ProfilePageSeller({super.key});

  @override
  Widget build(BuildContext context) {
    SellerFirestore seller = Provider.of<SellerFirestore>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Image(
                    fit: BoxFit.fill,
                    image: seller.seller?.profilePicture != ''
                        ? NetworkImage(seller.seller?.profilePicture ?? '')
                            as ImageProvider
                        : const AssetImage(PathImage.userImage),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Change Profile Picture',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
                              content: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        seller.pickGalleryImage();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.image),
                                      label: const Text('Sellect From Gallery'),
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        seller.pickCameraImage();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.photo_camera),
                                      label: const Text('Take a Picture'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(
                        Icons.photo_camera_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              seller.seller?.username ?? '',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              seller.seller?.email ?? '',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            const Button(textButton: 'Edit Profile'),
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
    UserAuth auth = Provider.of<UserAuth>(context);

    return ListTile(
        onTap: () async {
          if (title == 'Log out') {
            await auth.signOut();
            if (context.mounted) {
              Phoenix.rebirth(context);
            }
          }
        },
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
