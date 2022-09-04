import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoppinglist/widgets/bottom_sheet.dart';
import 'package:shoppinglist/widgets/custom_input.dart';
import 'package:shoppinglist/widgets/shopping_list_item.dart';

import 'models/list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final format =
      NumberFormat.currency(locale: "pt_BR", name: "R\$", decimalDigits: 2);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ListItem> shoppingList = [];
  double total = 0;

  addListItem(String name, double price) {
    ListItem list =
        ListItem(DateTime.now().millisecondsSinceEpoch, name, price);

    setState(() {
      shoppingList.add(list);
    });
    sumListItems();
  }

  removeListItem(index) {
    setState(() {
      shoppingList.removeAt(index);
      showSnackBar("Item deletado com sucesso.", Colors.green, context);
    });
    sumListItems();
  }

  sumListItems() {
    if (shoppingList.isNotEmpty) {
      var price = shoppingList
          .map<double>((item) => item.price)
          .reduce((value, element) => value + element);

      setState(() {
        total = price;
      });
    }
  }

  showSnackBar(String msg, Color color, BuildContext ctx) {
    ScaffoldMessenger.of(ctx)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Shopping list",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        shoppingList = [];
                      });
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.black))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  shoppingList.isNotEmpty
                      ? shoppingList.length == 1
                          ? '1 item'
                          : '${shoppingList.length} itens'
                      : 'Lista vazia',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
          Flexible(
            flex: 1,
            child: ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ShoppingListItem(
                    shoppingList: shoppingList,
                    index: index,
                    removeAt: removeListItem(index),
                  );
                }),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            height: 80,
            child: shoppingList.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const Text(
                          "Valor previsto",
                          style: TextStyle(
                              color: Color(0xffFCA12A),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          format.format(total),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ])
                : Container(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {modalBottomSheet(context, addListItem)},
        backgroundColor: const Color(0xffFCA12A),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
