import 'package:flutter/material.dart';
import 'package:graduation_project/services/constant/path_images.dart';

class ItemSelectBuyer extends StatelessWidget {
  const ItemSelectBuyer({super.key});

  @override
  Widget build(BuildContext context) {
    int price = 10;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(6, (index) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          const Image(image: AssetImage(PathImage.clothes1)),
                          Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: Text(
                                    '\$$price',
                                    style: const TextStyle(color: Colors.red),
                                  ))),
                          const Positioned(
                              top: 5,
                              right: 5,
                              child: SizedBox(
                                  child: Icon(
                                Icons.favorite_sharp,
                                color: Colors.red,
                              )))
                        ],
                      ),
                      const Text(
                        'Name Product',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text('Name Seller ')
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
