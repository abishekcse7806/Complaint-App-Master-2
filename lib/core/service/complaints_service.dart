import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_complaint/core/model/error_codes.dart';

class ComplaintsService {
  static final ComplaintsService _singleton = ComplaintsService._internal();

  factory ComplaintsService() {
    return _singleton;
  }

  // singleton class
  ComplaintsService._internal() {
    _firestore = FirebaseFirestore.instance;
  }

  late FirebaseFirestore _firestore;

  List<ErrorCode> errors = [];

  /// Method to get the error codes from db
  Future<List<ErrorCode>> getErrorCodes() async {
    // will return back the data if error list is not empty
    if (errors.isNotEmpty) {
      return errors;
    }
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('app_data').doc('error_codes').get();
    if (snapshot.exists) {
      errors = ErrorResponse.fromJson(snapshot.data()!).data;
      return errors;
    }
    return [];
  }
}
