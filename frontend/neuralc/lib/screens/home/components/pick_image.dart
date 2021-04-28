import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuralc/components/default_button.dart';
import 'package:neuralc/constants.dart';
import 'package:http/http.dart' as http;
import 'package:neuralc/screens/home/components/get_caption_screen.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  final picker = ImagePicker();
  File _imageFile;
  bool _isUploading = false;
  bool _progressIndicator = false;
  String _generatedCaption;

  ///covert image to base64
  String _covertBase64(File image) {
    final bytes = image.readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

  ///getCaption
  Future<void> getCaption(File image) async {
    setState(() {
      _isUploading = true;
      _progressIndicator = true;
    });
    String base64Image = _covertBase64(image);
    var url = Uri.parse('http://10.0.2.2:5000/getCaption');
    var response = await http.post(url, body: {'image': base64Image});
    print('Response status: ${response.statusCode}');
    _generatedCaption = response.body;
    setState(() {
      _progressIndicator = false;
    });

  }

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop It',
          toolbarColor: kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Crop It',
      ),
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final selected = await picker.getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _imageFile = null;
      _isUploading = false;
    });
    if (index == 0) {
      _pickImage(ImageSource.camera);
    } else {
      _pickImage(ImageSource.gallery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Preview the image and crop it
      body: _isUploading
          ? GetCaption(
              caption: _generatedCaption,progress: _progressIndicator,
            )
          : buildListView(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera),
          label: "Camera",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library),
          label: "Library",
        ),
      ],
      iconSize: 28,
      selectedFontSize: 16,
      showUnselectedLabels: true,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
    );
  }

  ListView buildListView() {
    return ListView(
      children: <Widget>[
        if (_imageFile != null) ...[
          Container(
            height: 400,
            margin: EdgeInsets.all(30),
            child: Image.file(_imageFile),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.crop,
                  size: 35,
                ),
                onPressed: _cropImage,
              ),
              FlatButton(
                child: Icon(
                  Icons.refresh,
                  size: 35,
                ),
                onPressed: _clear,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: DefaultButton(
              text: 'Upload',
              press: () => getCaption(_imageFile),
            ),
          ),
          // Uploader(file: _imageFile)
        ]
      ],
    );
  }
}
