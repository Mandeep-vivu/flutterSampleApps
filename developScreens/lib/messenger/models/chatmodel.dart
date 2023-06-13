import 'package:developscreens/messenger/models/message_modal.dart';
import 'package:flutter/foundation.dart';

class ChatModel{
  final int id;
  final String name;
  final bool isGroup;
  final List<MessageModel> messages;
  final String icon;

  ChatModel({
    required this.id,
    required this.name,
    required this.isGroup,
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

  }
  bool isDifferentMonth(DateTime dateTime) {
    if (messages.isNotEmpty) {
      final latestMessageMonth = latestMessageTime!.month;
      final latestMessageYear = latestMessageTime!.year;
      final newMessageMonth = dateTime.month;
      final newMessageYear = dateTime.year;

      return latestMessageMonth != newMessageMonth ||
          latestMessageYear != newMessageYear;
    }
    return true;
  }
  void deleteMessages(List<MessageModel> messagesToDelete) {
    messages.removeWhere((message) => messagesToDelete.contains(message));
  }

}