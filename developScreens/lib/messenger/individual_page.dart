import 'package:developscreens/messenger/messageContainers/own_msg_card.dart';
import 'package:developscreens/messenger/messageContainers/reply_msg_card.dart';
import 'package:developscreens/messenger/message_provider.dart';
import 'package:developscreens/messenger/models/chatmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'models/message_modal.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final Function(ChatModel) updateChatModel;


  IndividualPage({
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
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  int? currentMonth;
  List<MessageModel> selectedMessages = [];

  @override
  void initState() {
    super.initState();
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
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  bool isDifferentMonth(int index) {
    if (index == 0) {
      return true; // Always show month header for the first message
    }
    final currentMessage = widget.chatModel.messages[index];
    final previousMessage = widget.chatModel.messages[index - 1];
    return currentMessage.time.month != previousMessage.time.month;
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }


  Widget buildMonthHeader(String monthName) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Colors.grey[300],
      child: Text(
        monthName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, chatProvider, _) {

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: Image.asset(
                        widget.chatModel.isGroup
                            ? "assets/grp.png"
                            : "assets/person.png",
                        height: 36,
                        width: 36,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: selectedMessages.isNotEmpty
                  ? [
                IconButton(
                  onPressed: () {

                    // Perform delete action
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Messages'),
                          content: Text(
                            'Are you sure you want to delete the selected messages?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                              deleteSelectedMessages();

                              },
                              child: Text('Delete'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    // Perform copy action
                    String combinedText = selectedMessages
                        .map((message) => message.text)
                        .join('\n');
                    Clipboard.setData(ClipboardData(text: combinedText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Copied selected messages')),
                    );
                  },
                  icon: Icon(Icons.content_copy),
                ),
              ]
                  : [
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedMessages = [];
                      });
                    }),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
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
                          final monthName = getMonthName(message.time.month);


                          if (isDifferent) {
                            return Column(
                              children: [
                                buildMonthHeader(monthName),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 60,
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          left: 2, right: 2, bottom: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: TextFormField(
                                        controller: _controller,
                                        focusNode: focusNode,
                                        textAlignVertical: TextAlignVertical.center,
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
                                          hintStyle: TextStyle(color: Colors.grey),
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
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [],
                                          ),
                                          contentPadding: EdgeInsets.all(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8,
                                      right: 2,
                                      left: 2,
                                    ),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xFFfa5a50),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {


                                          if (sendButton) {
                                            sendButton = false;

                                            String message = _controller.text;

                                            // Update the current chat model with the new message
                                            ChatModel updatedChatModel = widget.chatModel;
                                            updatedChatModel.addMessage(MessageModel(
                                              text: message,
                                              time: DateTime.now(),
                                              isSent: true,
                                              isRead: false,
                                            ));

                                            // Call the updateChatModel callback with the updated ChatModel
                                            widget.updateChatModel(updatedChatModel);

                                            _controller.clear();
                                            _scrollToBottom();
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
      }
    );
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
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
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
      widget.chatModel.messages.removeWhere((message) => selectedMessages.contains(message));
      selectedMessages.clear();
      widget.updateChatModel(widget.chatModel);
      Navigator.pop(context);
    });
  }


  Widget buildMessageCard(MessageModel message) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          message.isSelected = true;
          selectedMessages.add(message);
        });
      },
      onTap: () {
        if (selectedMessages.isNotEmpty) {
          setState(() {
            if (message.isSelected) {
              selectedMessages.remove(message);
              message.isSelected = false;
            } else {
              selectedMessages.add(message);
              message.isSelected = true;
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: message.isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
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
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}
