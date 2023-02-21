
import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Saved Screens')),
      body: const Center(
        child: Text('Product Saved Screens', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
