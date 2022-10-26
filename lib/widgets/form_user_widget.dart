import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:doc_doc_front/models/user_model.dart';
import 'package:doc_doc_front/providers/user_provider.dart';
import 'package:doc_doc_front/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormUserWidget extends StatefulWidget {
  const FormUserWidget({Key? key}) : super(key: key);

  @override
  State<FormUserWidget> createState() => _FormUserWidgetState();
}

class _FormUserWidgetState extends State<FormUserWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController age = TextEditingController();

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
              padding: EdgeInsets.only(right: 10.0),
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
              padding: EdgeInsets.only(right: 20.0),
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
          enabled: false,
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
    );
  }

  Future getUserByToken() async {
    var service = UserProvider();
    var response = await service.getUserByToken();
    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      var user = UserModel.fromJson(jsonDecode['user']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('currentUserId', user.id.toString());
      prefs.setString('userPhotoUrl', user.photoUrl.toString());
      email.text = user.email;
      fullName.text = user.fullName;
      age.text = user.age.toString();
    }
  }

  Future updateUser() async {
    var service = UserProvider();
    var response =
        await service.updateUser(fullName.text, email.text, age.text);
    return response;
  }

  @override
  void initState() {
    super.initState();
    getUserByToken();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Image.asset("assets/girlDoctor.png"),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(children: <Widget>[
                  const SizedBox(height: 50.0),
                  buildFullName(),
                  const SizedBox(height: 20.0),
                  buildEmail(),
                  const SizedBox(height: 20.0),
                  buildAge(),
                  const SizedBox(height: 23.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateUser().then((value) {
                              final response = json.decode(value.body);
                              if (value.statusCode == 200) {
                                Flushbar(
                                  message: 'User updated',
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
                          backgroundColor: Colors.white,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text("Save",
                            style: TextStyle(color: Color(0xFF007B78)))),
                  ),
                  const SizedBox(height: 23.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('token');
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()),
                                  (Route<dynamic> route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text("Log Out",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              FaIcon(FontAwesomeIcons.arrowRightFromBracket,
                                  color: Colors.red)
                            ])),
                  ),
                ]))
          ],
        ));
  }
}
