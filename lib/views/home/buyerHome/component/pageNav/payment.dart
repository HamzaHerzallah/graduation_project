import 'dart:math';

import 'package:checkout_screen_ui/checkout_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/services/Firebase/buyer_firestore.dart';
import 'package:graduation_project/services/Firebase/item_firestore.dart';
import 'package:graduation_project/services/Firebase/order_firestore.dart';
import 'package:graduation_project/services/Firebase/seller_firestore.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, this.items, required this.notes});

  final items;
  final TextEditingController notes;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List<PriceItem> _priceItems = [];
  bool loading = false;

  @override
  void initState() {
    for (var i = 0; i < widget.items.length; i++) {
      _priceItems.add(PriceItem(
        name: widget.items[i]['title'],
        quantity: widget.items[i]['count'],
        itemCostCents: int.parse(widget.items[i]['price']) * 100,
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrderFirestore orders = Provider.of<OrderFirestore>(context);
    final BuyersFirestore buyer = Provider.of<BuyersFirestore>(context);
    final SellerFirestore seller = Provider.of<SellerFirestore>(context);
    final ItemFirestore items = Provider.of<ItemFirestore>(context);

    final times = [3, 4, 5];
    final random = Random();
    final randomDuration = times[random.nextInt(times.length)];

    return Scaffold(
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: loading,
            child: CheckoutPage(
              data: CheckoutData(
                displayEmail: false,
                isApple: false,
                initBuyerName: buyer.buyer?.username ?? '',
                priceItems: _priceItems,
                payToName: '',
                onCardPay: (results, checkOutResult) {
                  setState(() {
                    loading = true;
                  });
                  Future.delayed(Duration(seconds: randomDuration), () async {
                    final CollectionReference cardCollection =
                        FirebaseFirestore.instance.collection('Cards');
                    QuerySnapshot querySnapshot = await cardCollection
                        .where('cardNumber', isEqualTo: results.cardNumber)
                        .get();
                    if (querySnapshot.docs.isEmpty) {
                      setState(() {
                        loading = false;
                      });
                      Fluttertoast.showToast(
                        msg: 'The entered information is not correct',
                        toastLength: Toast.LENGTH_LONG,
                      );
                    } else {
                      final Map<String, dynamic> data = querySnapshot.docs.first
                          .data() as Map<String, dynamic>;
                      if (data['mm/yy'] != results.cardExpiry ||
                          data['CVV'] != results.cardSec) {
                        setState(() {
                          loading = false;
                        });
                        Fluttertoast.showToast(
                          msg: 'The entered information is not correct',
                          toastLength: Toast.LENGTH_LONG,
                        );
                      } else if (data['balance'] <
                          checkOutResult.totalCostCents / 100) {
                        setState(() {
                          loading = false;
                        });
                        Fluttertoast.showToast(
                          msg: 'Something went wrong',
                          toastLength: Toast.LENGTH_LONG,
                        );
                      } else {
                        setState(() {
                          loading = false;
                        });

                        Fluttertoast.showToast(
                          msg: 'Payment is successful',
                          toastLength: Toast.LENGTH_LONG,
                        );
                        Future.delayed(const Duration(milliseconds: 1200),
                            () async {
                          final projectName =
                              await seller.getProjectNameBySellerId(
                                  items.items[0]['sellerId'] ?? '');
                          await orders.addOrder(
                            buyerId: buyer.buyer?.buyerId,
                            sellerId: items.items[0]['sellerId'],
                            items: items.items,
                            orderstatus: 'Pending',
                            buyerName: buyer.buyer?.username,
                            projectName: projectName,
                            notes: widget.notes.text,
                            payment: 'visa',
                            timeStamp: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                          );
                          items.items.removeWhere((element) => true);
                          items.updateItems(items.items);
                          widget.notes.clear();
                          Fluttertoast.showToast(
                            msg: 'Your order has been sent',
                            toastLength: Toast.LENGTH_LONG,
                          );
                          Navigator.pop(context);
                        });
                      }
                    }
                  });
                },
                onCashPay: (checkOutResult) async {
                  final projectName = await seller.getProjectNameBySellerId(
                      items.items[0]['sellerId'] ?? '');
                  await orders.addOrder(
                    buyerId: buyer.buyer?.buyerId,
                    sellerId: items.items[0]['sellerId'],
                    items: items.items,
                    orderstatus: 'Pending',
                    buyerName: buyer.buyer?.username,
                    projectName: projectName,
                    notes: widget.notes.text,
                    payment: 'cash',
                    timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
                  );
                  items.items.removeWhere((element) => true);
                  items.updateItems(items.items);
                  widget.notes.clear();
                  Fluttertoast.showToast(
                    msg: 'Your order has been sent',
                    toastLength: Toast.LENGTH_LONG,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          if (loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
