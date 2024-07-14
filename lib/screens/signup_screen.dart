import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'login_screen.dart';
import 'upload_image_screen.dart'; // Importation de la page AddPicture

// Déclaration du widget Stateful pour la page d'inscription
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

// Classe State associée au widget SignUpScreen
class SignUpScreenState extends State<SignUpScreen> {
  // Déclaration des contrôleurs pour gérer les entrées utilisateur
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  // Variable pour contrôler la visibilité du mot de passe
  bool _passwordVisible = true;

  // Libère les ressources des contrôleurs lorsqu'ils ne sont plus nécessaires
  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  // Initialise l'état du widget
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  // Vérifie si les champs ne sont pas vides avant de naviguer vers AddPicture
  void navigateToAddPicture() {
    if (emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordConfirmController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    } else if (passwordController.text != passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPicture(
            email: emailController.text,
            username: usernameController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }

  // Construire l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Utilisation de ConstrainedBox et IntrinsicHeight pour gérer la taille minimale et intrinsèque de la page
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenSize.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 28),
                 // Titre de l'application
                const Text(
                  'Holbegram',
                  style: TextStyle(
                    fontFamily: 'Billabong',
                    fontSize: 50,
                  ),
                ),
                 // Logo de l'application
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 60,
                ),
                const SizedBox(height: 16),
                // Texte descriptif
                const Text(
                  'Sign up to see photos and videos\nfrom your friends.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 28),
                // Padding pour ajouter des marges intérieures
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      // Champ de texte pour l'email
                      TextFieldInput(
                        controller: emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24),
                      // Champ de texte pour le nom d'utilisateur
                      TextFieldInput(
                        controller: usernameController,
                        hintText: 'Username',
                      ),
                      const SizedBox(height: 24),
                      // Champ de texte pour le mot de passe avec option de visibilité
                      TextFieldInput(
                        controller: passwordController,
                        isPassword: !_passwordVisible,
                        hintText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: const Color.fromARGB(218, 226, 37, 24),
                          ),
                          onPressed: () {
                            // Change la visibilité du mot de passe
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Champ de texte pour la confirmation du mot de passe avec option de visibilité
                      TextFieldInput(
                        controller: passwordConfirmController,
                        isPassword: !_passwordVisible,
                        hintText: 'Confirm Password',
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: const Color.fromARGB(218, 226, 37, 24),
                          ),
                          onPressed: () {
                            // Change la visibilité du mot de passe
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Bouton d'inscription
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(218, 226, 37, 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                          onPressed: navigateToAddPicture,
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 2),
                      // Lien pour naviguer vers la page de connexion
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(218, 226, 37, 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
