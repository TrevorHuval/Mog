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

  static const userSex = <String>[
    'Male',
    'Female',
  ];
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
  String? _email;
  String? _password;
  String sex = "Select your sex";
  String? _weight;
  String? _height;

  int _currentWeightValue = 60;
  int _currentHeightValue = 60;

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
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(width: 20),
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
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 500,
                    width: 500,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
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
                          children: const [
                            Text(
                              "Email:",
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
                                    hintText: 'Enter your email'),
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
                                    this._password = value;
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
                                enabled: this._password != null &&
                                    this._password!.isNotEmpty,
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      SimpleDialog(
                                    title: const Text('Select your sex'),
                                    children: [
                                      ListTile(
                                        title: const Text('Male'),
                                        onTap: () =>
                                            Navigator.pop(context, 'Male'),
                                      ),
                                      ListTile(
                                        title: const Text('Female'),
                                        onTap: () =>
                                            Navigator.pop(context, 'Female'),
                                      ),
                                    ],
                                  ),
                                ).then((returnVal) {
                                  if (returnVal != null) {
                                    setState(() {
                                      sex = returnVal;
                                    });
                                  }
                                });
                                ;
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
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      textAlign: TextAlign.end,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration.collapsed(
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
