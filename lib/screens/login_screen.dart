import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'signup_screen.dart';

// Déclaration du widget Stateful pour la page de connexion
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Classe State associée au widget LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  // Libére les ressources des contrôleurs lorsqu'ils ne sont plus nécessaires
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Initialise l'état du widget
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  // Construire l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const SizedBox(height: 28),
              // Zone de texte pour l'adresse e-mail
              TextFieldInput(
                controller: emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              // Zone de texte pour le mot de passe
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
              const SizedBox(height: 28),
              // Bouton pour se connecter
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
                  onPressed: () {},
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Texte pour les utilisateurs ayant oublié leurs identifiants
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Forgot your login details? '),
                  Text(
                    'Get help signing in.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account"),
                    TextButton(
                      onPressed: () {
                        // Naviguer vers la page d'inscription
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Ligne de séparation avec le texte 'OR'
              const Row(
                children: [
                  Flexible(
                    child: Divider(thickness: 2),
                  ),
                  Text(' OR '),
                  Flexible(
                    child: Divider(thickness: 2),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Bouton pour se connecter avec Google
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                    width: 40,
                    height: 40,
                  ),
                  const Text('Sign in with Google'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
