import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:holbegram/methods/auth_methods.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  AddPictureState createState() => AddPictureState();
}

class AddPictureState extends State<AddPicture> {
  Uint8List? _image;
  bool _isLoading = false;

  // Méthode pour sélectionner une image de la galerie
  void selectImageFromGallery() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  // Méthode pour sélectionner une image de l'appareil photo
  void selectImageFromCamera() async {
    Uint8List image = await pickImage(ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  // Méthode pour choisir une image
  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      throw 'No image selected';
    }
  }

  // Méthode pour uploader l'image sur Firebase Storage et créer un utilisateur
  Future<void> uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase Storage
      await StorageMethods().uploadImageToStorage(
        false,
        'profilePics',
        _image!,
      );

      // Sign up user with the uploaded image URL
      String res = await AuthMethods().signUpUser(
        email: widget.email,
        username: widget.username,
        password: widget.password,
        file: _image,
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (res == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful')),
        );
        // Navigate to home screen here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res)),
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 28),
                const Text(
                  'Holbegram',
                  style: TextStyle(
                    fontFamily: 'Billabong',
                    fontSize: 50,
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 60,
                ),
                const SizedBox(height: 28),
                Text(
                  'Hello, ${widget.username} Welcome to Holbegram.',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose an image from your gallery or take a new one.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 35),
                _image != null
                    ? CircleAvatar(
                        radius: screenSize.width * 0.2,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/user_placeholder.png'),
                      ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.photo_library_outlined, color: Colors.red),
                      iconSize: screenSize.width * 0.1,
                      onPressed: selectImageFromGallery,
                    ),
                    SizedBox(width: screenSize.width * 0.3),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, color: Colors.red),
                      iconSize: screenSize.width * 0.1,
                      onPressed: selectImageFromCamera,
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(218, 226, 37, 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        ),
                        onPressed: uploadImage,
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
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
