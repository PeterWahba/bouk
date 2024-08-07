import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/helpers.dart';

class FbFireStoreController with Helpers {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> read() async* {
    yield* _firestore.collection('categories').snapshots();
  }
}
