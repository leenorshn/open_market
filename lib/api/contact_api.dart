import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_market/model/contact.dart';

class ContactApi {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Stream<List<Contact>> getContacts() {
    return db.collection("contacts").snapshots().map(
        (event) => event.docs.map((e) => Contact.fromJson(e.data())).toList());
  }
}
