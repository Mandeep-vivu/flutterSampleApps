import 'dart:io';
import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lfirstController = TextEditingController();
  bool _isEditable = false;
  File? _imageFile;
  bool isuploaded = false;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        isuploaded = true;
      });
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.uploadImage(_imageFile!);
      await authProvider.sendprofilepic();
    } else {
      setState(() {
        _imageFile = null;
        isuploaded = !isuploaded;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firstController.text =
        Provider.of<AuthProvider>(context, listen: false).username;
    _lfirstController.text =
        Provider.of<AuthProvider>(context, listen: false).lusername;
    _mailController.text =
        Provider.of<AuthProvider>(context, listen: false).emailid;
    _mobileNumberController.text =
        Provider.of<AuthProvider>(context, listen: false).mobnumber;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return CommonUI(
          children: [
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
                    child: isuploaded==true
                        ? CircleAvatar(
                            radius: MediaQuery.sizeOf(context).width*0.18,
                            backgroundImage: FileImage(_imageFile!)
                          )
                        : CircleAvatar(
                            radius: MediaQuery.sizeOf(context).width*0.18,
                            backgroundImage:
                                NetworkImage(authProvider.profilePicture)),
                  ),
                  const ResponsiveSizedBox(
                    height: 20,
                  ),
                  const HeadingWidget(
                      text: "Upload profile picture",
                      fontSize: 14,
                      color: Colors.red),
                ],
              ),
            ),

            ResponsiveSizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: TextFormField(
                          controller: _firstController,
                          enabled: _isEditable,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            label: RichText(
                              text: TextSpan(
                                text: "First Name",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: const TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 12),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      InkWell(
                        child: Container(
                          child: Icon(
                            _isEditable ? Icons.lock_open_outlined : Icons.lock,
                            color:
                                _isEditable ? Colors.green : Color(0xEDE51D23),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _isEditable = !_isEditable;
                          });
                        },
                      )
                    ],
                  ),
                  const ResponsiveSizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: TextFormField(
                          controller: _lfirstController,
                          enabled: _isEditable,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            label: RichText(
                              text: TextSpan(
                                text: "Last Name",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: const TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 12),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                      ),
                      InkWell(
                        child: Container(
                          child: Icon(
                            _isEditable ? Icons.lock_open_outlined : Icons.lock,
                            color:
                                _isEditable ? Colors.green : Color(0xEDE51D23),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _isEditable = !_isEditable;
                          });
                        },
                      )
                    ],
                  ),
                  const ResponsiveSizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: TextFormField(
                          controller: _mailController,
                          enabled: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            label: RichText(
                              text: TextSpan(
                                text: "Email",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: const TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.mail,
                        ),
                      )
                    ],
                  ),
                  const ResponsiveSizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: TextFormField(
                          controller: _mobileNumberController,
                          enabled: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            label: RichText(
                              text: TextSpan(
                                text: "Mobile",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: const TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.phone,
                        ),
                      )
                    ],
                  ),
                  const ResponsiveSizedBox(
                    height: 20,
                  ),
                  ResponsiveContainer(
                    child: ElevatedButton(
                      onPressed: () {
                        authProvider.namechange(_firstController.text.toString(),_lfirstController.text.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xEDE51D23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const HeadingWidget(
                          text: 'Done', color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
