import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// عبارة عن مراسل
typedef UploadListener = void Function({required bool status,required TaskState taskState,String? message, Reference? reference});
class FbStorageController{

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadImage({required File file, required UploadListener uploadListener}) async{
    UploadTask uploadTask = _firebaseStorage.ref('images/${DateTime.now()}_image.png').putFile(file);
    uploadTask.snapshotEvents.listen((event) {
      if(event.state == TaskState.running){
        uploadListener(status: false,taskState: event.state);
      }else if(event.state == TaskState.success){
        uploadListener(status: true,taskState: event.state,  reference: event.ref, message: 'Image Uploaded successfully');
      }else if(event.state == TaskState.error){
        uploadListener(status: false ,taskState: event.state,message: 'Image Uploaded Failed');
      }
    });
  }

  Future<List<Reference>> getImages() async{
    ListResult listResult = await _firebaseStorage.ref('images').listAll();
    if(listResult.items.isNotEmpty){
      return listResult.items;
    }
    return [];
  }

  Future<bool> deleteImage({required String path}) async{
    return _firebaseStorage.ref(path).delete().then((value) => true).catchError((error) => false);
  }
}