import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';


// Classe représentant l'écran de connexion
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // Crée l'état associé à cet écran de connexion
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Classe privée qui gère l'état de l'écran de connexion
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  // Méthode appelée quand l'état est détruit pour libérer les ressources
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Méthode appelée lors de l'initialisation de l'état
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  // Méthode qui construit l'interface utilisateur de l'écran de connexion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Espacement vertical
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

            // Padding pour ajouter des marges intérieures
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 28),

                  // Champ de texte pour l'email
                  TextFieldInput(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
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
                        // Changer la visibilité du mot de passe
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Bouton de connexion
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
                        style: TextStyle(color: Colors.white,),
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
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),

                  // Conteneur flexible pour espacer les widgets
                  Flexible(
                    flex: 0,
                    child: Container(),
                  ),
                  const SizedBox(height: 24),

                  // Ligne de séparation
                  const Divider(thickness: 2),

                  // Texte pour les utilisateurs n'ayant pas de compte
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account"),
                        TextButton(
                          onPressed: () {},
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

                  // Ligne de séparation avec texte "OR"
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
