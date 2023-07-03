import 'package:developscreens/messenger/messageContainers/own_msg_card.dart';
import 'package:developscreens/messenger/messageContainers/reply_msg_card.dart';
import 'package:developscreens/messenger/message_provider.dart';
import 'package:developscreens/messenger/models/chatmodel.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:developscreens/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'models/message_modal.dart';

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
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isSelectionMode = false;
  List<MessageModel> selectedMessages = [];
  DateTime currentDate = DateTime.now();

  int? currentMonth;

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
    socketService.screenFunction=_scrollToBottom;
    socketService.joinSocket();
    _scrollToBottom();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  bool isDifferentMonth(int index) {
    if (index == 0) {
      return true;
    }
    final currentMessage = widget.chatModel.messages[index];
    final previousMessage = widget.chatModel.messages[index - 1];
    final currentMessageDate = currentMessage.time;
    final previousMessageDate = previousMessage.time;
    return currentMessageDate.month != previousMessageDate.month ||
        currentMessageDate.day != previousMessageDate.day;
  }

  String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime.now();
    final yesterday = DateTime.now().subtract(Duration(days: 1));

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return 'Today';
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      if (date.year != now.year) {
        return DateFormat('MMM d, yyyy').format(date);
      } else {
        return DateFormat('MMM d').format(date);
      }
    }
  }

  Widget buildMonthHeader(DateTime date) {
    final formattedDate = getFormattedDate(date);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Text(
        formattedDate,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleBackPressed() {
    if (isSelectionMode) {
      setState(() {
        selectedMessages.clear();
        isSelectionMode = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketService>(builder: (context, chatProvider, _) {
      widget.chatModel.messages.sort((a, b) => a.time.compareTo(b.time));

      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            leadingWidth: 55,
            titleSpacing: 0,
            leading: InkWell(
              onTap: _handleBackPressed,
              child: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.chatModel.icon),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.chatModel.name} ${widget.chatModel.lastname}",
                          style: const TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: isSelectionMode
                ? [
                    IconButton(
                      onPressed: () {
                        // Perform delete action
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Messages'),
                              content: const Text(
                                'Are you sure you want to delete the selected messages?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    deleteSelectedMessages();
                                  },
                                  child: const Text('Delete'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        // Perform copy action
                        String combinedText = selectedMessages
                            .map((message) => message.text)
                            .join('\n');
                        Clipboard.setData(ClipboardData(text: combinedText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Copied selected messages')),
                        );
                      },
                      icon: const Icon(Icons.content_copy),
                    ),
                  ]
                : [
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      padding: const EdgeInsets.all(0),
                      onSelected: (value) {
                        print(value);
                      },
                      itemBuilder: (BuildContext contesxt) {
                        return [
                          const PopupMenuItem(
                            value: "View Contact",
                            child: Text("View Contact"),
                          ),
                          const PopupMenuItem(
                            value: "Search",
                            child: Text("Search"),
                          ),
                        ];
                      },
                    ),
                  ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WillPopScope(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      padding: const EdgeInsets.only(left: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: _controller,
                                      focusNode: focusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            show
                                                ? Icons.keyboard
                                                : Icons.emoji_emotions_outlined,
                                          ),
                                          onPressed: () {
                                            if (!show) {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                            }
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                        ),
                                        suffixIcon: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [],
                                        ),
                                        contentPadding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    right: 4,
                                    left: 0,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: const Color(0xFFfa5a50),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.white,
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
                                                message
                                              );
                                              _scrollToBottom();
                                            _controller.clear();

                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          show ? Container() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () {
              if (show) {
                setState(() {
                  show = false;
                });
                return Future.value(false);
              } else {
                Navigator.pop(context);
                return Future.value(true);
              }
            },
          ),
        ),
      );
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteSelectedMessages() {
    setState(() {
      widget.chatModel.messages
          .removeWhere((message) => selectedMessages.contains(message));
      selectedMessages.clear();
      widget.updateChatModel(widget.chatModel);
      isSelectionMode = false;
      Navigator.pop(context);
    });
  }

  Widget buildMessageCard(MessageModel message) {
    final isSelected = selectedMessages.contains(message);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          isSelectionMode = true;
          selectedMessages.add(message);
        });
      },
      onTap: () {
        if (isSelectionMode) {
          setState(() {
            if (isSelected) {
              selectedMessages.remove(message);
              if (selectedMessages.isEmpty) {
                isSelectionMode = false;
              }
            } else {
              selectedMessages.add(message);
            }
          });
        }
      },
      child: Container(
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
                isSelected: isSelected,
              )
            : ReplyCard(
                message: message.text,
                time: DateFormat('HH:mm').format(message.time),
                isSelected: isSelected,
              ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}
