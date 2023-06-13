import 'package:developscreens/messenger/models/chatmodel.dart';
import 'package:developscreens/messenger/models/message_modal.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> _chatModels = [
    ChatModel(
      id: 1,
      name: "John Doe",
      isGroup: false,
      messages: [
        MessageModel(
          text: "Hello",
          time: DateTime.now().subtract(Duration(hours: 1)),
          isSent: true,
        ),
        MessageModel(
          text: "Hi",
          time: DateTime.now().subtract(Duration(minutes: 30)),
          isSent: false,
        ),
      ],
      icon: "assets/email.png",
    ),
    ChatModel(
      id: 2,
      name: "Jane Smith",
      isGroup: false,
      messages: [
        MessageModel(
          text: "Hey",
          time: DateTime.now().subtract(Duration(minutes: 45)),
          isSent: true,
        ),
        MessageModel(
          text: "How are you?",
          time: DateTime.now().subtract(Duration(minutes: 40)),
          isSent: true,
        ),
      ],
      icon: "assets/logo.png",
    ),
    ChatModel(
      id: 3,
      name: "Group Chat",
      isGroup: true,
      messages: [
        MessageModel(
          text: "Hi everyone!",
          time: DateTime.now().subtract(Duration(days:40,hours: 2)),
          isSent: true,
        ),
        MessageModel(
          text: "Let's plan for the weekend.",
          time: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
          isSent: true,
        ),
      ],
      icon: "assets/google.png",
    ),
  ];

  List<ChatModel> get chatModels => _chatModels;

  void updateCurrentMessage(ChatModel chatModel, String messageText) {
    final message = MessageModel(
      text: messageText,
      time: DateTime.now(),
      isSent: true,
    );
    chatModel.addMessage(message);
    notifyListeners();
  }

  void markMessageAsRead(ChatModel chatModel, MessageModel message) {
    message.markAsRead();
    notifyListeners();
  }

  void updateChatModelAfterDeletion(ChatModel updatedChatModel) {
    int index = chatModels.indexWhere((model) => model.id == updatedChatModel.id);
    if (index != -1) {
      chatModels.removeAt(index);
      chatModels.insert(0, updatedChatModel);
      notifyListeners();
    } else {
      chatModels.insert(0, updatedChatModel);
      notifyListeners();
    }
  }
}
