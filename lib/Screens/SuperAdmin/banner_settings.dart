import 'dart:io';
import 'package:caffa/utils/helpers.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BannersSettingsScreen extends StatefulWidget {
  @override
  _BannersSettingsScreenState createState() => _BannersSettingsScreenState();
}

class _BannersSettingsScreenState extends State<BannersSettingsScreen>
    with Helpers {
  final CollectionReference bannersCollection =
      FirebaseFirestore.instance.collection('banner');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'إدارة الإعلانات',
        isHomeScreen: false,

      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: bannersCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(
                    color: Colors.blue,
                    size: 80.0,
                  ),
                );
              }

              final List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  final imageUrl = doc['image'];

                  return Dismissible(
                    key: Key(doc.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("تأكيد الحذف"),
                            content:
                                Text("هل أنت متأكد أنك تريد حذف هذا الإعلان؟"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text("لا"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text("نعم"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      _deleteBanner(doc.id);
                    },
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 80.0,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBanner,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteBanner(String id) async {
    try {
      await bannersCollection.doc(id).delete();
      showSnackBar(
          context: Get.context!, message: 'تم حذف الإعلان بنجاح', error: false);
    } catch (e) {
      showSnackBar(
          context: Get.context!,
          message: 'فشل حذف الإعلان حاول مرة أخرى',
          error: true);
    }
  }

  void _addNewBanner() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      File imageFile = File(pickedFile.path);
      String fileName = basename(imageFile.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('banners/$fileName');

      try {
        UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        await _saveNewBanner(imageUrl);
      } catch (e) {
        showSnackBar(
            context: Get.context!,
            message: 'فشل رفع الصورة حاول مرة أخرى',
            error: true);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('No image selected.');
    }
  }

  Future<void> _saveNewBanner(String imageUrl) async {
    try {
      await bannersCollection.add({'image': imageUrl});
      showSnackBar(
          context: Get.context!,
          message: 'تم إضافة الإعلان بنجاح',
          error: false);
    } catch (e) {
      showSnackBar(
          context: Get.context!,
          message: 'فشل إضافة الإعلان حاول مرة أخرى',
          error: true);
    }
  }
}
