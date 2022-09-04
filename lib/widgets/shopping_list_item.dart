import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoppinglist/models/list_item.dart';

class ShoppingListItem extends StatefulWidget {
  List<ListItem> shoppingList;
  Function removeAt;
  NumberFormat format;

  ShoppingListItem(
      {super.key,
      required this.shoppingList,
      required this.removeAt,
      required this.format});

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ListView.builder(
          itemCount: widget.shoppingList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key("${widget.shoppingList[index].id}"),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                widget.removeAt(index);
              },
              child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  color: index % 2 == 0
                      ? const Color(0xffE8E8E8)
                      : const Color(0xffF5CD99),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.shoppingList[index].name),
                      Text(widget.format
                          .format(widget.shoppingList[index].price)),
                    ],
                  )),
            );
          }),
    );
  }
}
