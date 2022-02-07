import 'package:flutter/material.dart';
import 'package:sary_project/constants/constants.dart';

class SearchField extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          border: Border.all(color: kBorderColor, width: 0.7)),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
            labelText: "Search",
            prefixIcon: Icon(Icons.search),
            fillColor: Colors.white,
            border: InputBorder.none),
      ),
    );
  }
}
