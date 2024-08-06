import 'package:flutter/material.dart';
//import 'package:myshop/Controller/registerFieldcontrol.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/View/items/allitemslist.dart';
import 'package:myshop/View/categoriespage.dart';

InkWell inkWell(String S){

  return InkWell(
    child: card(S),
  );
}

InkWell inkWellCategories(BuildContext context,String S){

  return InkWell(
    onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoriesPage()),
            );
          },
    child: card(S),
  );
}

InkWell inkWellItems(BuildContext context,String S){

  return InkWell(
    onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Allitemslist()),
            );
          },
    child: card(S),
  );
}