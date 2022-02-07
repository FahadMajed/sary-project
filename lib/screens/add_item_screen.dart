import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sary_project/constants/constants.dart';
import 'package:sary_project/models/item.dart';
import 'package:sary_project/models/services.dart';
import 'package:sary_project/shared/bordered_text_field.dart';
import 'package:sary_project/shared/image_picker.dart';
import 'package:sary_project/widgets/main_container.dart';
import 'package:sary_project/widgets/transaction_button.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  String id = "";
  String sku = "";
  String name = "";
  double price = 0;
  String description = "";
  Uint8List imagePath = Uint8List(4);

  void _pickedImage(File image) async {
    var asBytes = await image.readAsBytes();
    imagePath = asBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainContainer(
            widgets: [
              BorderedTextField(
                  labelText: "Item Name",
                  validator: (name) {
                    if (name!.isEmpty) return "Required Field";
                  },
                  onChanged: (name) => this.name = name),
              const SizedBox(
                height: 8,
              ),
              BorderedTextField(
                  labelText: "Description",
                  validator: (description) {
                    if (description!.isEmpty) return "Required Field";
                  },
                  onChanged: (description) => this.description = description),
              const SizedBox(
                height: 8,
              ),
              BorderedTextField(
                  validator: (sku) {
                    if (sku!.isEmpty) return "Required Field";
                    if (sku.length < 7) return "Invalid SKU length";
                  },
                  labelText: "SKU",
                  onChanged: (sku) => this.sku = sku),
              const SizedBox(
                height: 8,
              ),
              BorderedTextField(
                  labelText: "Price",
                  validator: (price) {
                    if (price!.isEmpty) return "Required Field";
                    try {
                      double.parse(price);
                    } catch (e) {
                      return "Invalid Number!";
                    }
                  },
                  onChanged: (price) =>
                      this.price = double.tryParse(price) as double),
              const SizedBox(
                height: 8,
              ),
              BorderedTextField(
                  validator: (id) {
                    if (id!.isEmpty) return "Required Field";
                  },
                  labelText: "ID",
                  onChanged: (id) => this.id = id),
              const SizedBox(
                height: 8,
              ),
              ItemImagePicker(
                imagePickFn: _pickedImage,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: ActionButton(
        title: "Submit",
        iconData: Icons.check,
        scalar: 0.9,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            Item item = Item(
                id: id,
                name: name,
                price: price,
                sku: sku,
                description: description,
                imagePath: imagePath);
            Services().addItem(item);
            Functions.showSuccessSnackBar(context, "Item Added",
                () => Navigator.popUntil(context, (route) => route.isFirst));
          } else
            Functions.showFailureSnackBar(
              context,
              "Something Went Wrong",
            );
        },
      ),
    );
  }
}
