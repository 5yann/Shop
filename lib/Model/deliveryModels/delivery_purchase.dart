import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Model/billmodel.dart';
//import 'package:myshop/Controller/Delivery/deliveriesready.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Providers/DeliveriesProvider.dart';
import 'package:myshop/Providers/clientListProvider.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:myshop/View/deliveries/deliverieshomescreen.dart';
import 'package:pdf/pdf.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../iteems/item_category.dart';
//import 'package:intl/intl.dart';
//import 'package:myshop/Model/iteems/item_category.dart';
//import 'package:myshop/Model/supplier_bill_client.dart';


class Delivery{
 final String title;
  String status;
 List<int> itemsid;
 List<int> itemsqty;
 final int idclient;
 final String dated;
 final String date;
 int nbrItems;
 double priceTot;


 Delivery({
 required this.title,
 required this.status,
 required this.itemsid,
 required this.itemsqty,
 required this.idclient,
 required this.dated,
 required this.date,
 required this.nbrItems,
 required this.priceTot});

   Map<String, dynamic> toMap() {
    return {
     'title':title,
     'status':status,
     'itemsid':itemsid,
     'itemsqty':itemsqty,
     'idclient':idclient,
     'dated':dated,
     'date':date,
     'nbrItems':nbrItems,
     'priceTot':priceTot,
    };
  }

   factory Delivery.fromDocument(DocumentSnapshot doc) {
    return Delivery(
      title: doc['title'],
      status: doc['status'],
      itemsid:doc['itemsid'],
      itemsqty:doc['itemsqty'],
      idclient : doc['idclient'],
      dated : doc['dated'],
      date : doc['date'],
      nbrItems: doc['nbrItems'],
      priceTot: doc['priceTot'],
    );
  }
}


  InkWell inkWellDelivery(BuildContext context,String S){

  return InkWell(
    onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Deliverieshomescreen()),
            );
          },
    child: card(S),
  );
}


 
  InkWell deliverytype(BuildContext context,Color c,Widget w,String s){
   return InkWell(
       onTap: () {
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => w),
            );
       },
    focusColor: c,
    child: Card(
      //margin: const EdgeInsets.all(6),
      color: c,
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 216, 222, 220),
      child: SizedBox(
        width: 1000,
        height: 80,
        child:  Center(
        child: Text(s,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: Color.fromARGB(255, 215, 222, 223)
        ),),
      ),
      ),
    )
   );
 }
 // map for delivery piechart
 Map<String,double> getmap(BuildContext context){

       final Map<String, double> dataMap = {
    "Ready": context.watch<Deliveriesprovider>().getdeliveries('Ready').length.toDouble(),
    "In Progress": context.watch<Deliveriesprovider>().getdeliveries('In Progress').length.toDouble(),
    "Completed": context.watch<Deliveriesprovider>().getdeliveries('Completed').length.toDouble(),
  };
  return dataMap;

 }
  //colors for delivery piechart
    final colorList = <Color>[
   Colors.blueGrey,
   Colors.blue,
   Colors.green,
  ];
 //delivery piechart
  PieChart deliverypiechart(BuildContext context){
    return PieChart(
            dataMap: getmap(context),
            chartType: ChartType.disc,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 40,
            chartRadius: MediaQuery.of(context).size.width ,
            //chartRadius: 30,
            colorList: colorList,
            ringStrokeWidth: 50,
            legendOptions: const LegendOptions(
              showLegends: true,
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              legendShape :BoxShape.circle,
              legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70
        ),
            ),
          );
  }


  
