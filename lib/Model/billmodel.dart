
// ignore_for_file: deprecated_member_use

import 'dart:typed_data';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/Model/supplier_bill_client.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Providers/clientListProvider.dart';
//import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'package:printing/printing.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';

class Bill {
  Delivery delivery;
  final List<InvoiceItem> items;
  final String duedate;
  final Account account;
  Bill({
    required this.delivery,
    required this.account,
    required this.duedate,
    required this.items,
  });
}

class InvoiceItem {
  late final String description;
 late  final int quantity;
 late final double unitPrice;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => quantity * unitPrice;
}

class Account {
  final String bankName;
  final String accountOwner;
  final String accountNumber;

  Account({required this.bankName, required this.accountOwner, required this.accountNumber});
}

 Future<Uint8List> generateInvoicePdf(Bill invoice,BuildContext context) async {
  final pdf = pw.Document();
  Client providervalue =context.read<Clientlistprovider>().getcl(invoice.delivery.idclient);
  final String clientName = providervalue.name;
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text('MyShop')
            ),
             pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Column(
                  children: [
                    pw.Text('ISSUE TO:',
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),),
                    pw.Text(clientName),
                    pw.Text(providervalue.contact),
                    pw.Text(providervalue.adress??'Adress : '),
                  ]
                ),
                pw.Column(
                  children: [
                    pw.Text('INVOICE NO :  ',
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),),
                    pw.Text('Date :  '),
                    pw.Text('Due Date :   ${invoice.duedate}'),
                  ]
                )
              ],
            ),
           pw.Divider(),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Description', 'Quantity', 'Unit Price', 'Total Price'],
              data: invoice.items.map((item) {
                return [
                  item.description,
                  item.quantity.toString(),
                  item.unitPrice.toStringAsFixed(2),
                  item.totalPrice.toStringAsFixed(2),
                ];
              }).toList(),
            ),
            pw.Divider(),
            pw.Text(
              'Total: ${invoice.items.fold(0.0, (total, item) => total + item.totalPrice).toStringAsFixed(2)}',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
             pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [                  
              pw.Column(children: [
                pw.Text('BANK DETAILS',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),),
                pw.Text('BankName : ${invoice.account.bankName}'),
                pw.Text('Account Owner : ${invoice.account.accountOwner}'),
                pw.Text('Account Number : ${invoice.account.accountNumber}'),
              ]),
              pw.Column(children: [
                pw.Text('THANK YOU',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),),
              ])
            ])
          ],
        );
      },
    ),
  );

  return pdf.save();
}

List<InvoiceItem> getInvoceItem(Delivery D,BuildContext context){
  List<InvoiceItem> list=[];
  for(int i=0;i<D.itemsid.length;i++){
    Item providervalue =context.read<itemsProvider>().getItem(D.itemsid[i]);
    list.add(
      InvoiceItem(
      description: providervalue.description??'/',
      unitPrice :providervalue.price,
      quantity:D.itemsqty[i])
    );
  }
  return list;
}

Account _account(){
  return Account(bankName: 'UNICREDIT', 
                 accountOwner: 'BOREL NGAHOU', 
                 accountNumber: 'IT04C3 6678 9907 0978 3654');
}

Bill  getBill(Delivery D, BuildContext context){
  return Bill(
              delivery: D,
              account: _account(), 
              duedate: 'duedate', 
              items: getInvoceItem(D, context));
}