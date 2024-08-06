import 'package:flutter/material.dart';
//import 'package:myshop/Controller/global_sell_graph_controller.dart';

Drawer drawer(){
  return const Drawer();
}

Card card(String S){

  return  Card(
      //margin: const EdgeInsets.all(6),
      color: const Color.fromARGB(246, 146, 69, 142),
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 216, 222, 220),
      child: SizedBox(
        width: 100,
        height: 100,
        child:  Center(
        child: Text(S,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: Color.fromARGB(255, 215, 222, 223)
        ),),
      ),
      ),
    );
}
Card graphsells(){
  return const Card(
                child: SizedBox(
                  height: 200,
                  width: 400,
                  //child: LineChartSample(),
                ),
              );
}

AppBar homepageAppBar(){
  return AppBar(
        title: const Text('Myshop'),
        backgroundColor:const Color.fromARGB(128, 96, 31, 142),
  );
}