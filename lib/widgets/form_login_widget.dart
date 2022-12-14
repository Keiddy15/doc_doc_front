import 'dart:convert';
import 'package:doc_doc_front/app.dart';
import 'package:doc_doc_front/providers/auth_provider.dart';
import 'package:doc_doc_front/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({Key? key}) : super(key: key);

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isObscure = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildEmail() {
    return TextFormField(
      controller: email,
      decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E293B)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E293B)),
          ),
          icon:
              const FaIcon(FontAwesomeIcons.envelope, color: Color(0xFF007B78)),
          errorStyle:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      cursorColor: const Color(0xFF000113),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      style: const TextStyle(color: Color(0xFF000113)),
      validator: (value) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);
        if (value.isEmpty || !emailValid) {
          return 'Email must be valid';
        }
        return null;
      },
    );
  }

  Widget buildPassword() {
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1E293B)),
        ),
        icon: const FaIcon(FontAwesomeIcons.lock, color: Color(0xFF007B78)),
        isDense: true,
        filled: true,
        hintText: "Password",
        fillColor: Colors.white,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1E293B)),
        ),
        errorStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      cursorColor: const Color(0xFF000113),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      style: const TextStyle(color: Color(0xFF000113)),
      obscureText: _isObscure,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Future login() async {
    var service = AuthProvider();
    var login = await service.login(email.text, password.text);
    if (login.statusCode == 200) {
      final response = json.decode(login.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['token']);
    }
    return login;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Image.asset("assets/userDoctor.png"),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(children: <Widget>[
                  const Text("Login",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none)),
                  const SizedBox(height: 50.0),
                  buildEmail(),
                  const SizedBox(height: 30.0),
                  buildPassword(),
                  Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color(0xFF00C6C1),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login().then((value) {
                              final response = json.decode(value.body);
                              if (value.statusCode == 200) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>  MyApp()),
                                    (Route<dynamic> route) => false);
                              } else {
                                Flushbar(
                                  message: response['message'],
                                  icon: const Icon(
                                    FontAwesomeIcons.circleExclamation,
                                    size: 28.0,
                                    color: Color(0xFFF42413),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  leftBarIndicatorColor:
                                      const Color(0xFFF42413),
                                  messageColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  margin: const EdgeInsets.all(20.0),
                                ).show(context);
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C6C1),
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text("Login",
                            style: TextStyle(color: Colors.white)),
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                              fullscreenDialog: true));
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                          color: Color(0xFF007B78),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]))
          ],
        ));
  }
}
