import 'package:flutter/material.dart';
import 'package:graduation_project/services/Firebase/item_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/component/sheet_data_product.dart';
import 'package:provider/provider.dart';

class PageAfterCreatePost extends StatelessWidget {
  const PageAfterCreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    ItemFirestore items = Provider.of<ItemFirestore>(context);
    SellerFirestore seller = Provider.of<SellerFirestore>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: items.getItemsForSellerStream(seller.seller?.sellerId ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error: Unable to fetch data'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return cardPost(
                  items: items,
                  itemId: snapshot.data![index].itemId,
                  description: snapshot.data![index].description,
                  image: snapshot.data![index].image,
                  price: snapshot.data![index].price,
                  title: snapshot.data![index].title,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheetAdd();
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.post_add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

//***********************************3.Structure post **********************************
Card cardPost(
    {required String? image,
    required String? title,
    required String? description,
    required String? price,
    required ItemFirestore items,
    required String? itemId}) {
  return Card(
    elevation: 5,
    child: ListTile(
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () async {
                await items.deleteItem(itemId ?? '');
              },
              child:
                  const Text('delete', style: TextStyle(color: Colors.blue))),
        ],
      ),
      leading: Image(
        image: NetworkImage(image ?? ''),
        width: 100,
      ),
      title: Text('$title \n \t\$ $price'),
      subtitle: Text(description ?? ''),
    ),
  );
}
