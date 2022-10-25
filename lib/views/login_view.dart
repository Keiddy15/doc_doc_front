import 'package:doc_doc_front/widgets/form_login_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Doc-Doc"),
          elevation: 0.0,
          backgroundColor: const Color(0xFF00CEC9),
          titleSpacing: 0.0,
        ),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox.expand(
                child: Material(
                    child: SingleChildScrollView(child: FormLoginWidget())))));
  }
}