import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ad_drive/model/imgbb_response_model.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

class PhotoUploader{

  void uploadImageFile(List<File> _images) async {
    Dio dio = Dio();
    ImgbbResponseModel imgbbResponse;

    for (var element in _images) {
      ByteData bytes = await rootBundle.load(element.path);
      var buffer = bytes.buffer;
      var m = base64.encode(Uint8List.view(buffer));

      FormData formData = FormData.fromMap({
        "key" : '75cae51ba7d621e2052cce37e304d9ed',
        "image" :m
      });

      Response response = await dio.post(
        "https://api.imgbb.com/1/upload",
        data: formData,
      );
      print(response.data);
      if(response.statusCode != 400){
        imgbbResponse = ImgbbResponseModel.fromJson(response.data);
        print(imgbbResponse.data.displayUrl);
        print(imgbbResponse.data.deleteUrl);
      } else{
        print("error");
      }
    }
  }
}