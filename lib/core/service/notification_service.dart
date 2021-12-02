import 'package:e_complaint/constants/strings.dart';

class NotificationService {
  String generateNotificationID() {
    return 'crest_notification_00x';
  }

  Map<String, dynamic> generateNotification() {
    return {
      'notificationID': generateNotificationID(),
      'timeStamp': DateTime.now().millisecondsSinceEpoch,
      'notificationType': kUserComplaint,
      'senderID': ' ',
      'receiverID': ' ',
      'operationID': null,
      'adminMessage': null,
      'isRead': false,
    };
  }
}
