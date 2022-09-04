import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PredictedValue extends StatelessWidget {
  double total;
  NumberFormat format;

  PredictedValue({super.key, required this.total, required this.format});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        height: 80,
        child: Column(
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ]));
  }
}
