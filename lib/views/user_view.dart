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