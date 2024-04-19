import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:graduation_project/Models/item_model.dart';
import 'package:graduation_project/services/Firebase/user_auth.dart';
import 'package:image_picker/image_picker.dart';

class ItemFirestore extends ChangeNotifier {
  final CollectionReference _itemCollection =
      FirebaseFirestore.instance.collection('Items');
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  ItemModel? item;
  List<dynamic> items = [];
  bool isLoading = false;
  String errorMessage = '';
  XFile? image;

  set setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  set setMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }

  set setImage(XFile? value) {
    image = value;
    notifyListeners();
  }

  Future<void> addItem({
    price,
    description,
    title,
    sellerId,
  }) async {
    Map<String, dynamic> itemData = {
      'price': price,
      'description': description,
      'sellerId': sellerId,
      'title': title,
    };
    String imageUrl = await uploadItemImage();
    DocumentReference docRef = await _itemCollection.add(itemData);
    String itemId = docRef.id;
    await _itemCollection
        .doc(itemId)
        .update({'itemId': itemId, 'image': imageUrl});
    setLoading = false;
  }

  Stream<List<ItemModel>> getItemsForSellerStream(String sellerId) {
    return _itemCollection
        .where('sellerId', isEqualTo: sellerId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ItemModel.fromMap(data);
      }).toList();
    });
  }

  Stream<int> getItemCountForSellerStream(String sellerId) {
    return _itemCollection
        .where('sellerId', isEqualTo: sellerId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }

  Future<void> deleteItem(String itemId) async {
    try {
      await _itemCollection.doc(itemId).delete();
      // ignore: avoid_print
      print('Item deleted successfully.');
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting item: $e');
      // Handle the error as needed
    }
  }

  void updateItems(List<dynamic> updatedItems) {
    items = updatedItems;
    notifyListeners();
  }

  Future<String> uploadItemImage() async {
    final User user = UserAuth().currentUser;
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('/itemImage/${user.uid}');
    firebase_storage.UploadTask uploadTask =
        ref.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    return await ref.getDownloadURL();
  }
}
