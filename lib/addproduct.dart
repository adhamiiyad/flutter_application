import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/userprofile.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return AddProdForm();
  }
}

class AddProdForm extends StatefulWidget {
  const AddProdForm({super.key});

  @override
  State<AddProdForm> createState() => _AddProdFormState();
}

class _AddProdFormState extends State<AddProdForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final database = FirebaseDatabase.instance.ref();
  File? selectedImage = File('');

  @override
  Widget build(BuildContext context) {
    // final productRef = database.child('products');
    validate(String? val) {
      if (val == null || val.isEmpty) {
        return 'Enter a valide value !!';
      }
      if (val.length < 2) {
        return 'short!';
      } else {
        return null;
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          backgroundColor: appBarColor,
          leading: BackButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfile()));
            },
          ),
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
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter product name',
                  style: style1,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: validate,
                  onSaved: (newValue) {
                    nameController.text = newValue.toString();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter product price',
                  style: style1,
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'product price in \$'
                  ),
                  validator: validate,
                  onSaved: (newValue) {
                    priceController.text = newValue.toString();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter a description',
                  style: style1,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: validate,
                  onSaved: (newValue) {
                    descriptionController.text = newValue.toString();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RawMaterialButton(
                  fillColor: Colors.red,
                  onPressed: () {
                    pickIwmage();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add Product Photo'),
                      Icon(Icons.add_a_photo),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await database.child('products').push().set({
                          'productName': nameController.text,
                          'productPrice': priceController.text,
                          'description': descriptionController.text,
                          // 'image': selectedImage!.parent
                        });
                      } catch (e) {
                        print('Error $e');
                      }
                    }
                  },
                  child: const Text(
                    'Add product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: btm(context),
      ),
    );
  }

  // get image from gellary method
  Future pickIwmage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  setState(() {
    selectedImage = File(image!.path);
  });
}
}
