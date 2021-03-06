import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class Image_pick extends StatefulWidget {
  _Image_pickState createState() => _Image_pickState();
}

class _Image_pickState extends State<Image_pick> {
  File _storedImage;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: FlatButton.icon(
                      icon: Icon(Icons.image),
                      label: Text(" Gallery"),
                    ),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  GestureDetector(
                    child: FlatButton.icon(
                        icon: Icon(Icons.camera), label: Text(" Camera")),
                    onTap: () {
                      _takePicture(context);
                    },
                  ),
                  GestureDetector(
                    child: FlatButton.icon(
                      icon: Icon(Icons.file_upload),
                      label: Text(" upload"),
                    ),
                    onTap: () {
                      _upload();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openGallery(BuildContext context) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = imageFile;
    });
    Navigator.of(context).pop();
  }

  Future<void> _takePicture(BuildContext context) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = imageFile;
    });
    Navigator.of(context).pop();
    final appDir = await syspath.getApplicationDocumentsDirectory();
    //final fileName = path.basename(imageFile.path);
    //final savedImage = await imageFile.copy("${appDir.path}/${fileName}");
  }

  void _upload() {
    if (_storedImage == null) return;
    String base64Image = base64Encode(_storedImage.readAsBytesSync());
    String fileName = _storedImage.path.split("/").last;
    var url = 'http://167.172.59.89:5000/imageUpload';
    http.post(url, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 15, 35, 5),
          child: _storedImage != null
              ? CircleAvatar(
                  maxRadius: 47, backgroundImage: FileImage(_storedImage))
              : CircleAvatar(
                  maxRadius: 47,
                  backgroundImage: NetworkImage(
                    'http://167.172.59.89:5000/imageUpload',
                  ),
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text("Take Picture"),
            textColor: Colors.blueGrey,
            onPressed: () {
              _showChoiceDialog(context);
            },
          ),
        ),
      ],
    );
  }
}
