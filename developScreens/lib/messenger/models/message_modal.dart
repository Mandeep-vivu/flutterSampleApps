class MessageModel {
  final String text;
  final DateTime time;
  final bool isSent;
  bool isRead;
  bool isSelected;

  MessageModel({
    required this.text,
    required this.time,
    required this.isSent,
    this.isRead = false,
    this.isSelected = false,
  });

  void markAsRead() {
    isRead = true;
  }
}