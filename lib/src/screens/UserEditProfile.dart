import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employmentappproject/src/providers/auth.dart';
import 'package:employmentappproject/src/screens/home.dart';
import 'package:employmentappproject/src/screens/settings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserEditProfile extends StatefulWidget {
  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  bool showPassword = false;
  File _image;

  Reference _reference = FirebaseStorage.instance.ref().child('myImage.jpg');
  final picker = ImagePicker();
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController location = TextEditingController();
  bool upload = false;
  String downloadUrl;
  Future uploadImage() async {
    UploadTask uploadTask = _reference.putFile(_image);
    uploadTask.whenComplete(() => upload = true);
    setState(() {
      upload = true;
    });
  }

  Future downloadedUrl() async {
    String downloadAddress = await _reference.getDownloadURL();
    print(downloadAddress);
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    if (_image != null) {
      uploadImage();
      downloadedUrl();
    }
  }

  @override
  void initState() {
    final authUser = Provider.of<Auth>(context, listen: false);
    super.initState();
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(authUser.user.uid)
        .snapshots()
        .listen((data) {
      fullName.text = data.data()['Full Name'];
      username.text = data.data()['username'];
      password.text = data.data()['password'];
      location.text = data.data()['location'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    fullName.dispose();
    username.dispose();
    password.dispose();
    location.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getUser = Provider.of<Auth>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[700],
          elevation: 1,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                })
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.pink[900],
            Colors.pink[800],
            Colors.pink[700],
            Colors.pink[600],
          ])),
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FutureBuilder(
                                    future: _reference.getDownloadURL(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        return Image.network(
                                          snapshot.data.toString(),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        );
                                      }
                                    })),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Choose Photo '),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Choose a medium'),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: TextButton.icon(
                                                      icon: Icon(Icons.camera),
                                                      style:
                                                          TextButton.styleFrom(
                                                              primary:
                                                                  Colors.black),
                                                      onPressed: () {
                                                        getImage(
                                                            ImageSource.camera);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      label: Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: TextButton.icon(
                                                      icon: Icon(Icons.image),
                                                      onPressed: () {
                                                        getImage(ImageSource
                                                            .gallery);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      label: Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                              },
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: fullName,
                    obscureText: showPassword ? showPassword : false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        suffixIcon: showPassword
                            ? IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              )
                            : null,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        labelText: 'Full Name',
                        hintText: 'Alex groot',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: username,
                    obscureText: showPassword ? showPassword : false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        suffixIcon: showPassword
                            ? IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              )
                            : null,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        labelText: 'Username',
                        hintText: 'abc@gmail.com',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: password,
                    obscureText: showPassword ? showPassword : false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        suffixIcon: showPassword
                            ? IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              )
                            : null,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        labelText: 'Password',
                        hintText: 'xxxxxx',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: location,
                    obscureText: showPassword ? showPassword : false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        suffixIcon: showPassword
                            ? IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              )
                            : null,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        labelText: 'Location',
                        hintText: 'xyx',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      color: Colors.green,
                      onPressed: () async {
                        String downloadUrl = await _reference.getDownloadURL();
                        Map<String, dynamic> data = {
                          'Full Name': fullName.text,
                          'username': username.text,
                          'password': password.text,
                          'location': location.text,
                          'imageUrl': downloadUrl,
                        };
                        await FirebaseFirestore.instance
                            .collection('UserProfile')
                            .doc(getUser.user.uid)
                            .set(data);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controllers) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controllers,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            filled: true,
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )
                : null,
            focusColor: Colors.white,
            fillColor: Colors.white,
            labelText: labelText,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
