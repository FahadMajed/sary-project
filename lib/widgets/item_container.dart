import 'package:flutter/material.dart';
import 'package:sary_project/models/item.dart';

import 'main_container.dart';

class ItemContainer extends StatelessWidget {
  final Item item;

  final Function? onTap;

  const ItemContainer({Key? key, required this.item, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainContainer(
          onTap: onTap,
          widgets: [
            Row(
              children: [
                Image.memory(item.imagePath),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 102,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name),
                      const Spacer(flex: 1),
                      Text(
                        item.sku,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(item.description,
                          style: Theme.of(context).textTheme.subtitle2),
                      const Spacer(flex: 1),
                      Text(item.price.toString(),
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
