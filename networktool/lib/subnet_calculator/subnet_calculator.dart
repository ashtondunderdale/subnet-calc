import 'package:flutter/material.dart';

import '../globals.dart';
import 'subnet_result_box.dart';

class SubnetCalculator extends StatefulWidget {
  const SubnetCalculator({super.key});

  @override
  State<SubnetCalculator> createState() => _SubnetCalculatorState();
}

class _SubnetCalculatorState extends State<SubnetCalculator> {
  double octetOne = 192;
  double octetTwo = 168;
  double octetThree = 0;
  double octetFour = 0;
  double mask = 8;

  double getOctOne() => octetOne;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$octetOne.$octetTwo.$octetThree.$octetFour",
                    style: const TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                  ),
                ),
                TextSpan(
                  text: "/$mask",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 123, 123, 123),
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                  )
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.only(left: 8),
            width: 600,
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: Column(
              children: [
                buildSlider(octetOne, "oct 1", (value) {
                  setState(() {
                    octetOne = value;
                  });
                }),
                buildSlider(octetTwo, "oct 2", (value) {
                  setState(() {
                    octetTwo = value;
                  });
                }),
                buildSlider(octetThree, "oct 3", (value) {
                  setState(() {
                    octetThree = value;
                  });
                }),
                buildSlider(octetFour, "oct 4", (value) {
                  setState(() {
                    octetFour = value;
                  });
                }),
                buildSlider(mask, "mask", (value) {
                  setState(() {
                    mask = value;
                  });
                }),
              ],
            ),
          ),
        ),
        SubnetResultBox(octetOne: octetOne, octetTwo: octetTwo, octetThree: octetThree, octetFour: octetFour, mask: mask)
      ],
    );
  }
}

Widget buildSlider(
  double octet,
  final String title,
  ValueChanged<double> onChanged,
) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SizedBox(
          width: 40,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25
            ),
          ),
        ),
      ),
      Expanded(
        child: Slider(
          activeColor: const Color.fromARGB(255, 211, 211, 211),
          inactiveColor: const Color.fromARGB(255, 221, 221, 221),
          thumbColor: const Color.fromARGB(255, 255, 255, 255),
          label: octet.toString(),
          max: title == "mask" ? 32 : 255,
          divisions: title == "mask" ? 32 : 255,
          value: octet,
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
