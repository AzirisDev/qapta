import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/imgbb_response_model.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:dio/dio.dart';

class PhotoUploader {
  UserScopeData userScopeData;

  PhotoUploader({required this.userScopeData});

  Future<void> uploadImageFile(List<File> _images) async {
    Dio dio = Dio();
    ImgbbResponseModel imgbbResponse;
    List<String> documentsUrl = [];

    for (var element in _images) {
      ByteData bytes = ByteData.view(element.readAsBytesSync().buffer);
      var buffer = bytes.buffer;
      var m = base64.encode(Uint8List.view(buffer));

      FormData formData = FormData.fromMap({"key": '75cae51ba7d621e2052cce37e304d9ed', "image": m});

      Response response = await dio.post(
        "https://api.imgbb.com/1/upload",
        data: formData,
      );
      if (response.statusCode != 400) {
        imgbbResponse = ImgbbResponseModel.fromJson(response.data);
        documentsUrl.add(imgbbResponse.data.displayUrl);
      } else {
        //ignore
      }
    }
    FireStoreInstance().updateUserData(uid: userScopeData.userData.uid, documents: documentsUrl);
  }
}
