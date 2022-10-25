import 'package:doc_doc_front/widgets/form_login_widget.dart';
import 'package:doc_doc_front/widgets/form_register_widget.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
            child: const SizedBox.expand(
                child: Material(
                    child: SingleChildScrollView(child: FormRegisterWidget())))));
  }
}