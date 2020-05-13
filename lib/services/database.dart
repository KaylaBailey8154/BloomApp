import 'package:bloomflutterapp/models/supplier.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference supplierCollection = Firestore.instance.collection('suppliers');

  Future updateUserData(String fullName, String companyName, String phoneNumber) async{
    return await supplierCollection.document(uid).setData({
      'fullName': fullName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
    });
  }
  //brew list from snapshot
  List<Supplier> _supplierListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Supplier(
          fullName: doc.data['fullName'] ?? '',
          companyName: doc.data['companyName']?? '',
          phoneNumber:  doc.data['phoneNumber'] ?? ''
      );
    }).toList();

  }

  //userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){

    return UserData(
      uid: uid,
      fullName: snapshot.data['fullName'],
      companyName: snapshot.data['companyName'],
      phoneNumber: snapshot.data['phoneNumber'],
    );

  }

  //get suppliers stream
  Stream<List<Supplier>> get suppliers{
    return supplierCollection.snapshots()
        .map(_supplierListFromSnapshot);
  }

  //get user doc stream

  Stream<UserData> get userData{
    return supplierCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }


}