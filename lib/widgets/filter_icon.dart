import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sary_project/constants/constants.dart';

class FilterIcon extends StatelessWidget {
  final Function(FilterBy) onPressed;
  const FilterIcon({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderedIconContainer(
      icon: const Icon(Icons.filter_alt_outlined),
      onPressed: () {
        Alert(
          context: context,
          type: AlertType.none,
          title: "Filter By:",
          buttons: [],
          content: Column(
            children: [
              BorderedIconContainer(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => onPressed(FilterBy.Date),
              ),
              const SizedBox(
                height: 4,
              ),
              BorderedIconContainer(
                icon: const Icon(Icons.looks_two),
                onPressed: () => onPressed(FilterBy.Quantity),
              ),
              const SizedBox(
                height: 4,
              ),
              BorderedIconContainer(
                icon: const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.trending_flat,
                      color: Colors.green,
                    )),
                onPressed: () => onPressed(FilterBy.Inbound),
              ),
              BorderedIconContainer(
                icon: const RotatedBox(
                  quarterTurns: -1,
                  child: Icon(
                    Icons.trending_flat,
                    color: Colors.red,
                  ),
                ),
                onPressed: () => onPressed(FilterBy.Outbound),
              ),
              const SizedBox(
                height: 4,
              ),
              BorderedIconContainer(
                icon: Text("X",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.red)),
                onPressed: () => onPressed(FilterBy.None),
              ),
            ],
          ),
        ).show();
      },
    );
  }
}

class BorderedIconContainer extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;

  const BorderedIconContainer({Key? key, required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kBorderColor, width: 0.7),
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}

// ignore: constant_identifier_names
enum FilterBy { Date, Quantity, Outbound, Inbound, None }
