class MessageModel {
  final String text;
  final DateTime time;
  final bool isSent;
  final String mID;
  bool isRead;
  bool isSelected;

  MessageModel({
    required this.text,
    required this.time,
    required this.isSent,
    required this.mID,
    this.isRead = false,
    this.isSelected = false,
  });

  void markAsRead() {
    isRead = true;
  }
}