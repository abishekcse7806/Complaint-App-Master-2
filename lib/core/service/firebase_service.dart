import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final _fireDB = FirebaseFirestore.instance;

  Future<bool> signInAndUploadComplaint(
      Map<String, String> currentComplaintData) async {
    try {
      await uploadComplaint(currentComplaintData);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> uploadComplaint(currentComplaintData) async {
    try {
      await _fireDB.collection('app_data').doc('rawComplaints').update({
        "active": FieldValue.arrayUnion([currentComplaintData])
      });
    } catch (e) {
      rethrow;
    }
  }
}
