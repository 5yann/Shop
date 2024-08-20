import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Controller/Delivery/createnewdeliv.dart';
import 'package:myshop/Controller/client_deliveries_controller.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/Providers/clientListProvider.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:myshop/View/clients.dart';
import 'package:provider/provider.dart';

class Client {
  final int id;
  final String name;
  final String contact;
  final String? adress;
  final String? email;
  List<Item> list ;

  Client ({required this.id,
  required this.name,
  required this.contact,
  required this.adress,
  required this.email,
  required this.list});

  Map<String, dynamic> toMap() {
    return {
     'id':id,
     'name':name,
     'contact':contact,
     'adress':adress,
     'email':email,
     'list' : list,
    };
  }

  factory Client.fromDocument(DocumentSnapshot doc) {
    return Client(
      id:doc['id'],
      name: doc['name'],
      contact: doc['contact'],
      adress: doc['adress'],
      email: doc['email'],
      list: doc['list'],
    );
  }
}




Container clientDetails(Client client,BuildContext context) {
  String itemsSupplied = client.list.map((item) => item.name).join(', ');

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: Colors.blue, width: 1.0),
      borderRadius: BorderRadius.circular(1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Row(
          children: [
            const Icon(Icons.person,
            size: 50,),
            Text(client.name,
            style: clienttextstyle(),
            ),
          ],
        ),
        Row(
          children: [
            Text('Contact: ',
            style: clienttextstyle()),
            Text(client.contact,
            style: clienttextstyle()),
          ],
        ),
        Row(
          children: [
             Text('Address: ',
             style: clienttextstyle()),
            Text(client.adress ?? '',
             style: clienttextstyle()),
          ],
        ),
       Row(
          children: [
             Text('Email: ',
             style: clienttextstyle()),
            Text(client.email ?? '',
             style: clienttextstyle()),
          ],
        ),
        Text('Items supplied: $itemsSupplied',
        style: clienttextstyle()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  newDelivery(item: client.id)),
            );
              } , 
              child: const Text('New Delivery')),
          ElevatedButton(
            onPressed: (){
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ClientDeliveriesController( id:client.id)),
            );
            } , 
            child: const Text('Deliveries'))
          ],
        ),
      
      ],
    ),
  );
}

FloatingActionButton button(String label) {
  return FloatingActionButton(
    backgroundColor: Colors.transparent,
    onPressed: () {},
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

void showSimpleDialogAddclient(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add a new  client'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(hintText: 'Contact'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(hintText: 'Address'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              String name = nameController.text;
              String contact = contactController.text;
              String address = addressController.text;
              String email = emailController.text;

              int id = context.read<Clientlistprovider>().Clients.length;
              Client client = Client(
                id: id,
                name: name,
                contact: contact,
                adress: address,
                email: email,
                list: context.read<itemsProvider>().globalItems,
              );

              context.read<Clientlistprovider>().addcl(client);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  InkWell inkWellcl(BuildContext context,String S){

  return InkWell(
    onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ClientList()),
            );
          },
    child: card(S),
  );
}

  InkWell inkWellContact(BuildContext context,Client client){
    // String itemsSupplied = client.list.map((item) => item.name).join(', ');
  return InkWell(
    onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ClientList()),
            );*/
          },
    child: clientDetails(client,context)
  );
}


 TextStyle clienttextstyle(){
   return const TextStyle(
      fontWeight: FontWeight.w900,
      color: Colors.white70
   );
 }