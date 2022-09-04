import 'package:flutter/material.dart';

Widget customTextInput(Function(String? str) validator, String placeholder,
    FocusNode focusNodes, TextInputType type, TextEditingController controller) {
  return SizedBox(
    height: 70,
    child: TextFormField(
        controller: controller,
        focusNode: focusNodes,
        validator: (text) => validator(text),
        keyboardType: type,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.money,
              color:
                  focusNodes.hasFocus ? const Color(0xffFCA12A) : Colors.grey),
          prefixIconColor: const Color(0xffFCA12A),
          focusColor: const Color(0xffFCA12A),
          hintText: placeholder,
          hintStyle: const TextStyle(color: Color(0xff8D8D8D), fontSize: 14),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffFCA12A)),
          ),
        )),
  );
}
