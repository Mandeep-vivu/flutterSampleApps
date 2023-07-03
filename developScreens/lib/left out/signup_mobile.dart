// import 'package:developscreens/commons/comn_ui.dart';
// import 'package:developscreens/commons/resp_container.dart';
// import 'package:developscreens/commons/heading_text.dart';
// import 'package:flutter/material.dart';
//
//
// class MailLogin extends StatefulWidget {
//   const MailLogin({Key? key}) : super(key: key);
//
//   @override
//   State<MailLogin> createState() => _MailLoginState();
// }
//
// class _MailLoginState extends State<MailLogin> {
//   final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _cpasswordFormKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _mobileformKey = GlobalKey();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _password1Controller = TextEditingController();
//   final TextEditingController _firstController = TextEditingController();
//   final TextEditingController _lastController = TextEditingController();
//   final TextEditingController _mailController = TextEditingController();
//   final TextEditingController _mobileNumberController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _mobileNumberController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CommonUI(
//       children: [
//         TextFormField(
//       controller: _firstController,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter your first name';
//             }
//             return null;
//           },
//         ),
//         TextFormField(
//           controller: _lastController,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter your last name';
//             }
//             return null;
//           },
//         ),
//
//         Form(
//           key: _emailFormKey,
//           child: TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             controller: _mailController,
//
//             autofocus: false,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your email';
//               }
//               if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
//                   .hasMatch(value)) {
//                 return 'Please enter a valid email address';
//               }
//               return null;
//             },
//           ),
//         ),
//
//         Form(
//           key: _mobileformKey,
//           child: TextFormField(
//             controller: _mobileNumberController,
//             keyboardType: TextInputType.phone,
//             textInputAction: TextInputAction.done,
//
//             onChanged: (value) {
//               setState(() {
//
//               });
//             },
//
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your mobile number';
//               }
//               return null;
//             },
//           ),
//         ),
//
//         Form(
//           key: _passwordFormKey,
//           child: TextFormField(
//             controller: _passwordController,
//
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter a password';
//               }
//
//               if (value.length < 8) {
//                 return 'Password must be at least 8 characters long';
//               }
//
//               if (!RegExp(
//                   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$')
//                   .hasMatch(value)) {
//                 return 'Password must be right';
//               }
//
//               if (value != _password1Controller.text) {
//                 return 'Passwords do not match';
//               }
//
//               return null;
//             },
//
//           ),
//         ),
//
//         Form(
//           key: _cpasswordFormKey,
//           child: TextFormField(
//             controller: _password1Controller,
//
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter a password';
//               }
//               return null;
//             },
//           ),
//         ),
//
//
//         ResponsiveContainer(
//           child: ElevatedButton(
//             onPressed:  _submitForm,
//             child: const HeadingWidget(
//                 text: 'Continue', color: Colors.white, fontSize: 16),
//           ),
//         ),
//
//       ],
//
//     );
//   }
//
//   void _submitForm() {
//     if (_emailFormKey.currentState!.validate() &&
//         _passwordFormKey.currentState!.validate()) {
//       // Forms are valid, continue with further actions
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Container();
//         },
//       );
//     }
//   }
// }
// /*
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';
// import 'package:mobx/mobx.dart';
//
// class MessageModel {
//   final String text;
//   final DateTime time;
//   final bool isSent;
//   bool isRead;
//
//   MessageModel({
//     required this.text,
//     required this.time,
//     required this.isSent,
//     this.isRead = false,
//   });
//
//   void markAsRead() {
//     isRead = true;
//   }
// }
//
// class ChatModel {
//   final int id;
//   final String name;
//   final bool isGroup;
//   final ObservableList<MessageModel> messages;
//   final String icon;
//
//   ChatModel({
//     required this.id,
//     required this.name,
//     required this.isGroup,
//     required this.messages,
//     required this.icon,
//   });
//
//   bool get hasUnreadMessages {
//     return messages.any((message) => !message.isRead);
//   }
//
//   int get unreadMessageCount {
//     return messages.where((message) => !message.isRead).length;
//   }
//
//   DateTime? get latestMessageTime {
//     if (messages.isNotEmpty) {
//       final sortedMessages = List.from(messages);
//       sortedMessages.sort((a, b) => b.time.compareTo(a.time));
//       return sortedMessages[0].time;
//     }
//     return null;
//   }
//
//   void addMessage(MessageModel message) {
//     messages.add(message);
//     messages.sort((a, b) => b.time.compareTo(a.time));
//   }
//
//   bool isDifferentMonth(DateTime dateTime) {
//     if (messages.isNotEmpty) {
//       final latestMessageMonth = latestMessageTime!.month;
//       final latestMessageYear = latestMessageTime!.year;
//       final newMessageMonth = dateTime.month;
//       final newMessageYear = dateTime.year;
//
//       return latestMessageMonth != newMessageMonth ||
//           latestMessageYear != newMessageYear;
//     }
//     return true;
//   }
// }
//
// class ChatProvider with ChangeNotifier {
//   final ObservableList<ChatModel> _chatModels = ObservableList.of([
//     ChatModel(
//       id: 1,
//       name: "John Doe",
//       isGroup: false,
//       messages: ObservableList.of([
//         MessageModel(
//           text: "Hello",
//           time: DateTime.now().subtract(Duration(hours: 1)),
//           isSent: true,
//         ),
//         MessageModel(
//           text: "Hi",
//           time: DateTime.now().subtract(Duration(minutes: 30)),
//           isSent: false,
//         ),
//       ]),
//       icon: "assets/email.png",
//     ),
//     ChatModel(
//       id: 2,
//       name: "Jane Smith",
//       isGroup: false,
//       messages: ObservableList.of([
//         MessageModel(
//           text: "Hey",
//           time: DateTime.now().subtract(Duration(minutes: 45)),
//           isSent: true,
//         ),
//         MessageModel(
//           text: "How are you?",
//           time: DateTime.now().subtract(Duration(minutes: 40)),
//           isSent: true,
//         ),
//       ]),
//       icon: "assets/logo.png",
//     ),
//     ChatModel(
//       id: 3,
//       name: "Group Chat",
//       isGroup: true,
//       messages: ObservableList.of([
//         MessageModel(
//           text: "Hi everyone!",
//           time: DateTime.now().subtract(Duration(hours: 2)),
//           isSent: true,
//         ),
//         MessageModel(
//           text: "Let's plan for the weekend.",
//           time: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
//           isSent: true,
//         ),
//       ]),
//       icon: "assets/google.png",
//     ),
//   ]);
//
//   ObservableList<ChatModel> get chatModels => _chatModels;
//
//   void updateCurrentMessage(ChatModel chatModel, String messageText) {
//     final message = MessageModel(
//       text: messageText,
//       time: DateTime.now(),
//       isSent: true,
//     );
//     chatModel.addMessage(message);
//     notifyListeners();
//   }
//
//   void markMessageAsRead(ChatModel chatModel, MessageModel message) {
//     message.markAsRead();
//     notifyListeners();
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final ChatProvider chatProvider = ChatProvider();
//   bool isSearching = false;
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   void updateFilteredChatModels(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         isSearching = false;
//       } else {
//         isSearching = true;
//       }
//
//       chatProvider.chatModels.sort((a, b) {
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
//
//       if (query.isNotEmpty) {
//         final List<ChatModel> filteredList = chatProvider.chatModels
//             .where((chatModel) =>
//             chatModel.name.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//
//         filteredList.sort((a, b) {
//           final DateTime? aTime = a.latestMessageTime;
//           final DateTime? bTime = b.latestMessageTime;
//           if (aTime == null && bTime == null) {
//             return 0;
//           } else if (aTime == null) {
//             return 1;
//           } else if (bTime == null) {
//             return -1;
//           } else {
//             return bTime.compareTo(aTime);
//           }
//         });
//
//         chatProvider.chatModels.clear();
//         chatProvider.chatModels.addAll(filteredList);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: buildAppBar(),
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             color: Colors.red,
//             height: 1,
//           ),
//           Expanded(
//             child: Observer(
//               builder: (_) {
//                 final List<ChatModel> chatModels = chatProvider.chatModels;
//                 return ListView.separated(
//                   itemCount: chatModels.length,
//                   itemBuilder: (context, index) => InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => IndividualPage(
//                             chatModel: chatModels[index],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       children: [
//                         buildListTile(chatModels[index]),
//                         const Padding(
//                           padding: EdgeInsets.only(right: 20, left: 80),
//                         ),
//                       ],
//                     ),
//                   ),
//                   separatorBuilder: (BuildContext context, int index) =>
//                   const Divider(
//                     color: Colors.grey,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {});
//         },
//         elevation: 0,
//         child: const Icon(Icons.add),
//         splashColor: Colors.amberAccent,
//       ),
//     );
//   }
//
//   ListTile buildListTile(ChatModel chatModel) {
//     return ListTile(
//       leading: CircleAvatar(
//         radius: 30,
//         child: Image.asset(
//           chatModel.icon,
//           height: 36,
//           width: 36,
//         ),
//       ),
//       title: Text(
//         chatModel.name,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       subtitle: Row(
//         children: [
//           const Icon(Icons.done_all),
//           const SizedBox(
//             width: 3,
//           ),
//           Text(
//             chatModel.messages.isNotEmpty
//                 ? chatModel.messages.last.text
//                 : "No messages",
//             style: const TextStyle(
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//       trailing: Text(
//         chatModel.latestMessageTime != null
//             ? DateFormat('hh:mm a').format(chatModel.latestMessageTime!)
//             : "",
//       ),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       title: isSearching
//           ? TextField(
//         autofocus: true,
//         controller: searchController,
//         onChanged: (value) {
//           updateFilteredChatModels(value);
//         },
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           border: InputBorder.none,
//           hintStyle: TextStyle(color: Colors.white54),
//         ),
//         style: TextStyle(color: Colors.black),
//       )
//           : Row(
//         children: [
//           SizedBox(
//             height: 30,
//             child: Image.asset("assets/logo.png"),
//           ),
//           const SizedBox(width: 10),
//           const Text("Messenger"),
//         ],
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               isSearching = !isSearching;
//               if (!isSearching) {
//                 searchController.clear();
//                 updateFilteredChatModels(''); // Clear search query and show all chat models
//               }
//             });
//           },
//           icon: Icon(
//             isSearching ? Icons.close : Icons.search,
//             color: Color(0xfffa5a50),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class IndividualPage extends StatelessWidget {
//   final ChatModel chatModel;
//
//   const IndividualPage({required this.chatModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(chatModel.name),
//       ),
//       body: Center(
//         child: Text('Individual Chat Page'),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(home: HomePage()));
// }
// */
// /*
//
// class IndividualPage extends StatefulWidget {
//   final ChatModel chatModel;
//   final Function(ChatModel) updateChatModel;
//
//   IndividualPage({
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
//   FocusNode focusNode = FocusNode();
//   bool sendButton = false;
//   TextEditingController _controller = TextEditingController();
//   ScrollController _scrollController = ScrollController();
//   int? currentMonth;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollToBottom();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           show = false;
//         });
//       }
//     });
//   }
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatProvider>(builder: (context, chatProvider, _) {
//       return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: AppBar(
//             leading: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back,
//               ),
//             ),
//             title: Text(
//               widget.chatModel.name,
//             ),
//             actions: [
//             ],
//           ),
//         ),
//         body: WillPopScope(
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   controller: _scrollController,
//                   itemCount: (widget.chatModel.messages.length),
//                   itemBuilder: (context, index) {
//                     final message = widget.chatModel.messages[index];
//                       return buildMessageCard(message);
//                   },
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           TextFormField(
//                             controller: _controller,
//                             focusNode: focusNode,
//                             keyboardType: TextInputType.multiline,
//                             onChanged: (value) {
//                               if (value.isNotEmpty) {
//                                 setState(() {
//                                   sendButton = true;
//                                 });
//                               } else {
//                                 setState(() {
//                                   sendButton = false;
//                                 });
//                               }
//                             },
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Type a message",
//                               prefixIcon: IconButton(
//                                 icon: Icon(
//                                   show
//                                       ? Icons.keyboard
//                                       : Icons.emoji_emotions_outlined,
//                                 ),
//                                 onPressed: () {
//                                   if (!show) {
//                                     focusNode.unfocus();
//                                     focusNode.canRequestFocus = false;
//                                   }
//                                   setState(() {
//                                     show = !show;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.send,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 if (sendButton) {
//                                   sendButton = false;
//                                   String message = _controller.text;
//                                   ChatModel updatedChatModel =
//                                       widget.chatModel;
//                                   updatedChatModel
//                                       .addMessage(MessageModel(
//                                     text: message,
//                                     time: DateTime.now(),
//                                     isSent: true,
//                                     isRead: false,
//                                   ));
//                                   widget.updateChatModel(
//                                       updatedChatModel);
//                                   _controller.clear();
//                                   _scrollToBottom();
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           onWillPop: () {
//               Navigator.pop(context);
//               return Future.value(true);
//           },
//         ),
//       );
//     });
//   }
//
//   Widget buildMessageCard(MessageModel message) {
//     return OwnMessageCard(
//       message: message.text,
//       time: DateFormat('HH:mm').format(message.time),
//     );
//   }
// }
//
// class OwnMessageCard extends StatelessWidget {
//   const OwnMessageCard({Key? key, required this.message, required this.time})
//       : super(key: key);
//   final String message;
//   final String time;
//
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: Container(
//         padding: EdgeInsets.only(left: 5),
//         decoration: BoxDecoration(
//           color: Color(0xfffa5a50),
//         ),
//         child: Stack(
//           children: [
//             Text(
//               message,
//             ),
//             Text(
//               time,
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }*/
// /*
//
// class _IndividualPageState extends State<IndividualPage> {
//   bool show = false;
//   FocusNode focusNode = FocusNode();
//   bool sendButton = false;
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   bool isSelectionMode = false;
//   List<MessageModel> selectedMessages = [];
//
//   int? currentMonth;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollToBottom();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           show = false;
//         });
//       }
//     });
//   }
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }
//
//   bool isDifferentMonth(int index) {
//     if (index == 0) {
//       return true;
//     }
//     final currentMessage = widget.chatModel.messages[index];
//     final previousMessage = widget.chatModel.messages[index - 1];
//     return currentMessage.time.month != previousMessage.time.month;
//   }
//
//   String getMonthName(int month) {
//     switch (month) {
//       case 1:
//         return 'January';
//       case 2:
//         return 'February';
//       case 3:
//         return 'March';
//       case 4:
//         return 'April';
//       case 5:
//         return 'May';
//       case 6:
//         return 'June';
//       case 7:
//         return 'July';
//       case 8:
//         return 'August';
//       case 9:
//         return 'September';
//       case 10:
//         return 'October';
//       case 11:
//         return 'November';
//       case 12:
//         return 'December';
//       default:
//         return '';
//     }
//   }
//
//   Widget buildMonthHeader(String monthName) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
//
//       child: Text(
//         monthName,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatProvider>(builder: (context, chatProvider, _) {
//       return Scaffold(
//         body: WillPopScope(
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   controller: _scrollController,
//                   itemCount: (widget.chatModel.messages.length),
//                   itemBuilder: (context, index) {
//                     final message = widget.chatModel.messages[index];
//                     final isDifferent = isDifferentMonth(index);
//                     final monthName = getMonthName(message.time.month);
//                     if (isDifferent) {
//                       return Column(
//                         children: [
//                           buildMonthHeader(monthName),
//                           buildMessageCard(message),
//                         ],
//                       );
//                     } else {
//                       return buildMessageCard(message);
//                     }
//                   },
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       children: [
//                         TextFormField(
//                           controller: _controller,
//                           focusNode: focusNode,
//                           onChanged: (value) {
//                             if (value.isNotEmpty) {
//                               setState(() {
//                                 sendButton = true;
//                               });
//                             } else {
//                               setState(() {
//                                 sendButton = false;
//                               });
//                             }
//                           },
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Type a message",
//                             hintStyle:
//                             const TextStyle(color: Colors.grey),
//                             prefixIcon: IconButton(
//                               icon: Icon(
//                                 show
//                                     ? Icons.keyboard
//                                     : Icons.emoji_emotions_outlined,
//                               ),
//                               onPressed: () {
//                                 if (!show) {
//                                   focusNode.unfocus();
//                                   focusNode.canRequestFocus = false;
//                                 }
//                                 setState(() {
//                                   show = !show;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         CircleAvatar(
//                           radius: 25,
//                           backgroundColor: const Color(0xFFfa5a50),
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.send,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 if (sendButton) {
//                                   sendButton = false;
//                                   String message = _controller.text;
//                                   ChatModel updatedChatModel =
//                                       widget.chatModel;
//                                   updatedChatModel
//                                       .addMessage(MessageModel(
//                                     text: message,
//                                     time: DateTime.now(),
//                                     isSent: true,
//                                     isRead: false,
//                                   ));
//                                   widget.updateChatModel(
//                                       updatedChatModel);
//                                   _controller.clear();
//                                   _scrollToBottom();
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     show ? Container() : Container(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           onWillPop: () {
//             if (show) {
//               setState(() {
//                 show = false;
//               });
//               return Future.value(false);
//             } else {
//               Navigator.pop(context);
//               return Future.value(true);
//             }
//           },
//         ),
//       );
//     });
//   }
//
//
//
//   Widget buildMessageCard(MessageModel message) {
//     final isSelected = selectedMessages.contains(message);
//     return GestureDetector(
//       onLongPress: () {
//         setState(() {
//           isSelectionMode = true;
//           selectedMessages.add(message);
//         });
//       },
//       onTap: () {
//         if (isSelectionMode) {
//           setState(() {
//             if (isSelected) {
//               selectedMessages.remove(message);
//               if (selectedMessages.isEmpty) {
//                 isSelectionMode = false;
//               }
//             } else {
//               selectedMessages.add(message);
//             }
//           });
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: message.isSelected
//               ? Colors.blue.withOpacity(0.2)
//               : Colors.transparent,
//           // Add any desired container styling for selected messages
//         ),
//         child: message.isSent
//             ? OwnMessageCard(
//           message: message.text,
//           time: DateFormat('HH:mm').format(message.time),
//           isSelected: isSelected,
//         )
//             : ReplyCard(
//           message: message.text,
//           time: DateFormat('HH:mm').format(message.time),
//           isSelected: isSelected,
//         ),
//       ),
//     );
//   }
// }
// */
//
// /*
// class MessageAndSockets with ChangeNotifier {
//   var tokenApi;
//   IO.Socket? socket;
//   // bool? isConnected;
//   bool? isBlocked;
//   String? otherUserName;
//   String? otherUserPic;
//   String? userId;
//   String? otherUserId;
//
//   List<UserCurrentLocation> _location=[];
//   List<UserCurrentLocation> get location {
//     return [..._location];
//   }
//   List<ChatMessage> _data = [];
//   List<ChatMessage> get data {
//     return [..._data];
//   }
//   var time;
//
//   List<ChatListing> _chatList = [];
//   List<ChatListing> get chatList {
//     return [..._chatList];
//   }
//
//   blockUser(isBlock){
//     isBlocked=isBlock;
//     notifyListeners();
//   }
//
//   connectSocket() async {
//     // isConnected=socket?.connected;
//     tokenApi = await StorageFunctions().getValue( authToken);
//     if(socket!=null&&socket?.json.io.options.containsKey('extraHeaders')==true&&socket?.json.io.options['extraHeaders'].containsKey('token')==true&&socket?.json.io.options['extraHeaders']['token']!=tokenApi){
//       print("OLD Token:${socket?.json.io.options['extraHeaders']['token']}");
//       socket?.json.io.options['extraHeaders']['token']=tokenApi;
//       print("NEW Token:${socket?.json.io.options['extraHeaders']['token']}");
//       notifyListeners();
//     }
//     socket =await  IO.io(socketUrl,
//         IO.OptionBuilder()
//             .setTransports(['websocket'])
//             .setExtraHeaders({'token':tokenApi})
//             .build());
//     socket!.onError((data) => print("ERROR:$data"));
//     socket!.onConnect((d) {
//       print(socket!.json.io.options);
//       // isConnected=socket?.connected;
//       listenCreateConnection();
//       listenSendMessage();
//       listenReceiveMessage();
//       // listenSocket();
//       listenUserCurrentLocation();
//       // listenCompleteRide();
//       notifyListeners();
//     });
//     // print("Connected=====$isConnected");
//     socket!.onReconnect((data) => print("RECONNECT:$data"));
//     socket!.onReconnectAttempt((data) => print("RECONNECT-Attempt:$data"));
//     socket!.onReconnectError((data) => print("RECONNECT-Error:$data"));
//     socket!.onDisconnect((_) => {
//       // isConnected=socket?.connected,
//       socket!.destroy(),notifyListeners(),
//     });
//     socket!.on('fromServer', (_) => print(_));
//     socket!.onConnecting((data) => print("1231231312$data"));
//     socket!.on('event', (data) => print(data));
//     print("INSIDE");
//     notifyListeners();
//   }
//   listenCreateConnection() {
//     socket!.on("connection", (data) async {
//       print(data);
//     });
//
//     notifyListeners();
//   }
//
//   listenSendMessage() async {
//     // print('send-message');
//     socket!.on("receive_message", (data) {
//       addMessage(e: data,type:"_id");
//       // print('send-message---$data');
//     });
//     return;
//   }
//
//   listenReceiveMessage() async {
//     socket!.on("list_chat_users", (data) {
//       addMessage(e: data,type: 'message_id');
//       addMessageToList(chatList: data);
//     });
//     return;
//   }
//
//
//   void addMessage({required e,required type}) {
//     bool? isAdded;
//     for (var element in _data) {
//       if(element.messageId == e[type].toString()){
//         isAdded=true;
//         break;
//       }else{}
//     }
//     if (isAdded!=true&&(userId==e['sent_by']['_id']||userId==e['sent_to']['_id'])) {
//       _data.add(ChatMessage(
//         createdAt:type=="_id"? e['created_at']:e['updated_at'],
//         messageId: e[type].toString(),
//         socketId: e['connection_id'].toString(),
//         sendBy: SendBy(
//             name: e['sent_by']['name'].toString(),
//             id: e['sent_by']['_id'].toString(),
//             profile_pic: e['sent_by']['profile_pic'].toString()),
//         sendTo: SendTo(
//             name: e['sent_to']['name'].toString(),
//             id: e['sent_to']['_id'].toString(),
//             profile_pic: e['sent_to']['profile_pic'].toString()),
//         type: e['type'].toString(),
//         messageType: e['message_type'].toString(),
//         message:type=="_id"? e['message'].toString():e['last_message'].toString(),
//         mediaUrl: e['media_url'].toString(),
//         frontImg: e['front_img'].toString(),
//       ));
//     }
//     notifyListeners();
//   }
//
//   void addMessageToList({required chatList}) {
//     print("addList TRUE OR NOT--${chatList['sent_by']['_id']==userId||chatList['sent_to']['_id']==userId}");
//     if(chatList['sent_by']['_id']==userId||chatList['sent_to']['_id']==userId){
//       for (var element in _chatList) {
//         if(element.id == chatList['_id'].toString()){
//           _chatList.removeWhere((element) => element.id==chatList['_id']);
//           print("remove Done");
//           _chatList.insert(0,ChatListing(
//               id: chatList['_id'],
//               message_id: chatList['message_id'],
//               profile_pic: chatList['profile_pic'],
//               created_at: chatList['created_at'],
//               full_name: chatList['full_name'],
//               last_message: chatList['last_message'],
//               local_identifier: chatList['local_identifier'],
//               other_user_id: chatList['other_user_id'],
//               token: chatList['token'],
//               unread_msgs: chatList['unread_msgs'],
//               updated_at: chatList['updated_at']));
//           break;
//         }else{
//           print("remove Done2");
//           _chatList.insert(0,ChatListing(
//               id: chatList['_id'],
//               message_id: chatList['message_id'],
//               profile_pic: chatList['profile_pic'],
//               created_at: chatList['created_at'],
//               full_name: chatList['full_name'],
//               last_message: chatList['last_message'],
//               local_identifier: chatList['local_identifier'],
//               other_user_id: chatList['other_user_id'],
//               token: chatList['token'],
//               unread_msgs: chatList['unread_msgs'],
//               updated_at: chatList['updated_at']));
//         }
//       }
//     }
//     notifyListeners();
//   }
//
//   emitSendMessage({Message, sendToId, senderID, localCode,})async {
//     var param = {
//       "sent_to": sendToId,
//       "sender_id": senderID,
//       "local_identifier": localCode,
//       "token": tokenApi,
//       "message": Message,
//       "message_type": "TEXT",
//       "media_url": ""
//     };
//     socket!.emit("send_message", param);
//     print("SendMESSAge---------$param");
//     listenSendMessage();
//   }
//
//   emitUserCurrentLocation({lat,lng,rideId,UserId,isDriver,rotation,userName,onGoing})async {
//     var param = {
//       "lat":lat,
//       "long":lng,
//       "ride_id":rideId,
//       "user_id":UserId,
//       "is_driver":isDriver,
//       "rotation":rotation,
//       "user_name":userName,
//       "on_going":onGoing,
//     };
//     print("param:$param");
//     socket!.emit("save_current_location", param);
//   }
//
//   listenUserCurrentLocation(){
//     socket!.on("current_location", (data) {
//       print("current_location-------$data");
//       // print(_location.any((element) => element.userId== data['user_id']));
//       if(_location.isNotEmpty&&_location.any((element) => element.userId== data['user_id'])){
//         _location[_location.indexWhere((element) => element.userId==data['user_id'])]=UserCurrentLocation(
//             heading: double.parse(data["rotation"].toString()),
//             userName: data['user_name'],
//             lat: data['lat'], lng: data['long'], rideId: data['ride_id']
//             ,userId: data['user_id']
//
//             ,isDriver:data['is_driver'], onGoing: data['on_going'] );
//       }else{
//         _location.add(UserCurrentLocation(
//             heading: double.parse(data["rotation"].toString()),
//             userName: data['user_name'],
//             lat: data['lat'], lng: data['long'], rideId: data['ride_id']
//             ,userId: data['user_id']
//             ,isDriver:data['is_driver'], onGoing: data['on_going'] ));
//       }
//       notifyListeners();
//     });
//   }
//   clearLocation(){
//     _location=[];
//     notifyListeners();
//   }
//
//   clearChat(){
//     _data=[];
//     notifyListeners();
//   }
//
//   Future<List<ChatListing>> getChatListing(context) async {
//     List<ChatListing> temp=[];
//     var result = await httpRequest(context,REQUEST_TYPE.GET, userChatListUrl, {});
//     result = await json.decode(result.body)['data']['data'];
//     print(result);
//     if (result.length == 0) {
//       _chatList = [];
//     } else {
//       result.forEach((chatList) {
//         if (_chatList.any((element) => element.id == chatList['_id'])) {
//           // print("object!1");
//           _chatList.removeWhere((element) => element.id == chatList['_id']);
//           temp.insert(0, ChatListing(
//               id: chatList['_id'],
//               profile_pic: chatList['profile_pic'],
//               full_name: chatList['full_name'],
//               last_message: chatList['last_message'],
//               local_identifier: chatList['local_identifier'],
//               other_user_id: chatList['other_user_id'],
//               token: chatList['token'],
//               unread_msgs: chatList['unread_msgs'],
//               created_at: chatList['created_at'],
//               updated_at: chatList['updated_at']));
//           notifyListeners();
//         } else {
//           // print("object!2");
//           _chatList.add(ChatListing(
//               id: chatList['_id'],
//               profile_pic: chatList['profile_pic'],
//               created_at: chatList['created_at'],
//               full_name: chatList['full_name'],
//               last_message: chatList['last_message'],
//               local_identifier: chatList['local_identifier'],
//               other_user_id: chatList['other_user_id'],
//               token: chatList['token'],
//               unread_msgs: chatList['unread_msgs'],
//               updated_at: chatList['updated_at']));
//           notifyListeners();
//         }
//       });
//       temp.forEach((e){
//         _chatList.insert(0,e);
//       });
//       notifyListeners();
//     }
//     notifyListeners();
//     return _chatList;
//   }
//
//   setIDs(userId){
//     this.userId=userId;
//     notifyListeners();
//   }
//
//   void getChatDetails(context,{id}) async {
//     _data=[];
//     var result = await httpRequest(context,
//         REQUEST_TYPE.GET, userChatDetailsUrl + '?_id=$id', {});
//     result = await json.decode(result.body);
//     otherUserName=result['other_user_name'];
//     isBlocked=result['is_blocked'];
//     otherUserPic=result['other_user_pic'];
//     print(result);
//     if(result['data']!=null){
//       result['data'].forEach((element) {
//         _data.add(ChatMessage(
//             createdAt: element['created_at'],
//             socketId: element['connection_id'],
//             messageId: element['_id'],
//             sendBy: SendBy(name: element['sent_by']['name'], id: element['sent_by']['_id'], profile_pic: element['sent_by']['profile_pic']),
//             sendTo: SendTo(name: element['sent_to']['name'], id: element['sent_to']['_id'], profile_pic: element['sent_to']['profile_pic']),
//             type: element['type'],
//             messageType: element['message_type'],
//             message: element['message'],
//             mediaUrl: element['media_url'],
//             frontImg: element['front_img']));
//
//         notifyListeners();
//       });
//     }
//   }
//
//   getFilterChatList(search,context) async {
//     _chatList=[];
//     var result = await httpRequest(context,
//         REQUEST_TYPE.GET, userChatListUrl + "?search=$search", {});
//     result = await json.decode(result.body)['data']['data'];
//     // print(result);
//     if (result.length == 0) {
//       _chatList = [];
//       notifyListeners();
//     } else {
//       result.forEach((chatList) {
//         if (_chatList.any((element) => element.id == chatList['_id'])) {
//           int? index =
//           _chatList.indexWhere((element) => element.id == chatList['_id']);
//           _chatList[index] = ChatListing(
//               id: chatList['_id'],
//               profile_pic: chatList['profile_pic'],
//               created_at: chatList['created_at'],
//               full_name: chatList['full_name'],
//               last_message: chatList['last_message'],
//               local_identifier: chatList['local_identifier'],
//               other_user_id: chatList['other_user_id'],
//               token: chatList['token'],
//               unread_msgs: chatList['unread_msgs'],
//               updated_at: chatList['updated_at']);
//           notifyListeners();
//         } else {
//           _chatList.add(ChatListing(
//               id: chatList['_id'],
//               profile_pic: chatList['profile_pic'],
//               created_at: chatList['created_at'],
//               full_name: chatList['full_name'],
//               last_message: chatList['last_message'],
//               local_identifier: chatList['local_identifier'],
//               other_user_id: chatList['other_user_id'],
//               token: chatList['token'],
//               unread_msgs: chatList['unread_msgs'],
//               updated_at: chatList['updated_at']));
//           notifyListeners();
//         }
//       });
//     }
//   }
//
//
//
//
//   bookingSocket(bookingId){
//     var param = {
//       '_id':bookingId,
//     };
//     print("bookingSocket---$param");
//     socket!.emit("confirm_booking", param);
//   }
//
//   // completeSocket(rideId){
//   //   var param = {
//   //     'ride_id':rideId,
//   //   };
//   //   print("ride_complete---$param");
//   //   socket!.emit("ride_complete", param);
//   // }
//   // listenCompleteRide(){
//   //   socket!.on("ride_complete", (data)
//   //   {
//   //     print("Complete----------------$data");
//   //   });}
//   //
//   // listenSocket(){
//   //   print("Start Listen");
//   //   socket!.on("booking_response", (data) {
//   //     print("Complete----------------$data");
//   //   });
//   //   return;
//   // }
//
//   disconnectSocket(){
//     _chatList=[];
//     tokenApi=null;
//     socket!.close();
//     socket!.disconnect();
//     socket!.destroy();
//     socket!.json.io.cleanup();
//     socket!.dispose();
//     // socket=null;
//     notifyListeners();
//     print("Dis---${socket!.json.io.options['extraHeaders']['token']}");
//     print("Disconnect:${socket!.disconnected}");
//   }
//   removeSocketListener(String socketName){
//     socket!.off(socketName);
//     socket?.offAny((event, data) =>print(event),);
//   }
//   void calculateTime({LatLng? endPoint})async{
//     // _location.forEach((element) {
//     //   print(element.userName);
//     // });
//     if(_location.isNotEmpty){
//       var user =_location.firstWhere((element) => element.userId==userId);
//       var driver =_location.firstWhere((element) => element.isDriver==true);
//
//       // print(" ${LatLng(user.lat,user.lng)} 23232${LatLng(driver.lat,driver.lng)}");
//       try{
//         // print(" ${_origin!.position} 23232${_destination!.position}");
//         final directions = await DirectionsRepository().getDirections(
//             origin:LatLng(user.lat,user.lng), destination:endPoint??LatLng(driver.lat,driver.lng));
//         // print("Direction-----${directions!.totalDistance}--${directions.totalDuration}");
//         time=directions?.totalDuration;
//       }catch(_){}}
//     notifyListeners();
//   }
// }*/
// class IndividualPage extends StatefulWidget {
//   final ChatModel chatModel;
//   final Function(ChatModel) updateChatModel;
//
//   IndividualPage({
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
//   FocusNode focusNode = FocusNode();
//   bool sendButton = false;
//   TextEditingController _controller = TextEditingController();
//   ScrollController _scrollController = ScrollController();
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
//     _scrollToBottom();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           show = false;
//         });
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatProvider>(builder: (context, chatProvider, _) {
//       return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: AppBar(
//             leading: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back,
//               ),
//             ),
//             title: Text(
//               widget.chatModel.name,
//             ),
//             actions: [
//             ],
//           ),
//         ),
//         body: WillPopScope(
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   controller: _scrollController,
//                   itemCount: (widget.chatModel.messages.length),
//                   itemBuilder: (context, index) {
//                     final message = widget.chatModel.messages[index];
//                     return buildMessageCard(message);
//                   },
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           TextFormField(
//                             controller: _controller,
//                             focusNode: focusNode,
//                             keyboardType: TextInputType.multiline,
//                             onChanged: (value) {
//                               if (value.isNotEmpty) {
//                                 setState(() {
//                                   sendButton = true;
//                                 });
//                               } else {
//                                 setState(() {
//                                   sendButton = false;
//                                 });
//                               }
//                             },
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Type a message",
//                               prefixIcon: IconButton(
//                                 icon: Icon(
//                                   show
//                                       ? Icons.keyboard
//                                       : Icons.emoji_emotions_outlined,
//                                 ),
//                                 onPressed: () {
//                                   if (!show) {
//                                     focusNode.unfocus();
//                                     focusNode.canRequestFocus = false;
//                                   }
//                                   setState(() {
//                                     show = !show;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.send,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 if (sendButton) {
//                                   sendButton = false;
//                                   String message = _controller.text;
//                                   ChatModel updatedChatModel =
//                                       widget.chatModel;
//                                   final socketService =
//                                   Provider.of<SocketService>(
//                                       context,
//                                       listen: false);
//                                   final authProvider =
//                                   Provider.of<AuthProvider>(
//                                       context,
//                                       listen: false);
//                                   socketService.sendMessage(
//                                       authProvider.personids,
//                                       widget.chatModel.personID,
//                                       authProvider.token,
//                                       message
//                                   );
//                                   updatedChatModel
//                                       .addMessage(MessageModel(
//                                     text: message,
//                                     time: DateTime.now(),
//                                     isSent: true,
//                                     isRead: false, mID: '',
//                                   ));
//                                   widget.updateChatModel(
//                                       updatedChatModel);
//                                   _controller.clear();
//
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

/*
class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final Function(ChatModel) updateChatModel;

  IndividualPage({
    super.key,
    required this.chatModel,
    required this.updateChatModel,
  });

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool sendButton = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final socketService = Provider.of<SocketService>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    socketService.createConnection(
      authProvider.personids,
      widget.chatModel.personID,
      authProvider.token,
    );
    socketService.joinSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketService>(builder: (context, chatProvider, _) {
      widget.chatModel.messages.sort((a, b) => a.time.compareTo(b.time));
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: (widget.chatModel.messages.length),
              itemBuilder: (context, index) {
                final message = widget.chatModel.messages[index];
                final isDifferent = isDifferentMonth(index);
                if (isDifferent) {
                  return Column(
                    children: [
                      buildMonthHeader(message.time),
                      buildMessageCard(message),
                    ],
                  );
                } else {
                  return buildMessageCard(message);
                }
              },
            ),
            Row(
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type a message",
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                  ),
                  onPressed: () {
                    setState(() {
                      if (sendButton) {
                        sendButton = false;
                        String message = _controller.text;
                        ChatModel updatedChatModel =
                            widget.chatModel;
                        final socketService =
                        Provider.of<SocketService>(
                            context,
                            listen: false);
                        final authProvider =
                        Provider.of<AuthProvider>(
                            context,
                            listen: false);
                        socketService.sendMessage(
                          authProvider.personids,
                          widget.chatModel.personID,
                          authProvider.token,
                          message,
                          updatedChatModel,
                        );
                        widget.updateChatModel(updatedChatModel);
                        _controller.clear();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
  Widget buildMessageCard(MessageModel message) {
    return Container(
      decoration: BoxDecoration(
        color: message.isSelected
            ? Colors.blue.withOpacity(0.2)
            : Colors.transparent,
        // Add any desired container styling for selected messages
      ),
      child: message.isSent
          ? OwnMessageCard(
        message: message.text,
        time: DateFormat('HH:mm').format(message.time),
      )
          : ReplyCard(
        message: message.text,
        time: DateFormat('HH:mm').format(message.time),
      ),
    );
  }
}
*/
