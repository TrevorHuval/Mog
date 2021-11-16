import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  bool createAccountButtonActive = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(
      () {
        final isButtonActive = controller.text.isNotEmpty;

        setState(() => this.createAccountButtonActive = isButtonActive);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  FirebaseAuth auth = FirebaseAuth.instance;

  String? email;
  String? password;
  String? retypedPassword;
  String? firstName;
  String? lastName;
  String? weight;
  String? feet;
  String? inches;
  String errorMessage = "";
  File? profileImage;
  final picker = ImagePicker();

  bool firstNameEmpty = true;
  bool lastNameEmpty = true;
  bool emailEmpty = true;
  bool passwordEmpty = true;
  bool retypedPasswordEmpty = true;
  bool sexEmpty = true;
  bool weightEmpty = true;
  bool feetEmpty = true;
  bool inchesEmpty = true;

  final heightsInFeet = [' ', '3', '4', '5', '6', '7'];
  int indexFeet = 0;

  final heightsInInches = [
    ' ',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11'
  ];
  int indexInches = 0;

  static const userSex = <String>[
    'Male',
    'Female',
  ];

  void _checkAllFieldsEmpty() {
    setState(() => errorMessage = "");

    if (firstNameEmpty == false &&
        lastNameEmpty == false &&
        emailEmpty == false &&
        passwordEmpty == false &&
        retypedPasswordEmpty == false &&
        sexEmpty == false &&
        weightEmpty == false &&
        feetEmpty == false &&
        inchesEmpty == false) {
      if (password != retypedPassword) {
        errorMessage = "Passwords do not match";
        setState(() => this.createAccountButtonActive = false);
        return;
      }
      print("createAccountButton should be true");
      setState(() => this.createAccountButtonActive = true);
      return;
    }
    print("createAccountButton should be false");

    setState(() => this.createAccountButtonActive = false);
    return;
  }

  void _setSexSelection(String selectedSex) {
    Navigator.pop(context);
    setState(() {
      sex = selectedSex;
      if (sex != null && sex != "") {
        sexEmpty = false;
        _checkAllFieldsEmpty();
      }
    });
  }

  Future getImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        profileImage = File(PickedFile.path);
      }
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
  String sex = "Select your sex";

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

  Widget buildPickerFeet() => Container(
      width: 75,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75),
        child: CupertinoPicker(
          looping: false,
          itemExtent: 64,
          children: heightsInFeet
              .map((item) => Center(
                    child:
                        Text(item.toString(), style: TextStyle(fontSize: 20)),
                  ))
              .toList(),
          onSelectedItemChanged: (index) {
            setState(() => this.indexFeet = index);

            feet = heightsInFeet[index];
            if (index != 0) {
              feetEmpty = false;
              _checkAllFieldsEmpty();
            }
          },
        ),
      ));

  Widget buildPickerInches() => Container(
      width: 75,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: CupertinoPicker(
          looping: false,
          itemExtent: 64,
          children: heightsInInches
              .map((item) => Center(
                    child:
                        Text(item.toString(), style: TextStyle(fontSize: 20)),
                  ))
              .toList(),
          onSelectedItemChanged: (index) {
            setState(() => this.indexInches = index);

            inches = heightsInInches[index];
            if (index != 0) {
              inchesEmpty = false;
              _checkAllFieldsEmpty();
            }
          },
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14.5)),
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
                    height: 550,
                    width: 500,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "First Name:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: Focus(
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.red),
                                  maxLines: 1,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Enter your first name'),
                                  onChanged: (val) {
                                    setState(() {
                                      firstName = val;
                                    });
                                  },
                                ),
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    if (firstName != null && firstName != "") {
                                      firstNameEmpty = false;
                                      _checkAllFieldsEmpty();
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Last Name:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: Focus(
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.red),
                                  maxLines: 1,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Enter your last name'),
                                  onChanged: (val) {
                                    setState(() {
                                      lastName = val;
                                    });
                                  },
                                ),
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    if (lastName != null && lastName != "") {
                                      lastNameEmpty = false;
                                      _checkAllFieldsEmpty();
                                    }
                                  }
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
                              "Email:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: Focus(
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
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    if (email != null && email != "") {
                                      emailEmpty = false;
                                      _checkAllFieldsEmpty();
                                    }
                                  }
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
                              child: Focus(
                                child: PasswordField(
                                  fieldKey: _passwordFieldKey,
                                  onFieldSubmitted: (String value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    if (password != null && password != "") {
                                      passwordEmpty = false;
                                      _checkAllFieldsEmpty();
                                    }
                                  }
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
                              "Re-type password:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              child: Focus(
                                child: TextFormField(
                                    enabled: password != null,
                                    textAlign: TextAlign.end,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: "Re-type password",
                                    ),
                                    obscureText: true,
                                    onFieldSubmitted: (String value) {
                                      setState(() {
                                        retypedPassword = value;
                                      });
                                    }),
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    if (retypedPassword != null &&
                                        retypedPassword != "") {
                                      retypedPasswordEmpty = false;
                                      _checkAllFieldsEmpty();
                                    }
                                  }
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
                                  child: Focus(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(color: Colors.red),
                                      maxLines: 1,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3)
                                      ],
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: '135'),
                                      onChanged: (val) {
                                        setState(() {
                                          weight = val;
                                        });
                                      },
                                    ),
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        if (weight != null && weight != "") {
                                          weightEmpty = false;
                                          _checkAllFieldsEmpty();
                                        }
                                      }
                                    },
                                  ),
                                ),
                                const Text(" lbs",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red))
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Height:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            GestureDetector(
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
                                      height: 300,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          buildPickerFeet(),
                                          Text("feet",
                                              style: TextStyle(fontSize: 20)),
                                          buildPickerInches(),
                                          Text("inches",
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                    child: TextFormField(
                                      controller:
                                          TextEditingController(text: feet),
                                      readOnly: true,
                                      enableInteractiveSelection: false,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(color: Colors.red),
                                      maxLines: 1,
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: ""),
                                    ),
                                  ),
                                  Text(" ft, ",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red)),
                                  SizedBox(
                                    width: 20,
                                    child: TextFormField(
                                      controller:
                                          TextEditingController(text: inches),
                                      readOnly: true,
                                      enableInteractiveSelection: false,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(color: Colors.red),
                                      maxLines: 1,
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: ""),
                                    ),
                                  ),
                                  Text(" in",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red))
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Text(errorMessage,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                        ElevatedButton(
                          child: const Text("Create Account",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: createAccountButtonActive
                              ? () {
                                  print(firstName);
                                  print(lastName);
                                  print(email);
                                  print(password);
                                  print(retypedPassword);
                                  print(sex);
                                  print(weight);
                                  print(feet);
                                  print(inches);
                                  int weightInt = int.parse(weight!);
                                  int feetInt = int.parse(feet!);
                                  int inchesInt = int.parse(inches!);

                                  AuthService().signUp(
                                      firstName,
                                      lastName,
                                      email,
                                      password,
                                      sex,
                                      weightInt,
                                      feetInt,
                                      inchesInt);
                                }
                              : null,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
    return Focus(
      child: TextFormField(
        key: widget.fieldKey,
        obscureText: _obscureText,
        onSaved: widget.onSaved,
        textAlign: TextAlign.end,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: const InputDecoration.collapsed(
          border: InputBorder.none,
          hintText: "Create your password",
        ),
      ),
    );
  }
}
