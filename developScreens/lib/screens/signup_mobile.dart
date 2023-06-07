import 'dart:io';

import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';

import 'package:developscreens/screens/otp_on_phn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
class MobileLog extends StatefulWidget {
  const MobileLog({Key? key}) : super(key: key);

  @override
  State<MobileLog> createState() => _MobileLogState();
}

class _MobileLogState extends State<MobileLog> {
  final TextEditingController _mobileNumberController = TextEditingController();
  late String mobileNumber;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isNumberInputActive = false;
  String dialCode = '+91';
  late int phLength;
 late TextInputFormatter mobileNumberInputFormatter;
 late String _countryname;
  @override
  void initState() {
    super.initState();
    // Initialize default values for India
    _countryname="India";
    dialCode = '91';
    phLength = 10;
    mobileNumberInputFormatter = LengthLimitingTextInputFormatter(phLength);
  }
  void _clearMobileNumberField() {
    _mobileNumberController.text = '';
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget doneButton = Container();
    if (Platform.isIOS && isNumberInputActive) {
      doneButton = IconButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
        },
        icon: const Icon(Icons.done),
      );
    }
    return CommonUI(
      children: [
        const LogoImage(),
        const ResponsiveSizedBox(
          height: 30,
        ),
        const HeadingWidget(
          text: 'Sign up',
        ),
        const ResponsiveSizedBox(
          height: 7,
        ),
        const HeadingWidget(
          text: 'My name is mandeep, hello login',
          fontWeight: FontWeight.normal,
          color: Color(0xff626064),
          fontSize: 14,
        ),

        const ResponsiveSizedBox(
          height: 20,
        ),
        // Country Code Field
        // Country Code Field
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3.0), // Top-left corner radius
            topRight: Radius.circular(3.0), // Top-right corner radius
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xffBEBEBE)), // Top side border
                left: BorderSide(color: Color(0xffBEBEBE)), // Left side border
                right: BorderSide(color: Color(0xffBEBEBE)), // Right side border
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ResponsiveSizedBox(
                  height: 9,
                ),
                const HeadingWidget(
                  text: "Country/Region",
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),

                 GestureDetector(
                   onTap: () {
                     showCountryPicker(
                       context: context,
                       showPhoneCode: true,
                       onSelect: (Country country) {
                         setState(() {
                           _countryname=country.name;
                           _clearMobileNumberField(); // Clear the mobile number field when a new country is selected
                           dialCode = country.phoneCode;
                           phLength=country.example.length;
                           mobileNumberInputFormatter = LengthLimitingTextInputFormatter(phLength);
                         });

                       },

                     );
                   },
                   child: SizedBox(
                     height: 44,
                     child: Row(

                       children: [
                         Expanded(
                           child: Text(
                             "$_countryname (+$dialCode)",
                             style: const TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w600,
                               color: Color(0xff2A2A2A),
                             ),
                           ),
                         ),
                          
                          const Align(
                              
                              child: Icon(Icons.arrow_drop_down_sharp)),
                              /*child: Row(
                                children: [
                                  Text(
                                    _selectedCountryCode,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff2A2A2A),
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Add spacing between the code and country name if needed
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),*/

                       ],
                     ),
                   ),
                 ),

              ],
            ),
          ),
        ),


        // Mobile Number Field
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(3)),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const ResponsiveSizedBox(
                height: 9,
              ),
              const HeadingWidget(
                text: "Mobile Number",
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
              SizedBox(
                height: 32,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "+$dialCode",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _mobileNumberController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            mobileNumberInputFormatter
                          ],
                          onChanged: (value) {
                            setState(() {
                              isNumberInputActive = value.isNotEmpty;
                            });
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(3, 1, 0,
                                  12.6)
                              ),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.w700,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
        const ResponsiveSizedBox(height: 20),
        ResponsiveContainer(
          child: ElevatedButton(
            onPressed: () {
              final String mobile1 = _mobileNumberController.text;
              final String mobile = '+$dialCode $mobile1';
              final RegExp mobileRegex = RegExp(r'\+(?:[0-9] ?){6,14}[0-9]$');

              if (mobileRegex.hasMatch(mobile)) {
                setState(() {
                  mobileNumber = mobile;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerify(

                      mobileNumber: mobileNumber,
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Invalid Mobile Number'),
                      content: const Text(
                          'enter correct mobile number'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xEDE51D23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const HeadingWidget(
                text: 'Continue', color: Colors.white, fontSize: 16),
          ),
        ),
        doneButton,
      ],
    );
  }
}
