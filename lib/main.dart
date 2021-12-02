import 'package:e_complaint/core/service/connectivity_service.dart';
import 'package:e_complaint/view/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'constants/strings.dart';
import 'constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  runApp(const EComplaint());
}

class EComplaint extends StatefulWidget {
  const EComplaint({Key? key}) : super(key: key);

  @override
  _EComplaintState createState() => _EComplaintState();
}

class _EComplaintState extends State<EComplaint> {
  @override
  void initState() {
    super.initState();

    // listen for network changes
    ConnectivityService().listenConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(kAppTitle),
          elevation: 0,
          backgroundColor: kMainColor,
        ),
        body: const MainPage(),
      ),
    );
  }
}
