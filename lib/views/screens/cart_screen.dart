import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/viewmodels/cart_view_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Course> _cart = [];
  num _totalPrice = 0;

  String calculateTotalPrice() {
    num box = 0;
    for (var each in _cart) {
      box += each.coursePrice;
    }
    _totalPrice = box;
    return '$_totalPrice';
  }

  @override
  void initState() {
    super.initState();
    _cart = CartViewModel.list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Total price: ${calculateTotalPrice()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _cart.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(_cart[index].courseTitle),
                tileColor: Colors.white,
                subtitle: Text('\$${_cart[index].coursePrice}'),
                trailing: IconButton(
                  onPressed: () {
                    CartViewModel.list.removeAt(index);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
            left: 10,
            right: 10,
          ),
          child: InkWell(
            onTap: () {
              if (_cart.isNotEmpty) {
                _cart.clear();
                setState(() {});
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Successfully bought'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Okki dokki'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Ink(
              height: 50,
              width: double.infinity,
              color: Colors.white,
              child: const Center(
                child: Text('Buy'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
