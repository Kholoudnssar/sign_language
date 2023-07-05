import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sign_language_app/constants.dart';
import 'package:sign_language_app/datdbase/database_utils.dart';
import 'package:sign_language_app/models/My_User.dart';
import 'package:sign_language_app/screens/navscreens/homepage.dart';
import 'package:sign_language_app/screens/navscreens/navbar.dart';
import 'package:sign_language_app/widgets/custom_button.dart';
import 'package:sign_language_app/widgets/custom_text_field.dart';

import 'helper/show_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? fname;
  String? userName;
  String? email;
  String? password;
  String? image;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 241),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.05,
                ),
                Image.asset(
                  'assets/images/logo1.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SignBridge',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color.fromARGB(255, 120, 172, 182),
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                 height:MediaQuery.of(context).size.height*0.05,
                ),
                Row(
                  children: [
                    Text(
                      'REGISTER',
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
                    fname = data;
                  },
                  hintText: 'First name',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    userName = data;
                  },
                  hintText: 'User Name',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                //////////////////////////////////////
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                CustomButon(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, MyHome.roudeName);
                        // Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, 'weak password');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context, 'email already exists');
                        }
                      } catch (ex) {
                        showSnackBar(context, 'there was an error');
                      }

                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'REGISTER',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Login',
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

  Future<void> registerUser() async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    User_Data user = User_Data(
        id: credential.user!.uid,
        fName: fname!,
        image:image?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        userName: userName!,
        email: email!);
    DataBase.creatDBforUser(user);
  }
}


