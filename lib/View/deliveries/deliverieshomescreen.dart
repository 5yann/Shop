// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:myshop/Controller/Delivery/deliveriesstatcontroller.dart';

class Deliverieshomescreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deliveries"),
        backgroundColor: const Color.fromARGB(255, 7, 81, 255),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/wp2.jpg',
              fit: BoxFit.cover,
            ),
          ),
           Deliveriesstatcontroller()
        ],
      ),
    );
  }
}
