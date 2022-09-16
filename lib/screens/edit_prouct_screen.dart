import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

import 'package:flutter/material.dart';
import '../provider/product.dart';

// ignore: use_key_in_widget_constructors
class EditScreen extends StatefulWidget {
  static const routeName = '/editScreen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

// ignore: camel_case_types
class _EditScreenState extends State<EditScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  var _editProduct =
      Product(id: '', title: '', description: '', imagUrl: '', price: 0);

  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocus.addListener(_updateUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      // ignore: unnecessary_null_comparison
      if (productId != null) {
        _editProduct = Provider.of<ProductProvider>(context)
            .findById(productId.toString());
        _initValue = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          'imageUrl': ''
        };
        _imageUrlController.text = _editProduct.imagUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocus.removeListener(_updateUrl);
    _imageUrlFocus.dispose();
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    if (_editProduct.id.isNotEmpty) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editProduct);
    }
    Navigator.of(context).pop();
  }

  void _updateUrl() {
    if (!_imageUrlFocus.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') ||
          !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg') &&
              !_imageUrlController.text.endsWith('png')) {
        return;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(children: [
            TextFormField(
              initialValue: _initValue['title'],
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocus),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please Enter title';
                }
                return null;
              },
              onSaved: (newValue) => _editProduct = Product(
                  id: _editProduct.id,
                  title: newValue.toString(),
                  description: _editProduct.description,
                  imagUrl: _editProduct.imagUrl,
                  price: _editProduct.price),
            ),
            TextFormField(
              initialValue: _initValue['price'],
              decoration: const InputDecoration(labelText: 'price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocus,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_descriptionFocus),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please fill price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number.';
                }
                if (double.parse(value) <= 0) {
                  return 'Please enter a number greater than zero.';
                }
                return null;
              },
              onSaved: (newValue) => _editProduct = Product(
                  id: _editProduct.id,
                  title: _editProduct.title,
                  description: _editProduct.description,
                  imagUrl: _editProduct.imagUrl,
                  price: double.parse(newValue.toString())),
            ),
            TextFormField(
              initialValue: _initValue['description'],
              decoration: const InputDecoration(labelText: 'Description'),
              focusNode: _descriptionFocus,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description.';
                }
                if (value.length < 10) {
                  return 'Should be at least 10 characters long.';
                }
                return null;
              },
              onSaved: (newValue) => _editProduct = Product(
                  id: _editProduct.id,
                  title: _editProduct.title,
                  description: newValue.toString(),
                  imagUrl: _editProduct.imagUrl,
                  price: _editProduct.price),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Colors.grey,
                          style: BorderStyle.solid)),
                  child: _imageUrlController.text.isEmpty
                      ? const Text(
                          'please add photo',
                          textAlign: TextAlign.center,
                        )
                      : FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    controller: _imageUrlController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    focusNode: _imageUrlFocus,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an image URL.';
                      }
                      if (!value.startsWith('http') &&
                          !value.startsWith('https')) {
                        return 'Please enter a valid URL.';
                      }
                      if (!value.endsWith('.png') &&
                          !value.endsWith('.jpg') &&
                          !value.endsWith('.jpeg')) {
                        return 'Please enter a valid image URL.';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _editProduct = Product(
                        id: _editProduct.id,
                        title: _editProduct.title,
                        description: _editProduct.description,
                        imagUrl: newValue.toString(),
                        price: _editProduct.price),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
