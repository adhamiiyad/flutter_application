import 'package:flutter/material.dart';
import 'package:flutter_application/addproduct.dart';
import 'package:flutter_application/main.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your products'),
          backgroundColor: appBarColor,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: 10,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                padding: const EdgeInsets.all(10),
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 71, 44, 43),
                ),
              ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appBarColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddProduct()));
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: btm(context),
      ),
    );
  }
}
