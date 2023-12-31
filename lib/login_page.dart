import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sign_language_app/resgister_page.dart';
import 'package:sign_language_app/screens/navscreens/homepage.dart';
import 'package:sign_language_app/screens/navscreens/navbar.dart';
import 'package:sign_language_app/user_provider.dart';
import 'package:sign_language_app/widgets/custom_button.dart';
import 'package:sign_language_app/widgets/custom_text_field.dart';
import 'package:sign_language_app/widgets/resetPassword.dart';

import 'constants.dart';
import 'datdbase/database_utils.dart';
import 'helper/show_snack_bar.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'login page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:Color.fromARGB(255, 254, 253, 241),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Image.asset(
                  'assets/images/logo1.png',
                  height: MediaQuery.of(context).size.height*0.14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SignBridge',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 120, 172, 182),
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 28,
                        color: Color.fromARGB(255, 85, 133, 145),
                      ),
                    ),
                  ],
                ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.01,
            ),
                CustomFormTextField(

                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 15,
                ),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButon(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, MyHome.roudeName);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(context, 'user not found');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context, 'wrong password');
                        }
                      } catch (ex) {
                        print(ex);
                        showSnackBar(context, '$ex');
                      }

                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',

                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont\'t have an account?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                        '  Register',
                        style: TextStyle(
                          color:  Color.fromARGB(255, 120, 172, 182),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ResetPassword.id);
                      },
                      child: Text(
                        '  reset',
                        style: TextStyle(
                          color:  Color.fromARGB(255, 120, 172, 182),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);

  }



}
