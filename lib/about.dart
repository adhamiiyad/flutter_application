import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: drw(context),
        appBar: AppBar(
          title: const Text('About'),
          backgroundColor: appBarColor,
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Image.network(
                  'https://kinsta.com/wp-content/uploads/2019/08/jpg-vs-jpeg.jpg',),
              const Center(
                child: Text(
                  'adhgfwdjvkudfuvqeouvfveufvouuyob3y.mbjklfbveljvbrivhbriuhvpiruvhbprubvpirubv',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: btm(context),
      ),
    );
  }
}
