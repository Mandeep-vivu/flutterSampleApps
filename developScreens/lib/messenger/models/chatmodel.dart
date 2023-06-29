import 'package:developscreens/messenger/models/message_modal.dart';

class ChatModel{
  final int id;
  final String personID;
  final String name;
  final String lastname;

  final List<MessageModel> messages;
  final String icon;

  ChatModel({
    required this.id,
    required this.personID,
    required this.name,
    required this.lastname,
    required this.messages,
    required this.icon,
  });

  bool get hasUnreadMessages {
    return messages.any((message) => !message.isRead);
  }

  int get unreadMessageCount {
    return messages.where((message) => !message.isRead).length;
  }

  DateTime? get latestMessageTime {
    if (messages.isNotEmpty) {
      final sortedMessages = List.from(messages);
      sortedMessages.sort((a, b) => b.time.compareTo(a.time));
      return sortedMessages[0].time;
    }
    return null;
  }

  void addMessage(MessageModel message) {
    messages.add(message);
    print("hlo");
  }

}