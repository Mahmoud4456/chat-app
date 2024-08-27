import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e1/screens/chat_screen.dart';
import 'package:firebase_e1/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snack_bar.dart';
import 'components/constants.dart';
import 'components/custom_bottom.dart';
import 'components/form_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static String id = "Login Screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Image.asset("assets/images/scholar.png"),
                const Text(
                  "Scholar Chat",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: "Pacifico"),
                ),
                const Spacer(
                  flex: 2,
                ),
                const Row(
                  children: [
                    Text(
                      "LOGIN",
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
                  onChange: (data) {
                    email = data;
                  },
                  label: "Email",
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
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          Navigator.pushNamed(context, ChatScreen.id , arguments:email );
                        } on FirebaseAuthException catch (e) {
                          print("Error =>>> ${e.code}");
                          if (e.code == "invalid-credential") {
                            // the Api response is changed in User check for not leaking information you can disable it in firebase console
                            print('No user found for that email.-----------');
                            snackbarMassege(
                                context, "No user found for that email.");
                          } else if (e.code == "wrong-password") {
                            print(
                                'Wrong password provided for that user.---------');
                            snackbarMassege(context,
                                "Wrong password provided for that user",
                                background: Colors.red);
                          }
                        } catch (e) {
                          snackbarMassege(context, "error !!");
                          print("Error =>  $e");
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    text: "LOGIN"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "donot have an account",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: const Text(
                        "REGISTER",
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    print(user.user!.displayName);
  }
}
