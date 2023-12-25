import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

class SignupNext extends StatelessWidget {
  const SignupNext({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupNextForm(),
    );
  }
}

class SignupNextForm extends StatefulWidget {
  const SignupNextForm({super.key});

  @override
  State<SignupNextForm> createState() => _SignupNextFormState();
}

class _SignupNextFormState extends State<SignupNextForm> {
  TextEditingController genderController = TextEditingController();
  List<String> any = ['hi', 'hi0'];
  String username = '';
  @override
  Widget build(BuildContext context) {
    const txtStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
          title: const Text('data'),
          backgroundColor: appBarColor,
        ),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Text(
                'Welcome $username',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const Text(
                'Gender',
                style: txtStyle,
              ),
              Column(
                children: [
                  RadioListTile(
                      title: const Text('Male'),
                      value: 'male',
                      groupValue: genderController.text,
                      onChanged: (value) {
                        setState(() {
                          genderController.text = value.toString();
                        });
                      }),
                  RadioListTile(
                      title: const Text('Female'),
                      value: 'female',
                      groupValue: genderController.text,
                      onChanged: (value) {
                        setState(() {
                          genderController.text = value.toString();
                        });
                      }),
                  RadioListTile(
                      title: const Text('Prefer not to say'),
                      value: 'non',
                      groupValue: genderController.text,
                      onChanged: (value) {
                        setState(() {
                          genderController.text = value.toString();
                        });
                      }),
                ],
              ),
              
            ],
          ),
        ));
  }
}
