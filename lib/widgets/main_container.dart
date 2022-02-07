import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  final double? height;
  final List<Widget> widgets;
  final Function? onTap;

  const MainContainer(
      {Key? key, this.height, this.onTap, required this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets)),
    );
  }
}
