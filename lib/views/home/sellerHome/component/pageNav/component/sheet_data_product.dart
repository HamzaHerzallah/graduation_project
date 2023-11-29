import 'package:flutter/material.dart';
import 'package:graduation_project/services/Firebase/item_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/views/login_signup/component/button.dart';
import 'package:graduation_project/views/login_signup/component/text_username.dart';
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
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Add New Product',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 15),
            TextFieldUseAll(
              hint: 'Title',
              iconuse: Icons.post_add,
              type: TextInputType.text,
              controller: titleController,
            ),
            const SizedBox(height: 15),
            TextFieldUseAll(
              hint: 'Enter price product',
              iconuse: Icons.attach_money_outlined,
              controller: priceController,
              type: TextInputType.number,
            ),
            const SizedBox(height: 15),
            TextFieldUseAll(
              hint: 'Enter a description here',
              iconuse: Icons.description,
              controller: descriptionController,
              type: TextInputType.text,
            ),
            const SizedBox(height: 15),
            TextFieldUseAll(
              hint: ' + add image your product ',
              iconuse: Icons.image,
              controller: imageController,
              type: TextInputType.text,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Button(textButton: 'Cancel'),
                ),
                InkWell(
                  onTap: () async {
                    await item.addItem(
                        description: descriptionController.text,
                        image: imageController.text,
                        price: priceController.text,
                        sellerId: seller.seller?.sellerId,
                        title: titleController.text);
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
}
