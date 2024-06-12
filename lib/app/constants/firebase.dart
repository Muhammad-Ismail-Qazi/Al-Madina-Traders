import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseFirestoreInstace=FirebaseFirestore.instance;

CollectionReference productCollection =firebaseFirestoreInstace.collection('products');
CollectionReference userCollection =firebaseFirestoreInstace.collection('users');