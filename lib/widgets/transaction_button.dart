import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final int quarterTurns;
  final IconData iconData;
  final Function onTap;
  final double scalar;
  final String title;

  const ActionButton(
      {Key? key,
      this.quarterTurns = 0,
      required this.iconData,
      required this.onTap,
      required this.scalar,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 62,
        width: MediaQuery.of(context).size.width * scalar,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(80, 68, 184, 1),
        ),
        child: Row(
          children: [
            const Spacer(
              flex: 3,
            ),
            RotatedBox(
                quarterTurns: quarterTurns,
                child: Icon(iconData, color: Colors.white)),
            Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
