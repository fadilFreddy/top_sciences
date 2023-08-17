import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled4/pages/accueil.dart';

import 'inscription.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle(BuildContext context) async {
  try {
    // Step 1: Demander à l'utilisateur de se connecter avec son compte Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // L'utilisateur a annulé la connexion avec Google
      return null;
    }

    // Step 2: Obtenir les informations d'identification Google
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Step 3: Créer une nouvelle authentification avec Google
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Step 4: Connexion à Firebase avec les informations d'identification Google
    final UserCredential userCredential = await _auth.signInWithCredential(credential);

    // Step 5: Récupérer l'utilisateur connecté
    final User? user = userCredential.user;

    return user;
  } catch (e) {
    print(e.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur de connexion Google'),
          content: const Text('Une erreur s\'est produite lors de la connexion avec Google. Veuillez réessayer.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return null;
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 30),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  labelText: 'Adresse mail',
                  prefixIcon: Icon(Icons.mail_outline_outlined),
                  prefixIconColor: Color(0xFF233B23),
                  hintText: 'Entrez votre mail ici',
                ),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: PasswordField(passwordController: passwordController),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // L'utilisateur est connecté avec succès
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePagee()),
                  );
                } catch (e) {
                  // Gérer les erreurs de connexion
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Erreur de connexion'),
                        content: const Text('Veuillez vérifier vos informations de connexion.'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              label: const Text(
                "Se connecter",
                style: TextStyle(fontSize: 20),
              ),
              icon: const Icon(Icons.login_outlined),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Naviguer vers la page d'inscription
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: const Text(
                'Pas encore inscrit ? Cliquez ici',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ), // Bouton pour se connecter avec Google
            ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () async {
                print("Réussie");
                User? user = await signInWithGoogle(context);
                if (user != null) {
                  // L'utilisateur est connecté avec succès
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePagee()),
                  );
                }
              },
              label: const Text(
                "Se connecter avec Google",
                style: TextStyle(fontSize: 20),
              ),
              icon: const Icon(Icons.login_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordField({required this.passwordController});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 30),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        labelText: 'Mot de passe',
        hintText: 'Entrez votre mot de passe',
        prefixIcon: const Icon(Icons.lock_outline),
        prefixIconColor: const Color(0xFF233B23),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      autofocus: false,
      controller: widget.passwordController,
    );
  }
}
