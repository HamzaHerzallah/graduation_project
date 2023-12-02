import 'package:flutter/material.dart';
import 'package:graduation_project/Models/seller_model.dart';
import 'item_card.dart';
import 'package:graduation_project/services/Firebase/item_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:graduation_project/Models/item_model.dart';
import 'package:provider/provider.dart';

class HomePageBuyer extends StatelessWidget {
  const HomePageBuyer({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerFirestore seller = Provider.of<SellerFirestore>(context);
    final List<String> categories = [
      'All',
      'Food',
      'Sweets',
      'Perfumes',
      'Hand Made',
    ];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String selectedCategory = categories[index];
                    },
                    child: Text(categories[index]),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<SellerModel>>(
              future: seller.getAllSellers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No sellers available.'),
                  );
                } else {
                  List<SellerModel> sellers = snapshot.data!;
                  return ListView.builder(
                    itemCount: sellers.length,
                    itemBuilder: (context, index) {
                      SellerModel sellerModel = sellers[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SellerItemsPage(seller: sellerModel),
                              ),
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: sellerModel.profilePicture != ''
                                  ? NetworkImage(
                                      sellerModel.profilePicture ?? '')
                                  : const AssetImage(
                                          'assets/images/defaultAvatar.png')
                                      as ImageProvider,
                            ),
                            title: Text(
                              sellerModel.projectName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  'Username: ${sellerModel.username}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Category: ${sellerModel.category}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SellerItemsPage extends StatefulWidget {
  final SellerModel seller;

  const SellerItemsPage({required this.seller, Key? key}) : super(key: key);

  @override
  State<SellerItemsPage> createState() => _SellerItemsPageState();
}

class _SellerItemsPageState extends State<SellerItemsPage> {
  @override
  Widget build(BuildContext context) {
    final ItemFirestore items = Provider.of<ItemFirestore>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text(
          '${widget.seller.projectName}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: StreamBuilder<List<ItemModel>>(
        stream: items.getItemsForSellerStream(widget.seller.sellerId ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No items available.',
                style: TextStyle(color: Colors.deepPurple),
              ),
            );
          } else {
            List<ItemModel> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                ItemModel item = items[index];
                return ItemCard(item: item);
              },
            );
          }
        },
      ),
    );
  }
}
