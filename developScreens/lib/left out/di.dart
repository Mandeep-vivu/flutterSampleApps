//
//
// import 'package:flutter/material.dart';
//
// class IndividualPage extends StatefulWidget {
//   final ChatModel chatModel;
//   final Function(ChatModel) updateChatModel;
//
//   IndividualPage({
//     super.key,
//     required this.chatModel,
//     required this.updateChatModel,
//   });
//
//   @override
//   _IndividualPageState createState() => _IndividualPageState();
// }
//
// class _IndividualPageState extends State<IndividualPage> {
//   bool show = false;
//   bool sendButton = false;
//   final TextEditingController _controller = TextEditingController();
//   List<MessageModel> selectedMessages = [];
//   DateTime currentDate = DateTime.now();
//   int? currentMonth;
//
//   @override
//   void initState() {
//     super.initState();
//     final socketService = Provider.of<SocketService>(context, listen: false);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     socketService.createConnection(
//       authProvider.personids,
//       widget.chatModel.personID,
//       authProvider.token,
//     );
//     socketService.joinSocket();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SocketService>(builder: (context, chatProvider, _) {
//       widget.chatModel.messages.sort((a, b) => a.time.compareTo(b.time));
//
//       return Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 controller: _scrollController,
//                 itemCount: (widget.chatModel.messages.length),
//                 itemBuilder: (context, index) {
//                   final message = widget.chatModel.messages[index];
//                   return buildMessageCard(message);
//                 },
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width - 60,
//                     child: Card(
//                       margin: const EdgeInsets.only(
//                           left: 2, right: 2, bottom: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: TextFormField(
//                         controller: _controller,
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             setState(() {
//                               sendButton = true;
//                             });
//                           } else {
//                             setState(() {
//                               sendButton = false;
//                             });
//                           }
//                         },
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Type a message",
//                           hintStyle:
//                           const TextStyle(color: Colors.grey),
//                           prefixIcon: IconButton(
//                             icon: Icon(
//                               show
//                                   ? Icons.keyboard
//                                   : Icons.emoji_emotions_outlined,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 show = !show;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   CircleAvatar(
//                     radius: 25,
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.send,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           if (sendButton) {
//                             sendButton = false;
//                             String message = _controller.text;
//                             ChatModel updatedChatModel =
//                                 widget.chatModel;
//                             final socketService =
//                             Provider.of<SocketService>(
//                                 context,
//                                 listen: false);
//                             final authProvider =
//                             Provider.of<AuthProvider>(
//                                 context,
//                                 listen: false);
//                             socketService.sendMessage(
//                                 authProvider.personids,
//                                 widget.chatModel.personID,
//                                 authProvider.token,
//                                 message,
//                                 updatedChatModel
//                             );
//                             _controller.clear();
//                             _scrollToBottom();
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//
//
//
//   Widget buildMessageCard(MessageModel message) {
//
//
//     return Container(
//       decoration: BoxDecoration(
//         color: message.isSelected
//             ? Colors.blue.withOpacity(0.2)
//             : Colors.transparent,
//         // Add any desired container styling for selected messages
//       ),
//       child: message.isSent
//           ? OwnMessageCard(
//         message: message.text,
//         time: DateFormat('HH:mm').format(message.time),
//         isSelected: isSelected,
//       )
//           : ReplyCard(
//         message: message.text,
//         time: DateFormat('HH:mm').format(message.time),
//         isSelected: isSelected,
//       ),
//     );
//   }
// import 'dart:math';
// import 'package:developscreens/messenger/profile_page.dart';
//
// import 'package:developscreens/messenger/individual_page.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:developscreens/messenger/models/chatmodel.dart';
// import 'package:developscreens/provider_aut.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import 'package:developscreens/socket_service.dart';
//
// class HomePa extends StatefulWidget {
//   final String token;
//   final String userId;
//   const HomePa({
//     Key? key,
//     required this.token,
//     required this.userId,
//   }) : super(key: key);
//
//   @override
//   State<HomePa> createState() => _HomePaState();
// }
//
// class _HomePaState extends State<HomePa> {
//   final SocketService chatProvider = SocketService();
//
//   bool isSearching = false;
//   List<ChatModel> filteredChatModelss = [];
//   bool isEditMode = false;
//   Set<int> selectedChatIds = {};
//
//   bool isBottomSheetOpen = false;
//   late IO.Socket socket;
//   @override
//   void initState() {
//     super.initState();
//     filteredChatModelss = chatProvider.filteredChatModels;
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     authProvider.selectContact();
//     final socketService = Provider.of<SocketService>(context, listen: false);
//     socketService.connect(widget.token);
//   }
//
//   void bottomsheetdata(BuildContext context) {
//     isBottomSheetOpen = true;
//     final authProvider1 = Provider.of<AuthProvider>(context, listen: false);
//     List<dynamic> datalist = authProvider1.data;
//
//     showModalBottomSheet<void>(
//       enableDrag: true,
//       showDragHandle: true,
//       useSafeArea: true,
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.sizeOf(context).height * 0.95,
//           child: ListView.builder(
//             itemCount: datalist.length,
//             itemBuilder: (BuildContext context, int index) {
//               final Map<String, dynamic> contactData = datalist[index];
//               final String contactName = contactData['first_name'];
//               final String idm = contactData["_id"];
//               final String lastname = contactData['last_name'];
//               String imageurl = contactData['profile_pic'];
//               return Container(
//
//                 child: ListTile(
//                   title: Text(contactName + " " + lastname),
//                   onTap: () {
//                     Navigator.pop(context);
//                     Future.microtask(() {
//                       String icon = imageurl;
//                       int maxId = filteredChatModelss.isNotEmpty
//                           ? filteredChatModelss
//                               .map((chatModel) => chatModel.id)
//                               .reduce(max)
//                           : 0;
//                       ChatModel newChatModel = ChatModel(
//                         id: maxId + 1,
//                         personID: idm,
//                         name: contactName,
//                         lastname: contactData['last_name'] ?? " ",
//                         messages: [],
//                         icon: icon,
//                       );
//                       final existingChatIndex = filteredChatModelss.indexWhere(
//                           (chatModel) =>
//                               chatModel.personID == newChatModel.personID);
//                       if (existingChatIndex != -1) {
//                         ChatModel existingChatModel =
//                             filteredChatModelss[existingChatIndex];
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => IndividualPage(
//                               chatModel: existingChatModel,
//                               updateChatModel: updateChatModel,
//                             ),
//                           ),
//                         );
//                       } else {
//                         updateChatModel(newChatModel);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => IndividualPage(
//                               chatModel: newChatModel,
//                               updateChatModel: updateChatModel,
//                             ),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     ).whenComplete(() {
//       isBottomSheetOpen = false;
//     });
//   }
//
//   void updateChatModel(ChatModel updatedChatModel) {
//     setState(() {
//       int index = filteredChatModelss
//           .indexWhere((model) => model.id == updatedChatModel.id);
//       if (index != -1) {
//         filteredChatModelss.removeAt(index);
//         filteredChatModelss.insert(0, updatedChatModel);
//       } else {
//         filteredChatModelss.insert(0, updatedChatModel);
//       }
//     });
//   }
//
//   void updateFilteredChatModels(String query) {
//     setState(() {
//       filteredChatModelss = chatProvider.filteredChatModels
//           .where((chatModel) =>
//               chatModel.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//
//       filteredChatModelss.sort((a, b) {
//         final DateTime? aTime = a.latestMessageTime;
//         final DateTime? bTime = b.latestMessageTime;
//         if (aTime == null && bTime == null) {
//           return 0;
//         } else if (aTime == null) {
//           return 1;
//         } else if (bTime == null) {
//           return -1;
//         } else {
//           return bTime.compareTo(aTime);
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.separated(
//               itemCount: filteredChatModelss.length,
//               itemBuilder: (context, index) => InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => IndividualPage(
//                         chatModel: filteredChatModelss[index],
//                         updateChatModel: updateChatModel,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   children: [
//                     buildListTile(filteredChatModelss[index]),
//                   ],
//                 ),
//               ),
//               separatorBuilder: (BuildContext context, int index) =>
//                   const Divider(
//                 height: 4,
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           if (!isBottomSheetOpen) {
//             final authProvider =
//                 Provider.of<AuthProvider>(context, listen: false);
//             if (authProvider.data.isNotEmpty) {
//               bottomsheetdata(context);
//             }
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   ListTile buildListTile(ChatModel chatModel) {
//     return ListTile(
//       title: Text(
//         "${chatModel.name} ${chatModel.lastname}",
//       ),
//       subtitle: Row(
//         children: [
//           Text(
//             chatModel.messages.isNotEmpty
//                 ? chatModel.messages.last.text.trim()
//                 : "No messages",
//           ),
//         ],
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => IndividualPage(
//               chatModel: chatModel,
//               updateChatModel: updateChatModel,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
//
// class SocketService with ChangeNotifier {
//   static IO.Socket? socket;
//   Function? screenFunction;
//   String? userId;
//   String? ReuserId;
//   String toeken = "";
//   String connection_id = '';
//   List<dynamic> data1 = [];
//   List<ChatModel> filteredChatModels = [];
//
//   void updateChatModel(ChatModel updatedChatModel) {
//     int index = filteredChatModels
//         .indexWhere((model) => model.id == updatedChatModel.id);
//     if (index != -1) {
//       filteredChatModels.removeAt(index);
//       filteredChatModels.insert(0, updatedChatModel);
//     } else {
//       filteredChatModels.insert(0, updatedChatModel);
//     }
//     notifyListeners();
//   }
//
//   late ChatModel chatModelss;
//   void connect(String token) async {
//     socket = IO.io(
//         'http://139.59.47.49:4001',
//         IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
//             {'token': token}) // optional
//             .build());
//
//     socket!.onError((data) => print("ERROR:$data"));
//     socket!.connect();
//     socket!.onConnect((d) {
//       listenCreateConnection();
//       listenSendMessage();
//       notifyListeners();
//     });
//     socket!.onAny((event, data) => print("any---=-$event"));
//   }
//
//   void createConnection(String senderId, String receiverId, String token) {
//     if (socket != null) {
//       final data = {
//         'sent_by': senderId,
//         'sent_to': receiverId,
//         'token': token,
//       };
//       userId = senderId;
//       ReuserId = receiverId;
//       toeken = token;
//       socket!.emit('create_connection', data);
//     }
//   }
//
//   listenCreateConnection() {
//     socket!.on("create_connection", (data) async {
//       connection_id = data['connection_id'];
//     });
//     notifyListeners();
//   }
//
//   Future<void> saelectContact() async {
//     final response = await http.get(
//       Uri.parse('http://139.59.47.49:4001/user'),
//       headers: {
//         'accept': '*/*',
//         'token': toeken,
//       },
//     );
//     if (response.statusCode == 200) {
//       data1 = json.decode(response.body);
//     } else {
//       print('API error: ${response.statusCode}');
//     }
//   }
//   listenSendMessage() {
//     socket!.on('recived_message', (data) {
//       saelectContact();
//       final String senderId = data['sent_by'];
//       final String messageId = data['_id'];
//       final String messageText = data['message'];
//       final bool isSent =
//       (senderId == userId);
//       final message = MessageModel(
//         text: messageText,
//         time: DateTime.now(),
//         isSent: isSent,
//         isRead: false,
//         mID: messageId,
//       );
//       chatModelss.addMessage(message);
//       screenFunction?.call();
//       updateChatModel(chatModelss);
//       notifyListeners();
//     });
//   }
//
//   void sendMessage(String senderId, String receiverId, String token,
//       String message, param4) {
//     chatModelss = param4;
//     if (socket != null) {
//       final data = {
//         "sent_by": senderId,
//         "sent_to": receiverId,
//         "connection_id": connection_id,
//         "message": message,
//         "token": token
//       };
//       socket!.emit('send_message', data);
//     }
//   }
// }
// /*
//
// class _HomePaState extends State<HomePa> {
//   final SocketService chatProvider = SocketService();
//   List<ChatModel> filteredChatModelss = [];
//   bool isBottomSheetOpen = false;
//
//   @override
//   void initState() {
//     super.initState();
//     filteredChatModelss = chatProvider.filteredChatModels;
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     authProvider.selectContact();
//     final socketService = Provider.of<SocketService>(context, listen: false);
//     socketService.connect(widget.token);
//     socketService.addListener(() {
//       updateChatModel(socketService.chatModelss);
//     });
//   }
//   @override
//   void dispose() {
//     final socketService = Provider.of<SocketService>(context, listen: false);
//     socketService.removeListener(() {
//       updateChatModel(socketService.chatModelss);
//     });
//     super.dispose();
//   }
//   void bottomsheetdata(BuildContext context) {
//     isBottomSheetOpen = true;
//     final authProvider1 = Provider.of<AuthProvider>(context, listen: false);
//     List<dynamic> datalist = authProvider1.data;
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return ListView.builder(
//           itemCount: datalist.length,
//           itemBuilder: (BuildContext context, int index) {
//             final Map<String, dynamic> contactData = datalist[index];
//             final String contactName =
//                 contactData['first_name'] ?? contactData['phone_no'].toString();
//             final String idm = contactData["_id"];
//             final String lastname = contactData['last_name'] ?? " ";
//             String imageurl = contactData['profile_pic'] ??
//                 'https://loremflickr.com/320/240?random=$index';
//             return ListTile(
//               title: Text(contactName + " " + lastname),
//               subtitle: Text(contactData['email']),
//               onTap: () {
//                   String icon = imageurl;
//                   int maxId = filteredChatModelss.isNotEmpty
//                       ? filteredChatModelss
//                       .map((chatModel) => chatModel.id)
//                       .reduce(max)
//                       : 0;
//                   ChatModel newChatModel = ChatModel(
//                     id: maxId + 1,
//                     personID: idm,
//                     name: contactName,
//                     lastname: contactData['last_name'] ?? " ",
//                     messages: [],
//                     icon: icon,
//                   );
//                   final existingChatIndex = filteredChatModelss.indexWhere(
//                           (chatModel) =>
//                       chatModel.personID == newChatModel.personID);
//                   if (existingChatIndex != -1) {
//                     ChatModel existingChatModel =
//                     filteredChatModelss[existingChatIndex];
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => IndividualPage(
//                           chatModel: existingChatModel,
//                           updateChatModel: updateChatModel,
//                         ),
//                       ),
//                     );
//                   } else {
//                     updateChatModel(newChatModel);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => IndividualPage(
//                           chatModel: newChatModel,
//                           updateChatModel: updateChatModel,
//                         ),
//                       ),
//                     );
//                   }
//
//               },
//             );
//           },
//         );
//       },
//     ).whenComplete(() {
//       isBottomSheetOpen = false;
//     });
//   }
//   void updateChatModel(ChatModel updatedChatModel) {
//     setState(() {
//       int index = filteredChatModelss
//           .indexWhere((model) => model.id == updatedChatModel.id);
//       if (index != -1) {
//         filteredChatModelss.removeAt(index);
//         filteredChatModelss.insert(0, updatedChatModel);
//       } else {
//         filteredChatModelss.insert(0, updatedChatModel);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.separated(
//               itemCount: filteredChatModelss.length,
//               itemBuilder: (context, index) => InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => IndividualPage(
//                         chatModel: filteredChatModelss[index],
//                         updateChatModel: updateChatModel,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   children: [
//                     buildListTile(filteredChatModelss[index]),
//                   ],
//                 ),
//               ),
//               separatorBuilder: (BuildContext context, int index) =>
//               const Divider(
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           if (!isBottomSheetOpen) {
//             final authProvider =
//             Provider.of<AuthProvider>(context, listen: false);
//             if (authProvider.data.isNotEmpty) {
//               bottomsheetdata(context);
//             }
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   ListTile buildListTile(ChatModel chatModel) {
//     return ListTile(
//       title: Text(
//         "${chatModel.name} ${chatModel.lastname}",
//       ),
//       subtitle: Text(
//         chatModel.messages.isNotEmpty
//             ? chatModel.messages.last.text.trim()
//             : "No messages",
//       ),
//       onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => IndividualPage(
//                 chatModel: chatModel,
//                 updateChatModel: updateChatModel,
//               ),
//             ),
//           );
//       },
//     );
//   }
// }
//*/
