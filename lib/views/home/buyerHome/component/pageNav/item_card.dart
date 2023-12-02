import 'package:flutter/material.dart';
import 'package:graduation_project/Models/item_model.dart';
import 'package:graduation_project/services/Firebase/item_firestore.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);
  final ItemModel item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    final ItemFirestore items = Provider.of<ItemFirestore>(context);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(widget.item.image ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.deepPurple[400],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.item.price}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.item.description ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (count > 1) {
                                count -= 1;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$count',
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              count += 1;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {
                        if (items.items.isNotEmpty) {
                          if (items.items[0]['sellerId'] ==
                              widget.item.sellerId) {
                            final temp = items.items;
                            bool found = false;
                            for (int i = 0; i < temp.length; i++) {
                              if (temp[i]['itemId'] == widget.item.itemId) {
                                temp[i]['count'] += count;
                                found = true;
                                break;
                              }
                            }
                            if (!found) {
                              temp.add(
                                  {...widget.item.toMap(), 'count': count});
                            }
                            items.updateItems(temp);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'You can\'t add product to cart from two sellers in same time\nClear the cart first',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.deepPurple[400],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        } else {
                          final temp = items.items;
                          bool found = false;
                          for (int i = 0; i < temp.length; i++) {
                            if (temp[i]['itemId'] == widget.item.itemId) {
                              temp[i]['count'] += count;
                              found = true;
                              break;
                            }
                          }
                          if (!found) {
                            temp.add({...widget.item.toMap(), 'count': count});
                          }
                          items.updateItems(temp);
                        }
                      },
                      child: const Text(
                        'Add to Cart',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
