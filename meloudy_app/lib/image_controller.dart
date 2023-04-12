import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:meloudy_app/providers/auth.dart';
import 'package:provider/provider.dart';

import 'ips.dart';
class ImageController{

  
  Future<bool> upload(file, String token) async {
    bool success = false;
    http.StreamedResponse response = await updateProfile(file, token);
    return success;
  }

  Future<http.StreamedResponse> updateProfile(PickedFile data, String token) async {
    http.StreamedResponse response;
    if(data!=null) {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(
          'http://${IP.ip}:5000/api/lesson/upload-image?auth=${token}'));
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path
              .split('/')
              .last));

      response = await request.send();
      return response;
    }
    return response;
  }



}