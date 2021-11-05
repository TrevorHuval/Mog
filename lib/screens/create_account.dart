import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  FirebaseAuth auth = FirebaseAuth.instance;

  String email = "";
  String password = "";

  void signUpAction() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static const userSex = <String>[
    'Male',
    'Female',
  ];

  void _setSexSelection(String selectedSex) {
    Navigator.pop(context);
    setState(() {
      sex = selectedSex;
    });
  }

  final List<DropdownMenuItem<String>> _dropDownMenuItems = userSex
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String? _firstName;
  String? _lastName;
  //String? _email;
  //String? _password;
  String sex = "Select your sex";
  String? _weight;
  String? _height;

  String? _validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return 'Name is required.';
    }
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value!)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                          height: 25,
                          width: 25,
                          child: Icon(Icons.arrow_back_ios_new_rounded)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Create Account",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                        Text("Please fill out all of the information",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.5)),
                      ],
                    ),
                    const SizedBox(width: 25)
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 500,
                    width: 500,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "First Name:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: TextField(
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.red),
                                maxLines: 1,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Enter your first name'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Last Name:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: TextField(
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.red),
                                maxLines: 1,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Enter your last name'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Email:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                textAlign: TextAlign.end,
                                style: const TextStyle(color: Colors.red),
                                maxLines: 1,
                                decoration: const InputDecoration.collapsed(
                                    hintText: 'Enter your email'),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Password:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: PasswordField(
                                fieldKey: _passwordFieldKey,
                                onFieldSubmitted: (String value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Re-type password",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                enabled: password.isNotEmpty,
                                textAlign: TextAlign.end,
                                decoration: const InputDecoration.collapsed(
                                  hintText: "Re-type password",
                                ),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Sex:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            GestureDetector(
                              child: Text(sex,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade700)),
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          )),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading:
                                                const Icon(Icons.male_rounded),
                                            title: const Text("Male"),
                                            onTap: () =>
                                                _setSexSelection('Male'),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                                Icons.female_rounded),
                                            title: const Text("Female"),
                                            onTap: () =>
                                                _setSexSelection('Female'),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Weight:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(color: Colors.red),
                                    maxLines: 1,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(3)
                                    ],
                                    decoration: const InputDecoration.collapsed(
                                        hintText: '135'),
                                  ),
                                ),
                                const Text(" lbs",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                            child: const Text("Create Account",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () async => {signUpAction()})
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      textAlign: TextAlign.end,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: const InputDecoration.collapsed(
        //filled: true,

        border: InputBorder.none,
        hintText: "Create your password",
        //suffixIcon: GestureDetector(
        //  onTap: () {
        //    setState(() {
        //      _obscureText = !_obscureText;
        //    });
        //  },
        //  child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        //),
      ),
    );
  }
}
