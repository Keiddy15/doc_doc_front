import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:doc_doc_front/providers/auth_provider.dart';
import 'package:doc_doc_front/views/login_view.dart';
import 'package:doc_doc_front/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({Key? key}) : super(key: key);

  @override
  State<FormRegisterWidget> createState() => _FormRegisterWidgetState();
}

class _FormRegisterWidgetState extends State<FormRegisterWidget> {
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController age = TextEditingController();
  bool _isObscure = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildFullName() {
    return TextFormField(
      controller: fullName,
      decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E293B)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E293B)),
          ),
          icon: const Padding(
              padding: EdgeInsets.only(right: 4.0),
              child:
                  FaIcon(FontAwesomeIcons.signature, color: Color(0xFF007B78))),
          errorStyle:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      cursorColor: const Color(0xFF000113),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      style: const TextStyle(color: Color(0xFF000113)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget buildAge() {
    return TextFormField(
      controller: age,
      onTap: () {
        showMaterialNumberPicker(
          context: context,
          buttonTextColor: const Color(0xFF007B78),
          title: 'Pick Your Age',
          maxNumber: 100,
          maxLongSide: 400.0,
          headerColor: const Color(0xFF007B78),
          minNumber: 14,
          onChanged: (value) => setState(() => age.text = value.toString()),
        );
      },
      decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "Age",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E293B)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E293B)),
          ),
          icon: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: FaIcon(FontAwesomeIcons.child, color: Color(0xFF007B78))),
          errorStyle:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      cursorColor: const Color(0xFF000113),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      style: const TextStyle(color: Color(0xFF000113)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

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
          icon: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child:
                  FaIcon(FontAwesomeIcons.envelope, color: Color(0xFF007B78))),
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
        icon: const Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: FaIcon(FontAwesomeIcons.lock, color: Color(0xFF007B78))),
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

  Widget buildConfirmPassword() {
    return TextFormField(
      controller: confirmPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1E293B)),
        ),
        icon: const Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: FaIcon(FontAwesomeIcons.lock, color: Color(0xFF007B78))),
        isDense: true,
        filled: true,
        hintText: "Confirm Password",
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
        if (value!.isEmpty || value != password.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Future register() async {
    var service = AuthProvider();
    var response = await service.register(
        email.text, password.text, age.text, fullName.text);
    return response;
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
                  const Text("Register",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none)),
                  const SizedBox(height: 40.0),
                  buildFullName(),
                  const SizedBox(height: 20.0),
                  buildAge(),
                  const SizedBox(height: 20.0),
                  buildEmail(),
                  const SizedBox(height: 20.0),
                  buildPassword(),
                  const SizedBox(height: 20.0),
                  buildConfirmPassword(),
                  const SizedBox(height: 20.0),
                  SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            register().then((value) {
                              final response = json.decode(value.body);
                              if (value.statusCode == 200) {
                                Flushbar(
                                  message:
                                      'Register successfully, please check your email',
                                  icon: const Icon(
                                    FontAwesomeIcons.circleCheck,
                                    size: 28.0,
                                    color: Color(0xFF007B78),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  leftBarIndicatorColor:
                                      const Color(0xFF007B78),
                                  messageColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  margin: const EdgeInsets.all(20.0),
                                ).show(context);
                                Timer(const Duration(seconds: 8), () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginView()),
                                      (Route<dynamic> route) => false);
                                });
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
                        child: const Text("Register",
                            style: TextStyle(color: Colors.white)),
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView(),
                              fullscreenDialog: true));
                    },
                    child: const Text(
                      "Already have an account? Login",
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
