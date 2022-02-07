import 'package:flutter/material.dart';

class CupertinoBSContainer extends StatelessWidget {
  final Widget child;

  const CupertinoBSContainer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      color: Color(0xff737373),
      child: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              height: MediaQuery.of(context).size.width * 0.6,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
