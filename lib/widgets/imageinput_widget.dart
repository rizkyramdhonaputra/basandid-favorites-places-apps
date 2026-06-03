import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _placeImage;
  final _imagePicker = ImagePicker();

  Future<void> _pickGallery() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _placeImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _placeImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _placeImage != null
          ? Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    _takePhoto(); // Allow user to retake photo on tap
                    // Handle image tap if needed
                  },
                  child: Image.file(
                    _placeImage!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _placeImage = null;
                      });
                    },
                    icon: Icon(Icons.refresh_outlined, color: Colors.white),
                    label: Text('Reset', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: _takePhoto,
                  icon: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  label: Text(
                    'Take Photo',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _pickGallery,
                  icon: Icon(
                    Icons.photo_library,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  label: Text(
                    'Pick from Gallery',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
