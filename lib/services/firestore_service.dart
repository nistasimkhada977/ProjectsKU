import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/organizationmodel.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveData({@required String path,@required Map<String,dynamic> data}) {
    final reference = _db.document(path);
    print('$path: $data');
    return reference.setData(data);
  }
  
  Stream<QuerySnapshot> getDatas({@required String path}){
    return _db.collection(path).snapshots().map((snapshot) => snapshot);
  }

  Future<void> updateData({@required String path, @required Map<String, dynamic> data}){
    final reference = _db.document(path);
    return reference.updateData(data);
  }

  Stream<QuerySnapshot> getUserTransaction({@required String path, String username}){
    return _db.collection(path).where('donor', isEqualTo: username).snapshots().map((snapshot) => snapshot);
  }

   Stream<List<OrganizationDetail>> getdocsData({@required String path}) {
    return _db.collection(path).snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => OrganizationDetail.fromFirestore(document.data))
        .toList());
  }

  Future<Map<String,dynamic>> getData({@required String path}) {
    return _db.document(path).get().then((doc) => doc.data);
  }

  Future<void> deleteData({@required String path}) {
    final reference = _db.document(path);
    print('delete: $path');
    return reference.delete();
  }
}
