import 'dart:io';
import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/screens/signup_mail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FinishSup extends StatefulWidget {
  const FinishSup({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / 812; // 812 is the reference screen height
    final buttonHeight = 50* scaleFactor;
    return WillPopScope(
      onWillPop: () async => false,
      child: CommonUI(
        children: [
          const LogoImage(),
          const ResponsiveSizedBox(
            height: 30,
          ),
          const HeadingWidget(text: "Finish signing up"),
          const ResponsiveSizedBox(
            height: 54,
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
                    radius: buttonHeight,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : null,
                  ),
                ),
                const ResponsiveSizedBox(height: 20,),
                const HeadingWidget(
                  text:"Upload profile picture",
                 fontSize: 14, color: Colors.red
                ),
              ],
            ),
          ),
          const ResponsiveSizedBox(height: 30,),
          ResponsiveContainer(
            child: ElevatedButton(
                onPressed: () {
                  // Handle continue with Google button tap
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>  const MailLogin()),
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
                child: const HeadingWidget(text:"Sign Up",color: Colors.white,fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
