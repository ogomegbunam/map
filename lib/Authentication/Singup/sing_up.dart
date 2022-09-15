import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:map/home_page.dart';
import 'package:map/services/firebase_services.dart';
import 'package:page_transition/page_transition.dart';

import '../../Utils/snackbar.dart';
import '../../widgets/on-board_button.dart';
import '../Sing_in/password.dart';

class SignUp extends StatefulWidget {
  bool loggedOut;

  SignUp({Key? key, this.loggedOut = false}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool passVisibility = true;
  bool validated = true;


  validateInput() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        validated = true;
      });
    } else {
      setState(() {
        validated = false;
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _Signup({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final signup = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (signup.user != null) {
        context.loaderOverlay.hide();
        Navigator.push(
            context,
            PageTransition(
                child: HomePage(), type: PageTransitionType.leftToRight));
      }
    } on FirebaseAuthException catch (e) {
      context.loaderOverlay.hide();

      if (e.code == 'weak-password') {
        ShowSnackBar(context, e.message!);

        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        ShowSnackBar(context, e.message!);
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {}
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (widget.loggedOut) {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text('You have been logged out.'),
    //     ));
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'SIGN UP',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Text(
                        'Sign up with your email and password. If you are having difficulty signing up, please contact your administrator.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                          cursorColor: Colors.grey,
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern.toString());
                            if (value!.isEmpty) {
                              return 'Please enter an email';
                            } else if (!regex.hasMatch(value)) {
                              return 'Enter Valid Email';
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            prefixIcon: Icon(FontAwesomeIcons.envelope),
                            prefixIconColor: Colors.grey,
                            focusColor: null,
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 12),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                          cursorColor: Colors.grey,
                          obscureText: passVisibility,
                          onChanged: (val) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 8) {
                              return 'Password should be at least 8 characters';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            prefixIcon: const Icon(FontAwesomeIcons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passVisibility = !passVisibility;
                                  });
                                },
                                icon: passVisibility
                                    ? const Icon(Icons.visibility_off,
                                        color: Colors.grey)
                                    : const Icon(Icons.visibility,
                                        color: Colors.grey)),
                            prefixIconColor: Colors.grey,
                            focusColor: null,
                            hintText: 'Password',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OnBoardButton(
                      label: 'Sign up',
                      onpressedfunction:
                          _formKey.currentState?.validate() == true
                              ? () {
                                  context.loaderOverlay.show();
                                  _Signup(
                                      emailAddress: emailController.text,
                                      password: passwordController.text);
                                }
                              : () {
                                  null;
                                },
                      color: _formKey.currentState?.validate() == true
                          ? const Color(0xFF429BED)
                          : Colors.grey.shade400,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
