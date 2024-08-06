import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Providers/DeliveriesProvider.dart';
import 'package:myshop/Providers/categoriesProvider.dart';
import 'package:myshop/Providers/clientListProvider.dart';
import 'package:myshop/Providers/deliveriesSelectionmodeNotifier.dart';
import 'package:myshop/Providers/global_sells_graph_provider.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:myshop/Providers/supplierListProvider.dart';
import 'package:myshop/View/welcome.dart';
import 'package:myshop/firebase_options.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GraphAllSells()),
        ChangeNotifierProvider(create:(context) =>CategoriesProvider()),
        ChangeNotifierProvider(create:(context)=>itemsProvider()),
        ChangeNotifierProvider(create: (context)=>Supplierlistprovider()),
        ChangeNotifierProvider(create: (context)=>Clientlistprovider()),
        ChangeNotifierProvider(create: (context)=>Deliveriesprovider()),
        ChangeNotifierProvider(create: (context)=>SelectionModeNotifier())
      ],
      child: const MyApp(),
    ),
   );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const welcome(),
    );
  }
}

