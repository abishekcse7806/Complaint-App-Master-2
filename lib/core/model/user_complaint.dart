class UserComplaint {
  Map<String, String> generateComplaint(
      {required String qrCode,
      required String machineID,
      required String errorCode,
      required String userName,
      required String userPhone,
      required String comments}) {
    return {
      'time_stamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'qr_code': qrCode,
      'machine_id': machineID,
      'error_code': errorCode,
      'user_name': userName,
      'user_phone': userPhone,
      'comments': comments,
    };
  }
}
