import 'dart:convert';
import 'dart:io';
import 'package:attendenceapp/Models/facecount.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<FaceCountModel?> faceCount(
  String filepath,
) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");
  if (token == null) {
    Fluttertoast.showToast(
      msg: "Error in Uploading Image",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  }
  //pass body into url
  final req = http.MultipartRequest(
    'POST',
    Uri.parse("http://104.198.196.196:5002/detect_faces"),
  );
  final file = http.MultipartFile.fromBytes(
    "image",
    await File.fromUri(Uri.parse(filepath)).readAsBytes(),
    contentType: MediaType(
      "image",
      "jpeg",
    ),
    filename: filepath,
  );
  req.files.add(file);
  req.headers.addAll({
    'Authorization': dotenv.env['API_KEY']!,
    "Content-Type": "multipart/form-data",
    "Accept": "application/json",
  });
  var res = await req.send();
  if (res.statusCode == 200) {
    final deres = const JsonDecoder().convert(await res.stream.bytesToString());
    return FaceCountModel.fromJson(deres);
  } else {
    // print(res.statusCode);
    Fluttertoast.showToast(
      msg: "Error in uploading image",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  }
}
