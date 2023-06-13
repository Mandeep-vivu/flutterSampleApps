import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:flutter/material.dart';


class MailLogin extends StatefulWidget {
  const MailLogin({Key? key}) : super(key: key);

  @override
  State<MailLogin> createState() => _MailLoginState();
}

class _MailLoginState extends State<MailLogin> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cpasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mobileformKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonUI(
      children: [
        TextFormField(
      controller: _firstController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _lastController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
        ),

        Form(
          key: _emailFormKey,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _mailController,

            autofocus: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ),

        Form(
          key: _mobileformKey,
          child: TextFormField(
            controller: _mobileNumberController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,

            onChanged: (value) {
              setState(() {

              });
            },

            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your mobile number';
              }
              return null;
            },
          ),
        ),

        Form(
          key: _passwordFormKey,
          child: TextFormField(
            controller: _passwordController,

            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }

              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }

              if (!RegExp(
                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$')
                  .hasMatch(value)) {
                return 'Password must be right';
              }

              if (value != _password1Controller.text) {
                return 'Passwords do not match';
              }

              return null;
            },

          ),
        ),

        Form(
          key: _cpasswordFormKey,
          child: TextFormField(
            controller: _password1Controller,

            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
        ),


        ResponsiveContainer(
          child: ElevatedButton(
            onPressed:  _submitForm,
            child: const HeadingWidget(
                text: 'Continue', color: Colors.white, fontSize: 16),
          ),
        ),

      ],

    );
  }

  void _submitForm() {
    if (_emailFormKey.currentState!.validate() &&
        _passwordFormKey.currentState!.validate()) {
      // Forms are valid, continue with further actions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container();
        },
      );
    }
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class MessageModel {
  final String text;
  final DateTime time;
  final bool isSent;
  bool isRead;

  MessageModel({
    required this.text,
    required this.time,
    required this.isSent,
    this.isRead = false,
  });

  void markAsRead() {
    isRead = true;
  }
}

class ChatModel {
  final int id;
  final String name;
  final bool isGroup;
  final ObservableList<MessageModel> messages;
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
    messages.sort((a, b) => b.time.compareTo(a.time));
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
}

class ChatProvider with ChangeNotifier {
  final ObservableList<ChatModel> _chatModels = ObservableList.of([
    ChatModel(
      id: 1,
      name: "John Doe",
      isGroup: false,
      messages: ObservableList.of([
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
      ]),
      icon: "assets/email.png",
    ),
    ChatModel(
      id: 2,
      name: "Jane Smith",
      isGroup: false,
      messages: ObservableList.of([
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
      ]),
      icon: "assets/logo.png",
    ),
    ChatModel(
      id: 3,
      name: "Group Chat",
      isGroup: true,
      messages: ObservableList.of([
        MessageModel(
          text: "Hi everyone!",
          time: DateTime.now().subtract(Duration(hours: 2)),
          isSent: true,
        ),
        MessageModel(
          text: "Let's plan for the weekend.",
          time: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
          isSent: true,
        ),
      ]),
      icon: "assets/google.png",
    ),
  ]);

  ObservableList<ChatModel> get chatModels => _chatModels;

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
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatProvider chatProvider = ChatProvider();
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void updateFilteredChatModels(String query) {
    setState(() {
      if (query.isEmpty) {
        isSearching = false;
      } else {
        isSearching = true;
      }

      chatProvider.chatModels.sort((a, b) {
        final DateTime? aTime = a.latestMessageTime;
        final DateTime? bTime = b.latestMessageTime;
        if (aTime == null && bTime == null) {
          return 0;
        } else if (aTime == null) {
          return 1;
        } else if (bTime == null) {
          return -1;
        } else {
          return bTime.compareTo(aTime);
        }
      });

      if (query.isNotEmpty) {
        final List<ChatModel> filteredList = chatProvider.chatModels
            .where((chatModel) =>
            chatModel.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        filteredList.sort((a, b) {
          final DateTime? aTime = a.latestMessageTime;
          final DateTime? bTime = b.latestMessageTime;
          if (aTime == null && bTime == null) {
            return 0;
          } else if (aTime == null) {
            return 1;
          } else if (bTime == null) {
            return -1;
          } else {
            return bTime.compareTo(aTime);
          }
        });

        chatProvider.chatModels.clear();
        chatProvider.chatModels.addAll(filteredList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: buildAppBar(),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.red,
            height: 1,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                final List<ChatModel> chatModels = chatProvider.chatModels;
                return ListView.separated(
                  itemCount: chatModels.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndividualPage(
                            chatModel: chatModels[index],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        buildListTile(chatModels[index]),
                        const Padding(
                          padding: EdgeInsets.only(right: 20, left: 80),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        elevation: 0,
        child: const Icon(Icons.add),
        splashColor: Colors.amberAccent,
      ),
    );
  }

  ListTile buildListTile(ChatModel chatModel) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Image.asset(
          chatModel.icon,
          height: 36,
          width: 36,
        ),
      ),
      title: Text(
        chatModel.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.done_all),
          const SizedBox(
            width: 3,
          ),
          Text(
            chatModel.messages.isNotEmpty
                ? chatModel.messages.last.text
                : "No messages",
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: Text(
        chatModel.latestMessageTime != null
            ? DateFormat('hh:mm a').format(chatModel.latestMessageTime!)
            : "",
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: isSearching
          ? TextField(
        autofocus: true,
        controller: searchController,
        onChanged: (value) {
          updateFilteredChatModels(value);
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white54),
        ),
        style: TextStyle(color: Colors.black),
      )
          : Row(
        children: [
          SizedBox(
            height: 30,
            child: Image.asset("assets/logo.png"),
          ),
          const SizedBox(width: 10),
          const Text("Messenger"),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
              if (!isSearching) {
                searchController.clear();
                updateFilteredChatModels(''); // Clear search query and show all chat models
              }
            });
          },
          icon: Icon(
            isSearching ? Icons.close : Icons.search,
            color: Color(0xfffa5a50),
          ),
        ),
      ],
    );
  }
}

class IndividualPage extends StatelessWidget {
  final ChatModel chatModel;

  const IndividualPage({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatModel.name),
      ),
      body: Center(
        child: Text('Individual Chat Page'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomePage()));
}
*/
