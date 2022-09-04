import 'package:flutter/material.dart';

import 'custom_input.dart';

Future modalBottomSheet(BuildContext context, Function addListItem) {
  final formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();

  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  String? validateNameInput(String? text) {
    if (text == null || text.isEmpty) {
      return "O nome deve ser preenchido";
    }

    return null;
  }

  String? validatePriceInput(String? text) {
    if (text == null || text.isEmpty) {
      return "O preço deve ser preenchido";
    }

    var price = double.parse(text.replaceAll(',', '.'));

    if (price.isNegative) {
      return "O preço não pode ser negativo";
    }

    if (price > 1000) {
      return "Insira um valor até R\$ 1.000,00";
    }
    return null;
  }

  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 250,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customTextInput(
                      validateNameInput,
                      "nome do item",
                      focusNodes[0],
                      TextInputType.emailAddress,
                      nameTextController),
                  customTextInput(validatePriceInput, "preço do item",
                      focusNodes[1], TextInputType.number, priceTextController),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          addListItem(
                              nameTextController.text,
                              double.parse(priceTextController.text
                                  .replaceAll(',', '.')));
                          nameTextController.clear();
                          priceTextController.clear();
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFCA12A),
                          elevation: 5,
                          fixedSize: const Size(double.maxFinite, 50)),
                      child: const Text(
                        "Adicionar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                ],
              ),
            ),
          ),
        );
      });
}
