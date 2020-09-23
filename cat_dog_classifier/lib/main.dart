import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'package:cat_dog_classifier/body.dart';
import './classifier/classifier.dart';
import './classifier/classifier_float.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  File _image;
  bool _showButton = false;

  Classifier _classifier;
  Category category;

  var logger = Logger();

  //List _output;
  @override
  void initState() {
    super.initState();
    _classifier = ClassifierFloat();
  }

  void _predict(File image) async {
    img.Image imageInput = img.decodeImage(image.readAsBytesSync());
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;
      _showButton = false;
    });
  }

  chooseImage() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      _image == null ? _showButton = false : _showButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Machine-Learning with Flutter'), centerTitle: true),
      body: _isLoading
          ? Container(
              child: CircularProgressIndicator(), alignment: Alignment.center)
          : Body(_image, _showButton, _predict, category),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0)),
      floatingActionButton: FloatingActionButton(
        onPressed: chooseImage,
        child: Icon(Icons.image),
      ),
    );
  }
}
