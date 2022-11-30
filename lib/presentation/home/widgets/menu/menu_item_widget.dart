import 'package:flutter/material.dart';

import '../../../../data/models/menu_item_model.dart';
import '../../../shared/shared_imports.dart';

class MenuItemWidget extends StatelessWidget {
  final MyMenuItem item;
  final Function callback;
  final bool selected;

  const MenuItemWidget(
      {required Key key,
      required this.item,
      required this.callback,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DedicatedListTile(
      onPressed: () => callback(item.index),
      color: selected ? const Color(0x44000000) : const Color(0x44000000),
      leading: Icon(
        item.icon,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        item.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline4?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}
