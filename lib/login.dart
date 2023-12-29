import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/userprofile.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyWidget();
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<FirebaseApp> _init() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        drawer: drw(context),
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: appBarColor,
          // leading: BackButton(
          //   onPressed: () {
          //     backButton(context);
          //   },
          // ),
          
        ),
        body: FutureBuilder(
          future: _init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginForm();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomNavigationBar: btm(context),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _key = GlobalKey<FormState>();

  static Future<User?> loginFunction(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('no email found');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    validate(String? val) {
      if (val == null || val.isEmpty) {
        return 'enter a valid value';
      } else {
        return null;
      }
    }

    return Center(
      child: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          children: [
            const Text(
              'Login to your Account',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                height: 2,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'User Email',
                icon: Icon(Icons.email),
              ),
              validator: validate,
              onSaved: (newValue) {
                _emailController.text = newValue.toString();
              },
            ),
            TextFormField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.password),
              ),
              validator: validate,
              onSaved: (newValue) {
                _passController.text = newValue.toString();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RawMaterialButton(
              padding: const EdgeInsets.all(10),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: appBarColor,
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  _key.currentState!.save();
                  User? user = await loginFunction(
                      email: _emailController.text,
                      password: _passController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UserProfile()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('user not found'),
                    ));
                  }
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
