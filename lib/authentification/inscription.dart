import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController nomController = TextEditingController();
  late TextEditingController prenomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
             SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 30),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  labelText: 'Nom',
                  prefixIcon: Icon(Icons.person_2_rounded),
                  hintText: 'Entrez votre nom',
                ),
                autofocus: false,
                controller: nomController,
              ),
            ),
            const SizedBox(height: 10),
             SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 30),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  labelText: 'Prénom',
                  prefixIcon: Icon(Icons.person_rounded),
                  hintText: 'Entrez votre prénom',
                ),
                autofocus: false,
                controller: prenomController,
              ),
            ),
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
                  hintText: 'Entrez votre mail',
                ),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 30),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Entrez votre mot de passe',
                ),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 30),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Confirmez votre mot de passe',
                ),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () async {
                try {
                  await _auth.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Récupérer l'identifiant de l'utilisateur connecté
                  User? user = _auth.currentUser;
                  String? uid = user?.uid;

                  // Ajouter le nom et le prénom à la collection "utilisateurs"
                  await _firestore.collection('utilisateurs').doc(uid).set({
                    'nom': nomController.text,
                    'prenom': prenomController.text,
                  });

                  // L'enregistrement s'est effectué avec succès
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Inscription réussie'),
                        content: const Text('Vous pouvez maintenant vous connecter.'),
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
                } catch (e) {
                  print(e.toString());
                  // Gérer les erreurs d'enregistrement
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Erreur d\'inscription'),
                        content: const Text('Une erreur s\'est produite lors de l\'inscription. Veuillez réessayer.'),
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
              child: const Text(
                "S'inscrire",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
