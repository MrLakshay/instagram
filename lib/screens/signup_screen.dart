import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/utils.dart';

import '../responsive/phoneScreenLayout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/webScreenLayout.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _bioEditingController = TextEditingController();
  TextEditingController _usernameEditingController = TextEditingController();
  Uint8List? _image;
  bool isLoading=false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _bioEditingController.dispose();
    _usernameEditingController.dispose();
  }

  void selectImage() async {
    Uint8List im=await pickImage(ImageSource.gallery);
    // print(im);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null ? CircleAvatar(
                      radius: 64, backgroundImage: MemoryImage(_image!)
                  ):CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/564x/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _usernameEditingController,
                textInputType: TextInputType.text,
                hintText: 'Enter Your Username',
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _bioEditingController,
                textInputType: TextInputType.text,
                hintText: 'Enter Your Bio',
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _emailEditingController,
                textInputType: TextInputType.emailAddress,
                hintText: 'Enter Your Email',
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordEditingController,
                textInputType: TextInputType.emailAddress,
                isPass: true,
                hintText: 'Enter Your Password',
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    isLoading=true;
                  });
                  String res = await AuthMethods().signUpUser(
                      email: _emailEditingController.text,
                      password: _passwordEditingController.text,
                      username: _usernameEditingController.text,
                      bio: _bioEditingController.text,
                      file: _image!,
                  );
                  if (res == 'success') {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      phoneScreenLayout: PhoneScreenLayout(),),
                    ),
                    );
                  }
                  else{
                    showSnackBar(res, context);
                  }
                  setState(() {
                    isLoading=false;
                  });
                },
                child: Container(
                  child: isLoading==true? const CircularProgressIndicator(
                    color:primaryColor,

                  ):
                  const Text('Sign Up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Already have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen(),),);
                    },
                    child: Container(
                      child: Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
