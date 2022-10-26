import 'package:doc_doc_front/widgets/chat_widget.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;
  final String userAvatar;
  const ChatView(
      {Key? key,
      required this.peerNickname,
      required this.peerAvatar,
      required this.peerId,
      required this.userAvatar})
      : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Row(children: <Widget>[
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image.network(
              widget.peerAvatar,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext ctx, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    value: loadingProgress.expectedTotalBytes != null &&
                            loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, object, stackTrace) {
                return const Icon(
                  Icons.account_circle,
                  size: 35,
                  color: Colors.grey,
                );
              },
            ),
          ),
          const SizedBox(width: 10.0),
          Text(widget.peerNickname, style: const TextStyle(color: Colors.black))
        ]),
        elevation: 10.0,
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: const Color(0xFF00CEC9),
      body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ChatWidget(
            peerAvatar: widget.peerAvatar,
            peerId: widget.peerId,
            peerNickname: widget.peerNickname,
            userAvatar: widget.userAvatar,
          )),
    );
  }
}
