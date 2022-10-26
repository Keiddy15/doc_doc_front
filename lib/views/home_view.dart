import 'package:doc_doc_front/views/login_view.dart';
import 'package:doc_doc_front/views/register_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeBody());
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Widget authButtons(text) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(children: <Widget>[
          SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  if (text == "Login") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView(),
                            fullscreenDialog: true));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterView(),
                            fullscreenDialog: true));
                  }
                },
                child: Text(text, style: const TextStyle(color: Colors.black)),
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00CEC9),
      extendBody: true,
      body: Column(children: <Widget>[
        const SizedBox(height: 80),
        Align(
            alignment: Alignment.center,
            child: Column(children: const <Widget>[
              Text("Get Started",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Meet your doctor",
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            ])),
        const SizedBox(height: 40),
        Center(
          child: Image.asset(
            "assets/doctorImage.png",
            width: 529,
          ),
        ),
        const SizedBox(height: 50),
        authButtons("Login"),
        const SizedBox(height: 20),
        authButtons("Register")
      ]),
    );
  }
}
