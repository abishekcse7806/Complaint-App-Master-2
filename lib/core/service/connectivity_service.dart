import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

import 'firebase_service.dart';
import 'hive_service.dart';

class ConnectivityService {
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  late StreamSubscription connStream;

  static final ConnectivityService _connectivitySingleton =
      ConnectivityService._internal();

  factory ConnectivityService() {
    return _connectivitySingleton;
  }

  ConnectivityService._internal();

  Future<bool> currentlyConnected() async {
    ConnectivityResult currentConnectivity =
        await (Connectivity().checkConnectivity());
    currentConnectivity == ConnectivityResult.none
        ? _isConnected = false
        : _isConnected = true;

    return _isConnected;
  }

  void listenConnectivity() async {
    // initial check for connection
    _isConnected = await currentlyConnected();

    connStream = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        // no connection
        _isConnected = false;
      } else {
        // have connectivity
        _isConnected = true;

        await Hive.openBox('localComplaints');

        bool filesAvailable = await HiveService().checkComplaintsAvailable();

        if (filesAvailable) {
          Map<dynamic, dynamic> oldComplaints =
              await HiveService().getComplaints();

          for (var key in oldComplaints.keys) {
            bool submitted = await FirebaseService()
                .signInAndUploadComplaint(oldComplaints[key]);


            if (submitted) {
              HiveService().deleteComplaint(key);
            }
          }
        }
      }
    });
  }

  void stopListening() {
    connStream.cancel();
  }
}
