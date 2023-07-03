import 'package:developscreens/messenger/models/message_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'messenger/models/chatmodel.dart';

class SocketService with ChangeNotifier {
  static IO.Socket? socket;
  Function? screenFunction;
  String? userId;
  String? ReuserId;
  String toeken = "";
  String connection_id = '';
  List<dynamic> data1 = [];
  List<ChatModel> filteredChatModels = [];
  void updateChatModel(ChatModel updatedChatModel) {
    int index = filteredChatModels
        .indexWhere((model) => model.id == updatedChatModel.id);
    if (index != -1) {
      filteredChatModels.removeAt(index);
      filteredChatModels.insert(0, updatedChatModel);
    } else {
      filteredChatModels.insert(0, updatedChatModel);
    }
    notifyListeners(); // Notify listeners of the update
  }

  late ChatModel chatModelss;
  void connect(String token) async {
    if (socket?.json.io.options.containsKey('extraHeaders') == true &&
        socket?.json.io.options['extraHeaders'].containsKey('token') == true &&
        socket?.json.io.options['extraHeaders']['token'] != token) {
      print("OLD Token:${socket?.json.io.options['extraHeaders']['token']}");
      socket?.json.io.options['extraHeaders']['token'] = token;
      print("NEW Token:${socket?.json.io.options['extraHeaders']['token']}");
    }
    socket = IO.io(
        'http://139.59.47.49:4001',
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
                {'token': token}) // optional
            .build());

    socket!.onError((data) => print("ERROR:$data"));
    socket!.connect();
    socket!.onConnect((d) {
      print(socket!.json.io.options);
      print("con---=-${socket!.connected}");
      listenCreateConnection();
      listenSendMessage();
      listensocketJoin();
      // listenCompleteRide();*/
      listenIncomingmessage();
      notifyListeners();
    });
    socket!.onAny((event, data) => print("any---=-$event"));

    socket!.onDisconnect((data) => {
          print("dis---=-$data"),
          notifyListeners(),
        });
    socket!.onReconnect((data) => print("RECONNECT:$data"));
    socket!.onReconnectAttempt((data) => print("RECONNECT-Attempt:$data"));
    socket!.onReconnectError((data) => print("RECONNECT-Error:$data"));

    socket!.on('fromServer', (_) => print(_));
  }

  void createConnection(String senderId, String receiverId, String token) {
    if (socket != null) {
      final data = {
        'sent_by': senderId,
        'sent_to': receiverId,
        'token': token,
      };
      userId = senderId;
      ReuserId = receiverId;
      toeken = token;
      print(socket!.connected);
      socket!.emit('create_connection', data);
    }
  }

  listenCreateConnection() {
    socket!.on("create_connection", (data) async {
      connection_id = data['connection_id'];
      print("fddggfg------$connection_id");
    });
    notifyListeners();
  }
listenIncomingmessage(){
    socket!.on('chat_users', (data) {
      print(data);
    });
}
  listenSendMessage() {
    socket!.on('recived_message', (data) {
      print("received---->$data");
      saelectContact();
      final String senderId = data['sent_by'];
      final String messageId = data['_id'];
      final String messageText = data['message'];

      final bool isSent = (senderId == userId);
      print("userid--mine->$userId");
      print("senderid------>$senderId");

      final message = MessageModel(
        text: messageText,
        time: DateTime.now(),
        isSent: isSent,
        isRead: false,
        mID: messageId,
      );

      chatModelss.addMessage(message);
      screenFunction?.call();
      updateChatModel(chatModelss);
      notifyListeners();
    });
  }

  Future<void> saelectContact() async {
    final response = await http.get(
      Uri.parse('http://139.59.47.49:4001/user'),
      headers: {
        'accept': '*/*',
        'token': toeken,
      },
    );
    if (response.statusCode == 200) {
      data1 = json.decode(response.body);
      print(data1[1]);
    } else {
      // Handle API error
      print('API error: ${response.statusCode}');
    }
  }

  void markMessageAsRead(ChatModel chatModel, MessageModel message) {
    message.markAsRead();
    notifyListeners();
  }

  listensocketJoin() {
    socket!.on('join_socket', (data1) {
      print("join----->$data1");
    });
  }

  Future<void> joinSocket() async {
    if (socket != null) {
      var data1 = {
        'connection_id': connection_id,
      };
      socket!.emit('join_socket', data1);
    }
  }

  void sendMessage(String senderId, String receiverId, String token,
      String message) {
    if (socket != null) {
      final data = {
        "sent_by": senderId,
        "sent_to": receiverId,
        "connection_id": connection_id,
        "message": message,
        "token": token
      };
      socket!.emit('send_message', data);
    }

  }

  void disconnect() async {
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
      socket!.destroy();
      print(socket!.disconnected);
      notifyListeners();
    }
  }
}
//
// //
// ChatModel getChatModel(String receiverId) {
//
//   final existingChatModel = filteredChatModels.firstWhere(
//         (chat) => chat.personID == receiverId,
//     orElse: () {
//       final userData = data1.firstWhere((data) => data['_id'] == receiverId,
//           orElse: () => null);
//       if (userData != null) {
//         final chatModel = ChatModel(
//           id: 0, // Provide an appropriate ID for the new chat model
//           personID: receiverId,
//           name: userData['first_name']??"",
//           lastname: userData['last_name']??'',
//           messages: [],
//           icon: userData['profile_pic'] ?? '',
//         );
//         filteredChatModels.add(chatModel);
//         return chatModel;
//       } else {
//         return ChatModel(
//           id: 0, // Provide an appropriate ID
//           personID: receiverId,
//           name: '',
//           lastname: '',
//           messages: [],
//           icon: '',
//         );
//       }
//     },
//   );
//   return existingChatModel;
// }
/*  try {
      print('Socket connected: ${socket!.connected}');
      final senderResponse = await http.get(
        Uri.parse('http://139.59.47.49:4001/user/connections'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );
      final senderData = jsonDecode(senderResponse.body);
    } catch (e) {
      print('Socket connection error: $e');
    }*/
