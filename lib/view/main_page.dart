import 'package:e_complaint/constants/constants.dart';
import 'package:e_complaint/constants/strings.dart';
import 'package:e_complaint/core/model/user_complaint.dart';
import 'package:e_complaint/view/custom_widgets/custom_form_field.dart';
import 'package:e_complaint/view/submit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_widgets/caption_text.dart';
import 'custom_widgets/contact_unit.dart';
import 'custom_widgets/custom_button.dart';
import 'custom_widgets/custom_divider.dart';
import 'custom_widgets/dropdown.dart';
import 'custom_widgets/header_text.dart';
import 'custom_widgets/qr_section.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _selectedError = kTextDropdownDefault;
  String _qrCode = '';
  String _machineID = '';

  String _userName = '';
  String _phoneNumber = '';
  String _comments = '';

  late Map<String, String> _generatedComplaint;

  final _mainPageFormKey = GlobalKey<FormState>();

  final _machineIDControl = TextEditingController();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _mainPageFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const HeaderText(text: kTextComplaintDetails),
            const SizedBox(
              height: 30,
            ),
            const CaptionText(text: kTextQRCode),
            QRSection(
              onPress: (receivedString, machineID) {
                _qrCode = receivedString;
                _machineID = machineID;
                _machineIDControl.text = _machineID;
              },
              // qrCode: _qrCode,
            ),
            const CustomDivider(),
            const CaptionText(text: kTextMachineID),
            CustomFormField(
              hintText: kTextScanQR,
              readOnly: true,
              controller: _machineIDControl,
              validation: ValidationType.name,
            ),
            const CustomDivider(),
            const CaptionText(text: kTextErrorCode),
            CustomDropdown(
              onChange: (value) {
                setState(() {
                  _selectedError = value;
                });
                FocusScope.of(context).requestFocus(_nameFocus);
              },
              selectedError: _selectedError,
            ),
            const CustomDivider(),
            const CaptionText(text: kTextName),
            CustomFormField(
              hintText: kTextUserName,
              myFocus: _nameFocus,
              nextFocus: _phoneFocus,
              inputType: TextInputType.name,
              inputAction: TextInputAction.next,
              validation: ValidationType.name,
              maxLength: 20,
              onSave: (text) {
                _userName = text;
              },
            ),
            const CustomDivider(),
            const CaptionText(text: kTextPhone),
            CustomFormField(
              hintText: kTextUserPhoneNumber,
              myFocus: _phoneFocus,
              inputType: TextInputType.phone,
              inputAction: TextInputAction.done,
              validation: ValidationType.phoneNumber,
              maxLength: 14,
              onSave: (text) {
                _phoneNumber = text;
              },
            ),
            const CustomDivider(),
            const CaptionText(text: kTextComments),
            CustomFormField(
              hintText: kTextOptionalComments,
              inputAction: TextInputAction.done,
              maxLines: 3,
              onSave: (text) {
                _comments = text;
              },
            ),
            const CustomDivider(),
            CustomButton(
              enabled: true,
              buttonLabel: kTextSubmitComplaint,
              onPress: () async {
                if (!_mainPageFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(kTextCheckFormAgain),
                    ),
                  );
                } else {
                  _mainPageFormKey.currentState!.save();

                  _generatedComplaint = UserComplaint().generateComplaint(
                      qrCode: _qrCode,
                      machineID: _machineID,
                      errorCode: _selectedError,
                      userName: _userName,
                      userPhone: _phoneNumber,
                      comments: _comments);

                  bool isSubmitted = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubmitPage(
                        currentComplaintData: _generatedComplaint,
                      ),
                    ),
                  );

                  if (isSubmitted) {
                    _selectedError = kTextDropdownDefault;
                    _mainPageFormKey.currentState!.reset();
                    _machineIDControl.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(kTextSomethingWrong),
                      ),
                    );
                  }
                }
              },
            ),
            const CustomDivider(),
            const ContactUnit(
              heading: kTextCallUs,
              content: '+971 566773517',
              url: 'tel:+971566773517',
            ),
            ContactUnit(
              heading: 'Email Us :',
              content: 'info@gogreendxb.com',
              url:
                  'mailto:info@gogreendxb.com?subject=Machine : $_machineID\nComplaint : $_selectedError\nCode : $_qrCode',
            ),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }
}
