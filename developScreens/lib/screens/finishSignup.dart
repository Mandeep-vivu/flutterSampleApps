import 'dart:io';
import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commonfonts.dart';
import 'package:developscreens/logoimage.dart';
import 'package:developscreens/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FinishSup extends StatefulWidget {
  const FinishSup({Key? key}) : super(key: key);

  @override
  _FinishSupState createState() => _FinishSupState();
}

class _FinishSupState extends State<FinishSup> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        _imageFile = null; // Reset the image file if no image is selected.
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.06;
    return CommonUI(
      children: [
        LogoImage(),
        const AutoFontSizeWidget(
          text:'Finish signing up',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: _pickImage,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              const AutoFontSizeWidget(
                text:"Upload profile picture",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: buttonHeight,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                // Handle continue with Google button tap
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                    0xFFF13131),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))
                ,
              ),
              child: AutoFontSizeWidget(text:"Sign Up",style: TextStyle(color: Colors.white,fontSize: 18),)
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
