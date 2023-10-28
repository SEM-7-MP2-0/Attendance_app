import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({Key? key, this.onFilePick}) : super(key: key);

  final Function(File)? onFilePick;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (onFilePick != null) onFilePick!(File(pickedFile.path));
    }
  }

  Future<void> _showPicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Browse a file",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: const [
                      Icon(Icons.photo_library),
                      SizedBox(width: 10),
                      Text('Select from gallery'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Divider(),
                ),
                GestureDetector(
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text('Take a picture'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlinedButton.icon(
            onPressed: () {
              _showPicker(context);
            },
            icon: Row(
              children: const [
                Icon(Icons.cloud_upload),
                SizedBox(width: 30),
              ],
            ),
            label: Text('Browse a file to add achievement',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              side: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ))
      ],
    );
  }
}
