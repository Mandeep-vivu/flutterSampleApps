import 'dart:io';
import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:developscreens/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
    if (pickedImage != null) {
    setState(() {
        _imageFile = File(pickedImage.path);
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.uploadImage(_imageFile!);

      } else {
      setState(() {
        _imageFile = null;
      });
      }

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
                onPressed: () async {

                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  await authProvider.sendprofilepic();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                    return const LoginPage();
                  }), (r){
                    return false;
                  });
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
