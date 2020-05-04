import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class API
{
  static const String APIEndpoint = "vlearn-lanka.web.app";
  
  // Storage
  static Future<List<FileData>> getFiles(String org, String classId, String path) async
  {
    var queryParameters = {
      'org': org,
      'class': classId,
      'path': path
    };

    var uri = Uri.https(APIEndpoint, '/api/shared', queryParameters);
    Response response = await http.get(uri);
    
    var res = json.decode(response.body);

    List<FileData> files = [];
    List<FileData> folders = [];

    (res["files"] as List).forEach((f)
    {
      var file = FileData.fromJson(f);

      if (file.filename.contains("/"))
      {
        file.folder = true;
        folders.add(file);
      }
      else
      {
        file.folder = false;
        files.add(file);
      }
    });

    return folders + files;
  }
}

class FileData
{
  String filename;
  String fullPath;
  bool folder = false;
  dynamic meta;

  FileData({this.filename, this.fullPath, this.meta, this.folder});

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      filename: json['filename'],
      fullPath: json['fullPath'],
      meta: json['meta'],
    );
  }
}