import 'package:developscreens/commonUI.dart';
import 'package:developscreens/logoimage.dart';
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

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonUI(
      children: [
            const LogoImage(),
            const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'My name is mandeep, hello login',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            // Country Code Field
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,

              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: DropdownButtonFormField<String>(
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
                    child: Text('+1'),
                  ),
                  DropdownMenuItem(
                    value: '+44',
                    child: Text('+44'),
                  ),
                ],
                decoration:  const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Country/Region",
                  hintText: 'Select Country Code',
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
                const BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              child: TextFormField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Mobile number",
                  prefixText: '$_selectedCountryCode ',
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
                  _MobileNumberFormatter(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpVerify()),
                );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xEDE51D23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const ListTile(
                title: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
    );
  }
}
class _MobileNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final selection = newValue.selection;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = selection.baseOffset;

    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) {
        newText.write(' ');
        if (i < selection.baseOffset) {
          selectionIndex++;
        }
      }
      newText.write(text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection(
        baseOffset: selectionIndex,
        extentOffset: selectionIndex,
      ),
    );
  }
}
