import 'dart:math';
import 'package:developscreens/messenger/profile_page.dart';

import 'package:developscreens/messenger/individual_page.dart';

import 'package:developscreens/messenger/models/chatmodel.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:developscreens/socket_service.dart';

class HomePa extends StatefulWidget {
  final String token;
  final String userId;
  const HomePa({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<HomePa> createState() => _HomePaState();
}

class _HomePaState extends State<HomePa> {
  final SocketService chatProvider = SocketService();

  bool isSearching = false;
  List<ChatModel> filteredChatModelss = [];
  bool isEditMode = false;
  Set<int> selectedChatIds = {};

  bool isBottomSheetOpen = false;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.selectContact();
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.connect(widget.token);
    socketService.addListener(() {
      setState(() {
        filteredChatModelss = socketService.filteredChatModels;
      });
    });
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.removeListener(() {
      setState(() {
        filteredChatModelss = socketService.filteredChatModels;
      });
    });
    super.dispose();
  }

  void bottomsheetdata(BuildContext context) {
    isBottomSheetOpen = true;
    final authProvider1 = Provider.of<AuthProvider>(context, listen: false);
    List<dynamic> datalist = authProvider1.data;
    showModalBottomSheet<void>(
      enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.sizeOf(context).height*0.95,
          child: ListView.builder(
            itemCount: datalist.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> contactData = datalist[index];
              final String contactName =
                  contactData['first_name'] ?? contactData['phone_no'].toString();
              final String idm = contactData["_id"];
              final String lastname = contactData['last_name'] ?? " ";
              String imageurl = contactData['profile_pic'] ??
                  'https://loremflickr.com/320/240?random=$index';
              return Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1)),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                    child: CircleAvatar(
                        radius: 35, backgroundImage: NetworkImage(imageurl)),
                  ),
                  title: Text(contactName + " " + lastname),
                  subtitle: Text(contactData['email']),
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                    Future.microtask(() {
                      String icon = imageurl;
                      int maxId = filteredChatModelss.isNotEmpty
                          ? filteredChatModelss
                              .map((chatModel) => chatModel.id)
                              .reduce(max)
                          : 0;
                      ChatModel newChatModel = ChatModel(
                        id: maxId + 1,
                        personID: idm,
                        name: contactName,
                        lastname: contactData['last_name'] ?? " ",
                        messages: [],
                        icon: icon,
                      );

                      final existingChatIndex = filteredChatModelss.indexWhere(
                          (chatModel) =>
                              chatModel.personID == newChatModel.personID);

                      if (existingChatIndex != -1) {
                        ChatModel existingChatModel =
                            filteredChatModelss[existingChatIndex];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndividualPage(
                              chatModel: existingChatModel,
                              updateChatModel: updateChatModel,
                            ),
                          ),
                        );
                      } else {
                        updateChatModel(newChatModel);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndividualPage(
                              chatModel: newChatModel,
                              updateChatModel: updateChatModel,
                            ),
                          ),
                        );
                      }
                    });
                  },
                ),
              );
            },
          ),
        );
      },
    ).whenComplete(() {
      isBottomSheetOpen = false;
    });
  }
  void updateChatModel(ChatModel updatedChatModel) {
    setState(() {
      int index = filteredChatModelss
          .indexWhere((model) => model.id == updatedChatModel.id);
      if (index != -1) {
        filteredChatModelss.removeAt(index);
        filteredChatModelss.insert(0, updatedChatModel);
      } else {
        filteredChatModelss.insert(0, updatedChatModel);
      }
    });
  }


  void updateFilteredChatModels(String query) {
    setState(() {
      filteredChatModelss = chatProvider.filteredChatModels
          .where((chatModel) =>
              chatModel.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      filteredChatModelss.sort((a, b) {
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
    });
  }

  void toggleEditMode(bool value) {
    setState(() {
      isEditMode = value;
      if (!isEditMode) {

        selectedChatIds.clear();
      }
    });
  }

  void selectChat(int chatId) {
    setState(() {
      if (selectedChatIds.contains(chatId)) {
        selectedChatIds.remove(chatId);
      } else {
        selectedChatIds.add(chatId);
      }
      if (selectedChatIds.isEmpty) {
        toggleEditMode(false);
      }
    });
  }

  void deleteSelectedChats() {
    setState(() {
      chatProvider.filteredChatModels
          .removeWhere((chat) => selectedChatIds.contains(chat.id));
      selectedChatIds.clear();

      isEditMode = false;
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
            child: ListView.separated(
              itemCount: filteredChatModelss.length,
              itemBuilder: (context, index) => InkWell(
                onLongPress: () {
                  // Enable delete mode
                  toggleEditMode(true);
                  // Select the current chat
                  selectChat(filteredChatModelss[index].id);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndividualPage(
                        chatModel: filteredChatModelss[index],
                        updateChatModel: updateChatModel,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    buildListTile(filteredChatModelss[index]),
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 4,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!isBottomSheetOpen) {
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            if (authProvider.data.isNotEmpty) {
              bottomsheetdata(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text("either no connections or wait to load connection"),
                  duration: Duration(seconds: 1),
                  backgroundColor: Color(0xc3f55a50),
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 80),
                  showCloseIcon: true,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        elevation: 1,
        splashColor: Colors.amberAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListTile buildListTile(ChatModel chatModel) {
    final bool isSelected = selectedChatIds.contains(chatModel.id);
    final Color tileColor =
        isSelected ? Colors.blue.withOpacity(0.3) : Colors.white;

    return ListTile(
      tileColor: tileColor,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(chatModel.icon),
      ),
      title: Text(
        "${chatModel.name} ${chatModel.lastname}",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          const SizedBox(
              height: 30,
              child: Icon(
                Icons.done_all,
                size: 18,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            child: Container(
              height: 30,
              padding: const EdgeInsets.all(5),
              child: Text(
                chatModel.messages.isNotEmpty
                    ? chatModel.messages.last.text.trim()
                    : "No messages",
                style: const TextStyle(
                    fontSize: 13, overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
        child: Text(
          chatModel.latestMessageTime != null
              ? DateFormat('hh:mm a').format(chatModel.latestMessageTime!)
              : "",
        ),
      ),
      onTap: () {
        if (!isEditMode) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndividualPage(
                chatModel: chatModel,
                updateChatModel: updateChatModel,
              ),
            ),
          );
        } else {
          selectChat(chatModel.id);
        }
      },
      onLongPress: () {
        if (!isEditMode) {
          setState(() {
            isEditMode = true;
            selectChat(chatModel.id);
          });
        }
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: isEditMode
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                toggleEditMode(false);
              },
            )
          : null,
      title: isSearching
          ? TextField(
              onChanged: (value) {
                updateFilteredChatModels(value);
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search here",
                border: InputBorder.none,
              ),
            )
          : Row(
              children: [
                SizedBox(
                  height: 30,
                  child: Image.asset("assets/logo.png"),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Chats",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
      actions: [
        if (isEditMode)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: selectedChatIds.isNotEmpty ? deleteSelectedChats : null,
          ),
        isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    filteredChatModelss = chatProvider.filteredChatModels;
                  });
                },
                icon: const Icon(Icons.cancel),
                color: Colors.black,
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        IconButton(
          onPressed: () {
            showMenu(
              context: context,
              position: const RelativeRect.fromLTRB(20, 10, 5, 20),
              items: [
                const PopupMenuItem(
                  value: "myprofile",
                  child: Text("Profile"),
                ),
                const PopupMenuItem(
                  value: "logout",
                  child: Text("Logout"),
                ),
              ],
            ).then((selectedValue) {
              if (selectedValue == "myprofile") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile_page()));
              }
              if (selectedValue == "logout") {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.logoutUser(context);
                final socketService =
                    Provider.of<SocketService>(context, listen: false);
                socketService.disconnect();
              }
            });
          },
          icon: const Icon(Icons.more_vert),
          color: Colors.black,
        ),
      ],
      elevation: 0,
    );
  }
}
