import 'package:developscreens/messenger/individual_page.dart';
import 'package:developscreens/messenger/message_provider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:developscreens/messenger/models/chatmodel.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:developscreens/screens/welcome_to_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePa extends StatefulWidget {
  const HomePa({Key? key}) : super(key: key);

  @override
  State<HomePa> createState() => _HomePaState();
}

class _HomePaState extends State<HomePa> {
  final ChatProvider chatProvider = ChatProvider();
  bool isSearching = false;
  List<ChatModel> filteredChatModels = [];
  bool isEditMode = false;
  Set<int> selectedChatIds = {};

  @override
  void initState() {
    super.initState();
    filteredChatModels = chatProvider.chatModels;
  }

  void updateChatModel(ChatModel updatedChatModel) {
    setState(() {
      // Find the index of the updated chat model in filteredChatModels
      int index = filteredChatModels
          .indexWhere((model) => model.id == updatedChatModel.id);

      if (index != -1) {
        // Remove the old chat model
        filteredChatModels.removeAt(index);

        // Insert the updated chat model at the top
        filteredChatModels.insert(0, updatedChatModel);
      } else {
        // If the chat model is not found, it is a new chat
        // Insert the updated chat model at the top
        filteredChatModels.insert(0, updatedChatModel);
      }
    });
  }

  void updateFilteredChatModels(String query) {
    setState(() {
      filteredChatModels = chatProvider.chatModels
          .where((chatModel) =>
              chatModel.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      filteredChatModels.sort((a, b) {
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

  Future<void> _selectContact(BuildContext context) async {
    final Contact? contact = await ContactsService.openDeviceContactPicker();
    if (contact != null) {
      bool isGroup = false;

      String icon;
      if (isGroup) {
      } else {
        if (contact.avatar != null && contact.avatar!.isNotEmpty) {
          // Use contact's avatar as icon
          icon = 'assets/person.png';
        } else {
          // Use fallback image for individual chat
          icon = 'assets/person.png';
        }
      }

      ChatModel newChatModel = ChatModel(
        id: filteredChatModels.length + 1,
        name: contact.displayName ?? '',
        isGroup: isGroup,
        messages: [],
        icon: icon,
      );

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
  }

  void toggleEditMode(bool value) {
    setState(() {
      isEditMode = value;
      if (!isEditMode) {
        // Clear selected chat IDs when exiting delete mode
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
    });
  }

  void deleteSelectedChats() {
    setState(() {
      chatProvider.chatModels
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
              itemCount: filteredChatModels.length,
              itemBuilder: (context, index) => InkWell(
                onLongPress: () {
                  // Enable delete mode
                  toggleEditMode(true);
                  // Select the current chat
                  selectChat(filteredChatModels[index].id);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndividualPage(
                        chatModel: filteredChatModels[index],
                        updateChatModel: updateChatModel,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    buildListTile(filteredChatModels[index]),
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectContact(context);
        },
        elevation: 0,
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
              icon: Icon(Icons.arrow_back),
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
            icon: Icon(Icons.delete),
            onPressed: selectedChatIds.isNotEmpty ? deleteSelectedChats : null,
          ),
        isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    filteredChatModels = chatProvider.chatModels;
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
              position: RelativeRect.fromLTRB(0, 0, 0, 0),
              items: [
                PopupMenuItem(
                  child: Text("Logout"),
                  value: "logout",
                ),
              ],
            ).then((selectedValue) {
              if (selectedValue == "logout") {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                authProvider.logoutUser(context);
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
