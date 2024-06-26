import 'package:flutter/material.dart';
import 'package:graduation_project/Models/order_model.dart';
import 'package:graduation_project/services/Firebase/buyer_firestore.dart';
import 'package:graduation_project/services/Firebase/order_firestore.dart';
import 'package:graduation_project/views/home/buyerHome/component/pageNav/rating.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerOrdersPage extends StatelessWidget {
  const BuyerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderFirestore orderFirestore = Provider.of<OrderFirestore>(context);
    final BuyersFirestore buyer = Provider.of<BuyersFirestore>(context);

    return Scaffold(
      body: StreamBuilder<List<OrderModel>>(
        stream:
            orderFirestore.getOrdersForBuyerStream(buyer.buyer?.buyerId ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No orders found.',
                style: TextStyle(color: Colors.deepPurple),
              ),
            );
          } else {
            List<OrderModel> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                OrderModel order = orders[index];
                double totalPrice = 0;
                for (var item in order.items ?? []) {
                  double itemPrice = item['price'] is int
                      ? (item['price'] as int).toDouble()
                      : double.parse(item['price'].toString());
                  double itemCount = item['count'] is int
                      ? (item['count'] as int).toDouble()
                      : double.parse(item['count'].toString());
                  totalPrice += itemPrice * itemCount;
                }
                return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Items',
                              style: TextStyle(color: Colors.black),
                            ),
                            const Text(
                              'notes:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              '${order.notes}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        content: ListView.builder(
                          itemCount: order.items?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                leading: Image(
                                  image: NetworkImage(
                                    order.items?[index]['image'] ?? '',
                                  ),
                                ),
                                title: Text(
                                  order.items?[index]['title'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  'Price (${order.items?[index]['price']}) JD',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                trailing: Text(
                                  '${order.items?[index]['count']}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Project: ${order.projectName}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.deepPurple[400],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Number of Items: ${order.items?.length}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Total Price: ($totalPrice) JD',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          order.orderStatus != 'Pending'
                              ? Column(
                                  children: [
                                    Text(
                                      '${order.orderStatus}',
                                      style: TextStyle(
                                        color: order.orderStatus == 'Accepted'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    order.orderStatus != 'Delivered'
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                            ),
                                            onPressed: () async {
                                              await orderFirestore
                                                  .updateOrderStatus(
                                                order.orderId ?? '',
                                                'Delivered',
                                              );
                                              final SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setBool(
                                                  'rated', false);
                                              await prefs.setString(
                                                  'projectName',
                                                  order.projectName ?? '');
                                              await prefs.setString('sellerId',
                                                  order.sellerId ?? '');
                                              // ignore: use_build_context_synchronously
                                              showDialog(
                                                context: context,
                                                builder: (context) => Rating(
                                                  projectName:
                                                      order.projectName ?? '',
                                                  sellerId:
                                                      order.sellerId ?? '',
                                                ),
                                              );
                                            },
                                            child: const Text('Delivered'),
                                          )
                                        : const Text(''),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      '${order.orderStatus}',
                                      style: const TextStyle(
                                        color: Colors.orange,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await orderFirestore
                                            .deleteOrder(order.orderId ?? '');
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
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
    );
  }
}
