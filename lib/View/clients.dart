// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:myshop/Controller/clientController.dart';
import 'package:myshop/Model/supplier_bill_client.dart';
//import 'package:provider/provider.dart';

class ClientList extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Clients"),
        backgroundColor: const Color.fromARGB(255, 7, 81, 255),
        actions: [
          IconButton(
            onPressed: () => showSimpleDialogAddclient(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/wp2.jpg',
              fit: BoxFit.cover,
            ),
          ),
           ClientController(),
        ],
      ),
    );
  }
}
