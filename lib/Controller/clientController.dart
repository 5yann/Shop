

// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/supplier_bill_client.dart';
import 'package:myshop/Providers/clientListProvider.dart';
import 'package:provider/provider.dart';

class ClientController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<Clientlistprovider>().Clients.length,
      itemBuilder: (context, index) {
        Client client = context.watch<Clientlistprovider>().Clients[index];
        return InkWell(
          child: inkWellContact(context,client),
        );
      },
    );
  }
}
