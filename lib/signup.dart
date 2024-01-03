import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignupForm(),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool policyController = false;

  final _formKey = GlobalKey<FormState>();

  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    // final userRef = database.child('user');

    validate1(String? val) {
      if (val == null || val.isEmpty) {
        return 'Enter a valide value !!';
      }
      if (val.length < 2) {
        return 'short!';
      } else {
        return null;
      }
    }

    void clearAll() {
      nameController.clear();
      emailController.clear();
      passController.clear();
    }

    return Scaffold(
      drawer: drw(context),
      appBar: AppBar(
        title: const Text('Sign-up'),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter your name',
                style: style1,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: validate1,
                onSaved: (newValue) {
                  nameController.text = newValue.toString();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter your email',
                style: style1,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: validate1,
                onSaved: (newValue) {
                  emailController.text = newValue.toString();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter a strong Password',
                style: style1,
              ),
              TextFormField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: validate1,
                onSaved: (newValue) {
                  passController.text = newValue.toString();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  'Agree with terms & ...',
                ),
                value: policyController,
                onChanged: (value) {
                  setState(() {
                    policyController = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  policyController == false
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('you have to agree with our terms')))
                      : null;

                  if (_formKey.currentState!.validate() &&
                      policyController == true) {
                    _formKey.currentState!.save();
                    try {
                      await database.child('user/xxx').set({
                        'name': nameController.text,
                        'email': emailController.text,
                        'password': passController.text,
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('soryy you got an error, please try again.'),
                        duration: Duration(
                          seconds: 3,
                        ),
                      ));
                    }
                    clearAll();
                  }
                },
                child: const Text('Sign-up'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: btm(context),
    );
  }
}
