import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import 'chat_screen.dart';
import 'components/custom_bottom.dart';
import 'components/form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(height: 100, "assets/images/scholar.png"),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scholar Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: "Pacifico"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                FormItem(
                  label: "Email",
                  onChange: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                FormItem(
                  opscure: true,
                  onChange: (data) {
                    password = data;
                  },
                  label: "Password",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBottom(
                  text: "REGISTER",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await register();
                        Navigator.pushNamed(context, ChatScreen.id , arguments:email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "email-already-in-use") {
                          snackbarMassege(context, "this email already used");
                        } else if (e.code == "weak-password") {
                          snackbarMassege(context, "weak password",
                              background: Colors.red);
                        }
                      } catch (e) {
                        snackbarMassege(context, "error !!");
                      }
                      isLoading = false;
                      setState(() {

                      });
                    } else {}
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "already have an account",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "SinUP",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
    print(user.user!.displayName);
  }
}
