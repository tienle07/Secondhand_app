import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/home.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(
        child: Text('Cart Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
