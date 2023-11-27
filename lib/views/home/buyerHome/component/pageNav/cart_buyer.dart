import 'package:flutter/material.dart';
import 'package:graduation_project/services/constant/path_images.dart';
import 'package:graduation_project/views/login_signup/component/button.dart';

class CartPageBuyer extends StatelessWidget {
  const CartPageBuyer({super.key});

  @override
  Widget build(BuildContext context) {
    int price = 10;
    String nameSeller = 'nameSeller';
    String nameProdcut = 'nameProduct';
    int numItem = 25;

    int numOfOneProduct = _CounterItemState.counter;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Shopping Cart',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              const SizedBox(height: 5),
              Text(
                'Total($numItem) Item',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: ListView.builder(
                  itemCount: numItem,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Card(
                          elevation: 10,
                          child: ListTile(
                            leading: const Image(
                                image: AssetImage(PathImage.clothes1)),
                            title: Text(
                              nameProdcut,
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(nameSeller),
                                Text('Price  \$ $price')
                              ],
                            ),
                            trailing: const SizedBox(
                                height: 50, width: 80, child: CounterItem()),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '\$$price',
                    style: const TextStyle(fontSize: 25, color: Colors.red),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                child: const Button(textButton: 'Make order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterItem extends StatefulWidget {
  const CounterItem({super.key});

  @override
  State<CounterItem> createState() => _CounterItemState();
}

class _CounterItemState extends State<CounterItem> {
  static int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (counter > 1) counter--;
            });
          },
          child: Container(
            alignment: Alignment.center,
            child: const Icon(Icons.remove),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.2),
          width: 30,
          height: 30,
          alignment: Alignment.center,
          child: Text(
            '$counter',
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              counter++;
            });
          },
          child: Container(
            alignment: Alignment.center,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
