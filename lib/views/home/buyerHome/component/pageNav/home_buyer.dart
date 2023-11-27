import 'package:flutter/material.dart';
import 'package:graduation_project/Models/seller_model.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:provider/provider.dart';

class HomePageBuyer extends StatelessWidget {
  const HomePageBuyer({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerFirestore seller = Provider.of<SellerFirestore>(context);

    return Scaffold(
      body: FutureBuilder<List<SellerModel>>(
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
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: sellerModel.profilePicture != ''
                          ? NetworkImage(sellerModel.profilePicture ?? '')
                          : const AssetImage('assets/images/defaultAvatar.png')
                              as ImageProvider,
                    ),
                    title: Text(
                      sellerModel.username ?? '',
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
                          'Project: ${sellerModel.projectName}',
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
