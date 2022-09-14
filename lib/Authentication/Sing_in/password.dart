import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widgets/on-board_button.dart';

class PasswordScreen extends StatefulWidget {
  final String email;

  const PasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool validated = true;
  bool _hidePassword = true;
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  _showErrorSnack() {
    const snackBar = SnackBar(
        content: Text('Error Logging in please check phone or password'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _extractData(
    BuildContext context,
    String phoneController,
    String passwordControl,
  ) async {
    String email = phoneController.replaceAll(' ', "").replaceAll('+', '');

    String password = passwordControl;

    // await _logIn(context, email, password);

    //  print(value);
  }

  // Future<void> _logIn(
  //     BuildContext context,
  //     String email,
  //     String password,
  //     ) async {
  //   try {
  //     // gets session
  //     session = await NakamaClient.nakamaClient.authenticateEmail(
  //       create: false,
  //       email: email, // email,
  //       password: password, // password,
  //     );
  //     await NakamaAdmin().login(
  //       email: email,
  //       password: password,
  //     );
  //     // gets account details
  //     User.session = session;
  //     _account = await NakamaClient.nakamaClient.getAccount(session);
  //
  //   } catch (e) {
  //     context.loaderOverlay.hide();
  //     print(e);
  //     _showErrorSnack();
  //     context.loaderOverlay.hide();
  //   } finally {
  //     // setState(() {
  //     //   isLoading = true;
  //     // });
  //     if (User.session.token != null) {
  //       Navigator.push(
  //           context,
  //           PageTransition(
  //               child: Home(), type: PageTransitionType.rightToLeft));
  //       print(session);
  //       print(_account);
  //     }else{}
  //     // if (NakamaAdmin().isLoggedIn) {
  //     //   Navigator.push(
  //     //       context,
  //     //       PageTransition(
  //     //           child: Home(), type: PageTransitionType.rightToLeft));
  //     //   print(session);
  //     //   print(_account);
  //     // } else {}
  //   }
  // }

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
    return LoaderOverlay(
      overlayColor: Colors.black,
      overlayOpacity: 0.2,
      overlayWholeScreen: true,
      useDefaultLoading: false,
      overlayWidget: SpinKitFadingCircle(
        size: 100,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: index.isEven ? Colors.white : Colors.white,
                shape: BoxShape.circle),
          );
        },
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  // isLoading == true
                  //     ? Center(child: SpinKitFadingCircle(
                  //
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return DecoratedBox(
                  //       decoration: BoxDecoration(
                  //
                  //         color:  AppColors.blue,
                  //       ),
                  //     );
                  //   },
                  // ),)
                  //     :
                  Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenSize.height * 0.049),
                    const Text(
                      'Enter Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.049),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                      controller: passwordController,
                      obscureText: _hidePassword,
                      inputFormatters: [
                        FilteringTextInputFormatter((RegExp("[a-zA-Z0-9]")),
                            allow: true),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return 'please enter password';
                        } else if (value.length < 6) {
                          return 'password should be more than 6 characters';
                        } else if (value.length > 15) {
                          return "password must not be greater than 15 characters";
                        }

                        return null;
                      },
                      onChanged: (val) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: _hidePassword
                                ? const Icon(Icons.visibility_off,
                                    color: Colors.grey)
                                : const Icon(Icons.visibility,
                                    color: Colors.grey)),
                        hintText: '*******',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.019),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.049),
                    Visibility(
                      visible: (_formKey.currentState?.validate() ?? false),
                      child: OnBoardButton(
                        color: Colors.lightBlue,
                        label: 'Login',
                        onpressedfunction: () {
                          context.loaderOverlay.show();
                          // setState(() {
                          //   isLoading = true;
                          // });

                          _extractData(
                              context, widget.email, passwordController.text);

                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         child: Home(),
                          //         type: PageTransitionType.rightToLeft));
                        },
                      ),
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
