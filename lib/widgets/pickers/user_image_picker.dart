import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  void Function(File image) pickImageFn;

  UserImagePicker(this.pickImageFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(_pickedFile.path);
    });
    widget.pickImageFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 40,
            backgroundImage: _image != null ? FileImage(_image) : null,
          ),
          FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            label: Text('Add Image'),
            icon: Icon(Icons.image),
            onPressed: _pickImage,
          ),
        ],
      ),
    );
  }
}
