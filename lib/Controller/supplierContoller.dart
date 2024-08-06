// ignore_for_file: use_super_parameters, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/supplier_bill_client.dart';
import 'package:myshop/Providers/supplierListProvider.dart';
import 'package:provider/provider.dart';

class Suppliercontoller extends StatelessWidget {
  
   @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<Supplierlistprovider>().Suppliers.length,
      itemBuilder: (context, index) {
        Supplier supplier = context.watch<Supplierlistprovider>().Suppliers[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: inkWellsupplierdetails(context, supplier),
          
        );
      },
    );
  }
}