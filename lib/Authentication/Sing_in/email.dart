import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map/Authentication/Sing_in/password.dart';

import 'package:page_transition/page_transition.dart';
import '../../widgets/on-board_button.dart';
import '../Singup/sing_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool validated = true;
  late String email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //late String email;

  TextEditingController emailController = TextEditingController();
  bool isPassValidated = true;

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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.049),
                  const Text(
                    'Enter your Email',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.049),
                  Container(
                    decoration: const BoxDecoration(),
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        onChanged: (val) {
                          //email = val;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.lightBlue),
                          hintText: 'username@email.com',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        validator: (value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern.toString());
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!regex.hasMatch(value)) {
                            return 'Enter Valid Email';
                          }

                          return null;
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text('Not registered yet?'),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Sing Up',
                          style: TextStyle(color: Colors.lightBlue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.049),
                  Visibility(
                    visible: (_formKey.currentState?.validate() ?? false),
                    child: OnBoardButton(
                        color: Colors.lightBlue,
                        label: 'Next',
                        onpressedfunction: () {
                          email = emailController.text;
                          if (!_formKey.currentState!.validate()) return;
                          debugPrint(email);

                          Navigator.push(
                              context,
                              PageTransition(
                                  child: PasswordScreen(
                                    email: email,
                                  ),
                                  type: PageTransitionType.leftToRight));
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
