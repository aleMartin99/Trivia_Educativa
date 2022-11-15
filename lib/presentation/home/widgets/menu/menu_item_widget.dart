import 'package:flutter/material.dart';

import '../../../../data/models/menu_item.dart';
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
    //   //TODO I10n
    //   //TODO change dialog to quick alert

    return DedicatedListTile(
      onPressed: () => callback(item.index),
      color: selected ? const Color(0x44000000) : const Color(0x44000000),
      leading: Icon(
        item.icon,
        color: Theme.of(context).iconTheme.color,
        //size: 24,
      ),
      title: Text(
        item.title,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline4?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).iconTheme.color
            //color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
