import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alumniapp/resources/auth_methods.dart';
import 'package:alumniapp/responsive/mobile_screen_layout.dart';
import 'package:alumniapp/responsive/responsive_layout.dart';
import 'package:alumniapp/responsive/web_screen_layout.dart';
import 'package:alumniapp/screens/login_screen.dart';
import 'package:alumniapp/utils/utils.dart';
import 'package:alumniapp/widgets/text_field_input.dart';

class RegisterScreenPage extends StatefulWidget {
  const RegisterScreenPage({super.key});

  @override
  State<RegisterScreenPage> createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreenPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // _descriptionController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        description: _descriptionController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreenPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: ListView(children: <Widget>[
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Flexible(child:Container(),flex: 2),

                  const SizedBox(
                    height: 40,
                  ),

                  // const Icon(
                  //   Icons.lock,
                  //   size: 80,
                  // ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                          : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg'),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                          // color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  const Text(
                    "Let's create an accont for you",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(height: 20),
                  ),

                  TextFieldInput(
                    hintText: 'Enter your username',
                    textInputType: TextInputType.text,
                    textEditingController: _usernameController,
                  ),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 5,
                    ),
                  ),

                  TextFieldInput(
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 5,
                    ),
                  ),

                  TextFieldInput(
                    hintText: 'Password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 5,
                    ),
                  ),

                  TextFieldInput(
                    hintText: 'Enter your Description',
                    textInputType: TextInputType.text,
                    textEditingController: _descriptionController,
                  ),

                  const SizedBox(height: 15),

                  InkWell(
                    onTap: signUpUser,
                    child: Container(
                      child: _isLoading
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(52),
                            ),
                          ),
                          color: Colors.blue),
                    ),
                  ),

                  const SizedBox(height: 3),

                  // Flexible(child:Container(),flex: 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Already have an account?"),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Container(
                          child: Text(
                            "Login now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}