Card deliverydetails(Delivery D, BuildContext context){
  return Card(
      shadowColor:Colors.black87 ,
      color: statuscolor(D.status),
      child: Column(
        children: [
         Padding(
          padding:  const EdgeInsets.all(10.0),
                child:  Text(D.title)
         ),
         const Divider(),
         Column(
          children: [
            ..._buildRows(D,context),
          ],
         ),
         Text('                    Total : ${D.priceTot}'),
         const Divider(),
         Text('create on ${D.date}'),
         Text('ClientName  : ${context.read<Clientlistprovider>().getcl(D.idclient).name}'),
         Text('Contact : ${context.read<Clientlistprovider>().getcl(D.idclient).contact}'),
         Text('Delivery location : ${context.read<Clientlistprovider>().getcl(D.idclient).adress}'),
         Text('Estimated delivery date: ${D.dated}'),

      ],),

  );
}

  List<Widget> _buildRows(Delivery D,BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < D.itemsid.length; i++) {
      rows.add(
        Row(
          children: [
           Text('Item $i : ${context.read<itemsProvider>().getItem(D.itemsid[i]).name}'),
           Text('${context.read<itemsProvider>().getItem(D.itemsid[i]).price} * ${D.itemsqty[i]}')
          ],
        ),
      );
    }
    return rows;
  }

  AlertDialog confirmNewDelivery(Delivery D,BuildContext context){
    return AlertDialog(
       title: deliverydetails(D, context),
       actions: [
        TextButton(onPressed: (){
           if(checktitle(D, context)){
              showDialogSametitleDeliv(D, context);
           } 
           else{
            context.read<Deliveriesprovider>().adddl(D);
            for(int i=0;i<D.itemsid.length;i++){
            Item I = context.read<itemsProvider>().getItem(D.itemsid[i]);
            I.quantity=I.quantity-D.itemsqty[i];
            context.read<itemsProvider>().updadeItem(I, context, false);
          }
           Navigator.pop(context); 
           Navigator.pop(context);
           }
           
           // Ferme le dialog
           // Navigator.popUntil(context, ModalRoute.withName('DeliveriesReadyPage'));
        },
         child:const  Text('Confirm')),
         TextButton(
          onPressed:(){
            Navigator.pop(context);
          }, 
         child:const  Text('Cancel') )
       ],
    );
  }


   Future<void> showMyDialog(Delivery D, BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext ctx) {
          return confirmNewDelivery(D, context);
        });
  }
// choose color depending on status 
Color statuscolor(String s){
  Color C =Colors.black;
  if(s.compareTo('Ready')==0) C=Colors.blueGrey;
  if(s.compareTo('In Progress')==0) C=Colors.blue;
  if(s.compareTo('Completed')==0) C=Colors.green;
  return C;
}
// inkwell for deliverydetails with onlongpress to change status 
 InkWell inkWelldeliverydetails(BuildContext context,Delivery D,String s,bool b){
  return InkWell(
    onDoubleTap: () async {
      Bill bill =getBill(D, context);
     
       final pdfFile = await  generateInvoicePdf(bill, context);
            await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => pdfFile,
            );
    },
    onLongPress: () {
     if(b){
      showDialog(
      context: context,
       builder: (BuildContext ctx){
        return AlertDialog(
          title: Text('Do you want to change your the status of this Delivery to \'$s\' ?'),
          content: Row(
            children: [
               TextButton(
                                     onPressed: (){
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('no')),
                 TextButton(
                                     onPressed: (){
                                      D.status=s;
                                       context.read<Deliveriesprovider>().updateDelivery(D);
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('yes')),                     
            ],
          ),
        );
       });
     } 
    }
    ,
    child: deliverydetails(D, context)
  );
}

Future<void> showDialogSametitleDeliv(Delivery D, BuildContext context) async{
  return showDialog(
              context: context, 
              builder:  (BuildContext ctx) {
          return AlertDialog(
                    title: Text('There is already a delivery with title \'${D.title}\'') ,
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, 
                        child: const Text('ok'))
                    ],
          );
        });
}

bool checktitle(Delivery D ,BuildContext ctx){
  bool b=false;
  for(int i=0;i<ctx.read<Deliveriesprovider>().deliveries.length;i++){
    if(ctx.read<Deliveriesprovider>().deliveries[i].title.compareTo(D.title)==0)  b=true;
   
  }
  return b;
}