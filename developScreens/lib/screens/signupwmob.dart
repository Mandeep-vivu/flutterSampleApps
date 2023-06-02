import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commons/ContainerE.dart';
import 'package:developscreens/commons/heading.dart';
import 'package:developscreens/logoimage.dart';
import 'package:developscreens/responSized.dart';
import 'package:developscreens/screens/otpphone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MobileLog extends StatefulWidget {
  const MobileLog({Key? key}) : super(key: key);

  @override
  State<MobileLog> createState() => _MobileLogState();
}

class _MobileLogState extends State<MobileLog> {
  String _selectedCountryCode = '+91';
  final TextEditingController _mobileNumberController = TextEditingController();
  late String mobileNumber;

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonUI(
      children: [
        LogoImage(),
        const ResponsiveSizedBox(
          height: 30,
        ),
        const HeadingWidget(
          text: 'Sign up',
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
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3.0), // Top-left corner radius
            topRight: Radius.circular(3.0), // Top-right corner radius
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey), // Top side border
                left: BorderSide(color: Colors.grey), // Left side border
                right: BorderSide(color: Colors.grey), // Right side border
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveSizedBox(
                  height: 9,
                ),
                HeadingWidget(
                  text: "Country/Region",
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),

                DropdownButtonFormField<String>(
                  value: _selectedCountryCode,
                  onChanged: (value) {
                    setState(() {
                      _selectedCountryCode = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: '+91',
                      child: Text('India(+91)'),
                    ),
                    DropdownMenuItem(
                      value: '+1',
                      child: Text('America +1'),
                    ),
                    DropdownMenuItem(
                      value: '+44',
                      child: Text('England +44'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Select Country Code',
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
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
            children: [
              ResponsiveSizedBox(
                height: 9,
              ),
              HeadingWidget(
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
                      alignment:Alignment.bottomCenter,
                      child: Text(
                        _selectedCountryCode,
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _mobileNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(2, 1, 0, 13.3) // Add padding to align the text input with the container
                        ),
                        style: TextStyle(
                          fontSize: 16, // Set the desired font size
                          fontWeight: FontWeight.w600, // Set the desired font weight
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,)
            ],
          ),
        )
,
        ResponsiveSizedBox(height: 20),
        ResponsiveContainer(
          child: ElevatedButton(
            onPressed: () {
              final String mobile = _mobileNumberController.text;
              final RegExp mobileRegex = RegExp(r'^\d{10}$');
              print(mobile);

              if (mobileRegex.hasMatch(mobile)) {
                setState(() {
                  mobileNumber = mobile;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerify(
                      countryCode: _selectedCountryCode,
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
                      content: const Text('Please enter a valid 10-digit mobile number starting with 1 to 9.'),
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
            child: HeadingWidget(
                text: 'Continue', color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
