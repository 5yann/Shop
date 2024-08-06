


// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class User1{
  final String FirstName;
  final String LastName;
  final String DateofBirth;
  final String EnterpriseName;
  final String Description;
  final String Adress;
  final String Email;
  final String UId;

  User1({required this.FirstName,
  required this.LastName,
  required this.DateofBirth,
  required this.EnterpriseName,
  required this.Description,
  required this.Adress,
  required this.Email,
  required this.UId,
 });


  Map<String, dynamic> toMap() {
    return {
     'FirstName':FirstName,
     'LastName':LastName,
     'DateofBirth':DateofBirth,
     'EnterpriseName':EnterpriseName,
     'Description':Description,
     'Adress':Adress,
     'Email':Email,
     'UId':UId,
  
    };
  }

  factory User1.fromDocument(DocumentSnapshot doc) {
    return User1(
      FirstName:doc['FirstName'],
      LastName: doc['LastName'],
      DateofBirth: doc['DateofBirth'],
      EnterpriseName: doc['EnterpriseName'],
      Description: doc['Description'],
      Adress: doc['Adress'],
      Email: doc['Email'],
      UId: doc.id,
    );
  }

  String get UserName{
    return FirstName;
  }
  String get UserlastName{
    return LastName;
  }
  String get birthday{
    return DateofBirth;
  }
  String get shopName{
    return EnterpriseName;
  }
  String get Shopdesc{
    return Description;
  }
  String get adress{
    return Adress;
  }
  String get email{
    return Email;
  }
  String get User_UId{
    return UId;
  }

  /*int  addCategorY(Category C){
     Categories.add(C);
     return Categories.length;
  }

  int  addProvider(Provider P){
     Providers.add(P);
     return Providers.length;
  }

  int  addDelivery(Delivery D){
     Deliveries.add(D);
     return Deliveries.length;
  }

   int  addPurchase(Purchase P){
     Purchases.add(P);
     return Purchases.length;
  }

   int  addBill(Bill B){
     Bills.add(B);
     return Bills.length;
  }
  
  List<Category> getCategories(){
    return Categories;
  }*/

}




void AddUser(FirebaseFirestore db ,User1 U){
  // Create a new user with a first and last name
final user = <String, dynamic>{
  "FirstName":U.FirstName,
  "LastName":U.LastName,
  "DateofBirth":U.DateofBirth,
  "EnterpriseName":U.EnterpriseName,
  "Description":U.Description,
  "Adress":U.Adress,
  "Email":U.Email,
  "UId":U.UId,

};

// Add a new document with a generated ID
db.collection("users").add(user).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));
}