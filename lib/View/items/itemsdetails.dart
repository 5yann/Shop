// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myshop/Controller/items/itemdetailscontroller.dart';
import 'package:myshop/Model/iteems/item_category.dart';

class TabBarItemdetails extends StatelessWidget {
  final Item item;

  const TabBarItemdetails({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(item.name),
          backgroundColor: Colors.blueAccent,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.history_rounded),
              ),
              Tab(
                icon: Icon(Icons.article_rounded),
              ),
              Tab(
                icon: Icon(Icons.person_2),
              ),
              Tab(
                icon: Icon(Icons.delivery_dining_rounded),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            const Center(
              child: Text("It's rainy here"),
            ),
             Itemdetailscontroller(item: item),
            const Center(
              child: Text("It's sunny here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}