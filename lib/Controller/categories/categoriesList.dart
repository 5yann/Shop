// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
//import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/Providers/categoriesProvider.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return inkWellitem(context, context.watch<CategoriesProvider>().Categories[index].categoryname);


      },
      itemCount: context.watch<CategoriesProvider>().Categories.length,
    );

  }
}