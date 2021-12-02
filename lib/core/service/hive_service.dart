import 'package:hive/hive.dart';

class HiveService {
  Future<void> saveComplaintsLocally(Map<String, String> currentData) async {
    Hive.box('localComplaints').add(currentData);
  }

  Future<bool> checkComplaintsAvailable() async {
    return Hive.box('localComplaints').isNotEmpty;
  }

  Future<Map<dynamic, dynamic>> getComplaints() async {
    Map<dynamic, dynamic> complaints = Hive.box('localComplaints').toMap();

    return complaints;
  }

  void deleteComplaint(key) async {
    Hive.box('localComplaints').delete(key);
  }
}
