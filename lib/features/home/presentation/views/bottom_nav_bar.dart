import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/store_repo.dart';
import 'package:project1/features/home/data/models/order/product.dart';
import 'package:project1/features/home/presentation/manager/app%20cubit/app_cubit.dart';
import 'package:project1/features/home/presentation/views/search.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  String _category = '';
  String _gender = '';
  double _price = 0.0;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Stocky'),
            actions: [
              IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
                icon: const Icon(IconlyBroken.search),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeNav(index);
            },
            iconSize: 25,
            selectedItemColor: Colors.orange,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.home), label: "*"),
              BottomNavigationBarItem(icon: Icon(IconlyBroken.buy), label: "*"),
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.heart), label: "*"),
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.profile), label: "*"),
            ],
          ),
          body:
              AppCubit.get(context).screen[AppCubit.get(context).currentIndex],
          floatingActionButton: AppCubit.get(context).currentIndex == 0
              ? FloatingActionButton(
                  onPressed: _showAddProductDialog,
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product category';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _category = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Gender'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the gender';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _gender = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _price = double.parse(value!);
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Pick Image',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  _image != null ? Image.file(File(_image!.path)) : Container(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: _submitForm,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _pickImage() async {
    File? image = await ProductRepo().pickImage();
    setState(() {
      _image = image;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print('Name: $_name');
      print('Description: $_description');
      print('Category: $_category');
      print('Gender: $_gender');
      print('Price: $_price');
      if (_image != null) {
        print('Image path: ${_image!.path}');
      }

      await ProductRepo().addProduct(
          name: _name,
          description: _description,
          category: _category,
          gender: _gender,
          price: _price,
          ownerId: AuthApi.currentUser.id ?? '',
          image: _image!);

      Navigator.of(context).pop();
    }
  }
}
