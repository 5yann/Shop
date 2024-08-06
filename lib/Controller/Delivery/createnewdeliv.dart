// ignore_for_file: camel_case_types, unused_element, no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';
import 'package:myshop/Model/iteems/item_category.dart';
//import 'package:myshop/Providers/DeliveriesProvider.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:provider/provider.dart';
class newDelivery extends StatefulWidget{
  final int item;
  
  
      const newDelivery({super.key,required this.item});
      
   
  @override
 newDeliveryState createState() => newDeliveryState ();
    
}

class newDeliveryState extends State<newDelivery>{
   late List<Item> _suggestions;
   List<Item> _displayedSuggestions=[];
   List<Item> _selectedProducts = [];
   List<int> _selectedProductsqty = [];
   late String title;
   TextEditingController _controller = TextEditingController();
   // Stocker la date sélectionnée
  DateTime? _selectedDate;

  // Méthode pour afficher le DatePicker et récupérer la date sélectionnée
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  
  

    @override
    void initState() {
    super.initState();
    _suggestions = List<Item>.from(Provider.of<itemsProvider>(context, listen: false).globalItems.where((item)=>item.quantity>0));
    _controller.addListener(_onTextChanged);
  }
   @override
    void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

   void _onTextChanged() {
    String query = _controller.text.toLowerCase();
    setState(() {
      _displayedSuggestions = _suggestions.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }
  
  void _onSuggestionSelected(Item suggestion) {
    setState(() {
      _selectedProducts.add(suggestion);
      _selectedProductsqty.add(1);
      _controller.clear();
      _displayedSuggestions.clear();
      _suggestions.remove(suggestion);
    });
  }

  void _increaseQuantity(Item product,int n) {
    if(product.quantity>_selectedProductsqty[n]){
      setState(() {
      _selectedProductsqty[n]++;
    });
    }
    
  }

  void _decreaseQuantity(Item product,int n) {
    setState(() {
      if (_selectedProductsqty[n] > 1) {
        _selectedProductsqty[n]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: const Text('new delivery'),
    ),
    body:  Column(
        children: [ 
          const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "Title"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'this field cannot be empty';
                     return null;
                },
                onChanged: (val) {
                 setState(() => title = val);
                },
              ),
               if(_selectedProducts.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _selectedProducts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [ 
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                              _selectedProducts[index].name,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            Text(_selectedProducts[index].description??'')
                              ],
                            ) 
                          ),
                          Row(
                            children: [
                               IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: (){
                                  _suggestions.add(_selectedProducts[index]);
                                  _selectedProducts.remove(_selectedProducts[index]);
                                  _selectedProductsqty.remove(_selectedProductsqty[index]);
                                  setState(() {
                                    _selectedProducts;
                                    _selectedProductsqty;
                                    _suggestions;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => _decreaseQuantity(_selectedProducts[index],index),
                              ),
                              Text(
                                _selectedProductsqty[index].toString(),
                                style:const  TextStyle(fontSize: 16.0),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => _increaseQuantity(_selectedProducts[index],index),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if(_selectedProducts[index].quantity==_selectedProductsqty[index])
                      const Text('no more available',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10
                      ),),
                      ],
                    ),
                  );
                },
              ),
            ),
                  TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a product',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _displayedSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_displayedSuggestions[index].name),
                    onTap: () => _onSuggestionSelected(_displayedSuggestions[index]),
                  );
                },
              ),
            ),
            const  SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Choisir une date'),
            ),
           
        ],
      ),  
      bottomNavigationBar: BottomAppBar(
         child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                onPressed: () { 
                  double n =0;
                  List<int> list=[];
                  for(int i=0;i<_selectedProducts.length;i++){
                    list.add(_selectedProducts[i].id);
                    n=n+(_selectedProducts[i].price * _selectedProductsqty[i]);
                  }
                  Delivery D = Delivery(
                   title: title, 
                   status: 'Ready', 
                   itemsid:list, 
                   itemsqty: _selectedProductsqty, 
                   idclient: widget.item, 
                   dated: _selectedDate.toString(),
                   date: DateTime.now().toString(),
                   nbrItems: _selectedProducts.length, 
                   priceTot: n);
                  showMyDialog(D, context);
                 }, 
                child: const  Text('Ok'),),)
      ),  
   );
  }
}

