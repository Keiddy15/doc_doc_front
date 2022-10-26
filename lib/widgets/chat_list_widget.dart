import 'package:doc_doc_front/models/user_model.dart';
import 'package:doc_doc_front/providers/user_provider.dart';
import 'package:doc_doc_front/utils/keyboard_utils.dart';
import 'package:doc_doc_front/views/chat_view.dart';
import 'package:doc_doc_front/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({Key? key}) : super(key: key);

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  late String? currentUserId;
  late String? userPhotoUrl;
  List<UserModel> users = [];

  Future<List<UserModel>> getAllUsers() async {
    var service = UserProvider();
    var response = await service.getAllUsers();
    setState(() {
      users = response;
    });
    return users;
  }

  Future getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('currentUserId');
      userPhotoUrl = prefs.getString('userPhotoUrl');
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Material(
            color: const Color(0xFF00CEC9),
            child: Stack(
              children: [
                Column(children: [
                  Image.asset('assets/contactList.png'),
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (context, index) =>
                              buildItem(context, users[index], currentUserId, userPhotoUrl),
                          controller: scrollController)),
                ]),
                Positioned(
                  child: isLoading
                      ? const LoadingWidget()
                      : const SizedBox.shrink(),
                ),
              ],
            )));
  }
}

Widget buildItem(BuildContext context, UserModel? userChat, currentUserId, userPhotoUrl) {
  if (userChat != null) {
    if (userChat.id.toString() == currentUserId.toString()) {
      return const SizedBox.shrink();
    } else {
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          padding: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 15.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              if (KeyboardUtils.isKeyboardShowing()) {
                KeyboardUtils.closeKeyboard(context);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatView(
                            peerId: userChat.id.toString(),
                            peerAvatar: userChat.photoUrl,
                            peerNickname: userChat.fullName,
                            userAvatar: userPhotoUrl ?? "",
                          )));
            },
            child: ListTile(
                leading: userChat.photoUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          userChat.photoUrl,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                    color: Colors.grey,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null),
                              );
                            }
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(Icons.account_circle, size: 60);
                          },
                        ),
                      )
                    : const Icon(Icons.account_circle,
                        size: 45, color: Color(0xFF007B78)
                        // color: Colors.white
                        ),
                title: Text(
                  userChat.fullName,
                  style: const TextStyle(color: Colors.black),
                ),
                subtitle: const Text("Message")),
          ));
    }
  } else {
    return const SizedBox.shrink();
  }
}
