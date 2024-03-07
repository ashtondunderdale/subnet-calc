import 'dart:math';

import 'package:flutter/material.dart';

import '../globals.dart';
import 'subnet_preset_button.dart';
import 'subnet_result_box.dart';

class SubnetCalculator extends StatefulWidget {
  const SubnetCalculator({super.key});

  @override
  State<SubnetCalculator> createState() => _SubnetCalculatorState();
}

class _SubnetCalculatorState extends State<SubnetCalculator> {
  double octetOne = 0;
  double octetTwo = 0;
  double octetThree = 0;
  double octetFour = 0;
  double mask = 8;

  Map<String, List<int>> classRanges = {
  'A': [1, 126],
  'B': [128, 191],
  'C': [192, 223],
  'D': [224, 239],
  'E': [240, 255],
};

int randomInRange(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

String generateRandomIP(String ipClass) {
  final range = classRanges[ipClass];
  if (range != null) {
    final firstOctet = randomInRange(range[0], range[1]);
    final octetTwo = randomInRange(0, 255);
    final octetThree = randomInRange(0, 255);
    final octetFour = randomInRange(0, 255);
    return '$firstOctet.$octetTwo.$octetThree.$octetFour';
  } else {
    return ''; // Handle invalid class
  }
}

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
        Row(
          children: [
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
            Row(
              children: [
                Column(
                  children: [
                    SubnetPresetButton(label: "192", onPressed: () {
                      setState(() {
                        octetOne = 192;
                        octetTwo = 168;
                        octetThree = 0;
                        octetFour = 0;
                        mask = 24;
                      });
                    }),
                    SubnetPresetButton(label: "10", onPressed: () {
                      setState(() {
                        octetOne = 10;
                        octetTwo = 0;
                        octetThree = 0;
                        octetFour = 0;
                        mask = 8;
                      });
                    }),
                    SubnetPresetButton(label: "172", onPressed: () {
                      setState(() {
                        octetOne = 172;
                        octetTwo = 16;
                        octetThree = 0;
                        octetFour = 0;
                        mask = 16;
                      });
                    }),
                    SubnetPresetButton(label: "?", onPressed: () {
                      setState(() {
                        var random = Random();
                        octetOne = random.nextInt(256) as double;
                        octetTwo = random.nextInt(256) as double;
                        octetThree = random.nextInt(256) as double;
                        octetFour = random.nextInt(256) as double;
                        mask = random.nextInt(33) as double;
                      });
                    }),
                    SubnetPresetButton(label: "0", onPressed: () {
                      setState(() {
                        octetOne = 0;
                        octetTwo = 0;
                        octetThree = 0;
                        octetFour = 0;
                        mask = 0;
                      });
                    }),          
                  ],
                ),
                Column(
                  children: [
                    SubnetPresetButton(label: "A", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('A');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        octetOne = ipParts[0] as double;
                        octetTwo = ipParts[1] as double;
                        octetThree = ipParts[2] as double;
                        octetFour = ipParts[3] as double;
                        mask = 0;
                      });
                    }),
                    SubnetPresetButton(label: "B", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('B');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        octetOne = ipParts[0] as double;
                        octetTwo = ipParts[1] as double;
                        octetThree = ipParts[2] as double;
                        octetFour = ipParts[3] as double;
                        mask = 0;
                      });
                    }),
                    SubnetPresetButton(label: "C", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('C');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        octetOne = ipParts[0] as double;
                        octetTwo = ipParts[1] as double;
                        octetThree = ipParts[2] as double;
                        octetFour = ipParts[3] as double;
                        mask = 0;
                      });
                    }),
                    SubnetPresetButton(label: "D", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('D');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        octetOne = ipParts[0] as double;
                        octetTwo = ipParts[1] as double;
                        octetThree = ipParts[2] as double;
                        octetFour = ipParts[3] as double;
                        mask = 0;
                      });
                    }),
                    SubnetPresetButton(label: "E", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('E');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        octetOne = ipParts[0] as double;
                        octetTwo = ipParts[1] as double;
                        octetThree = ipParts[2] as double;
                        octetFour = ipParts[3] as double;
                        mask = 0;
                      });
                    }),
                  ],
                ),
     
              ],
            ),
          ],
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
