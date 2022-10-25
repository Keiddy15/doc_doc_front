import 'package:doc_doc_front/models/user_model.dart';
import 'package:doc_doc_front/utils/keyboard_utils.dart';
import 'package:doc_doc_front/widgets/form_user_widget.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: const Color(0xFF00CEC9),
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: const SizedBox.expand(
                child: Material(
                    color: Color(0xFF00CEC9),
                    child: SingleChildScrollView(child: FormUserWidget())))));
  }
}

Widget buildItem(BuildContext context, UserModel? userChat, currentUserId) {
  if (userChat != null) {
    if (userChat.id == currentUserId) {
      return const SizedBox.shrink();
    } else {
      return TextButton(
        onPressed: () {
          if (KeyboardUtils.isKeyboardShowing()) {
            KeyboardUtils.closeKeyboard(context);
          }
          /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatWidget(
                          peerId: userChat.id,
                          peerAvatar: userChat.photoUrl,
                          peerNickname: userChat.fullName,
                        )));*/
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
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null),
                        );
                      }
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return const Icon(Icons.account_circle, size: 50);
                    },
                  ),
                )
              : const Icon(
                  Icons.account_circle,
                  size: 50,
                ),
          title: Text(
            userChat.fullName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  } else {
    return const SizedBox.shrink();
  }
}

