import 'package:e_complaint/constants/constants.dart';
import 'package:e_complaint/constants/strings.dart';
import 'package:e_complaint/constants/themes.dart';
import 'package:e_complaint/core/service/connectivity_service.dart';
import 'package:e_complaint/core/service/firebase_service.dart';
import 'package:e_complaint/core/service/hive_service.dart';
import 'package:flutter/material.dart';
import 'custom_widgets/custom_button.dart';

class SubmitPage extends StatefulWidget {
  const SubmitPage({Key? key, required this.currentComplaintData})
      : super(key: key);

  final Map<String, String> currentComplaintData;

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  ComplaintStatus _currentStatus = ComplaintStatus.notSaved;
  bool completed = false;

  void doEverything() async {
    bool isConnected = ConnectivityService().isConnected;

    if (isConnected) {
      bool submitted = await FirebaseService()
          .signInAndUploadComplaint(widget.currentComplaintData);

      if (submitted) {
        setState(() {
          _currentStatus = ComplaintStatus.uploadedAndNotified;
          completed = true;
        });
      }
    } else {
      HiveService().saveComplaintsLocally(widget.currentComplaintData);
      setState(() {
        _currentStatus = ComplaintStatus.savedOffline;
        completed = true;
      });
    }
  }

  @override
  void initState() {
    doEverything();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, completed);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: const Text(kTextSubmitComplaint),
          centerTitle: true,
        ),
        body: Container(
          color: kAccentColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _currentStatus == ComplaintStatus.uploadedAndNotified ||
                      _currentStatus == ComplaintStatus.savedOffline
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: Icon(
                        Icons.check_circle,
                        color: _currentStatus ==
                                ComplaintStatus.uploadedAndNotified
                            ? kMainColor
                            : kAmberColor,
                        size: 80,
                      ))
                  : const SizedBox(
                      width: 50,
                      child: CircularProgressIndicator(
                        color: kMainColor,
                        strokeWidth: 8.0,
                      ),
                    ),
              Text(
                _currentStatus == ComplaintStatus.uploadedAndNotified
                    ? kTextComplaintSubmitted
                    : _currentStatus == ComplaintStatus.savedOffline
                        ? kTextNoInternet
                        : kTextSubmitting,
                style: kContactStyle,
                textAlign: kCenterAlign,
              ),
              CustomButton(
                buttonLabel: kTextGoBack,
                enabled: _currentStatus != ComplaintStatus.notSaved,
                onPress: _currentStatus != ComplaintStatus.notSaved
                    ? () {
                        Navigator.pop(context, completed);
                      }
                    : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
