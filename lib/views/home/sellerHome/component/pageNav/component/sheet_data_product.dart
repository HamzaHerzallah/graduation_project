import 'package:flutter/material.dart';
import 'package:graduation_project/services/Firebase/item_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/views/login_signup/component/button.dart';
import 'package:graduation_project/views/login_signup/component/text_username.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BottomSheetAdd extends StatefulWidget {
  const BottomSheetAdd({super.key});

  @override
  State<BottomSheetAdd> createState() => _BottomSheetAddState();
}

class _BottomSheetAddState extends State<BottomSheetAdd> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SellerFirestore seller = Provider.of<SellerFirestore>(context);
    final ItemFirestore item = Provider.of<ItemFirestore>(context);

    return SingleChildScrollView(
      child: Container(
        padding: item.isLoading
            ? const EdgeInsets.symmetric(vertical: 10)
            : EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: item.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Add New Product',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //*name product
                  TextFieldUseAll(
                    hint: 'Title',
                    iconuse: Icons.post_add,
                    type: TextInputType.text,
                    controller: titleController,
                  ),
                  const SizedBox(height: 15),
                  //*price product
                  TextFieldUseAll(
                    hint: 'Enter price product',
                    iconuse: Icons.attach_money_outlined,
                    controller: priceController,
                    type: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  //*description for product
                  TextFieldUseAll(
                    hint: 'Enter a description here',
                    iconuse: Icons.description,
                    controller: descriptionController,
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  //*url Image convert to image picker

                  //********************************************************************image picker */
                  Row(
                    mainAxisAlignment: item.image == null
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: [
                      Text(
                        item.image == null
                            ? 'Add image for product'
                            : 'Image Uploaded',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                      //*button gallery
                      item.image == null
                          ? ElevatedButton(
                              onPressed: () async {
                                XFile image = await selectImageFromGallery();
                                item.setImage = image;
                              },
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.deepPurple)),
                              child: const Text(
                                'Gallary',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : const Text(''),
                      //*button camera
                      item.image == null
                          ? ElevatedButton(
                              onPressed: () async {
                                XFile image = await selectImageFromCamera();
                                item.setImage = image;
                              },
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.deepPurple)),
                              child: const Text(
                                'Camera',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : const Text(''),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // TextFieldUseAll(
                  //   hint: ' + add image your product ',
                  //   iconuse: Icons.image,
                  //   controller: imageController,
                  //   type: TextInputType.text,
                  // ),
                  // const SizedBox(height: 15),

                  //*****************************************************************************************

                  //*row contains two button cancel and add post
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          item.setImage = null;
                          Navigator.pop(context);
                        },
                        child: const Button(textButton: 'Cancel'),
                      ),
                      InkWell(
                        onTap: () async {
                          item.setLoading = true;
                          await item.addItem(
                              description: descriptionController.text,
                              price: priceController.text,
                              sellerId: seller.seller?.sellerId,
                              title: titleController.text);
                          item.setImage = null;
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        child: const Button(textButton: 'Add Post'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Future selectImageFromGallery() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    return pickedImage;
  }

  Future selectImageFromCamera() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    return pickedImage;
  }
}
