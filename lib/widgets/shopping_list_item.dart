import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoppinglist/models/list_item.dart';

// ignore: must_be_immutable
class ShoppingListItem extends StatelessWidget {
  List<ListItem> shoppingList;
  int index;
  Function removeAt;
  final format =
      NumberFormat.currency(locale: "pt_BR", name: "R\$", decimalDigits: 2);

  ShoppingListItem(
      {super.key,
      required this.shoppingList,
      required this.index,
      required this.removeAt});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("${shoppingList[index].id}"),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeAt();
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
              Text(shoppingList[index].name),
              Text(format.format(shoppingList[index].price)),
            ],
          )),
    );
  }
}
