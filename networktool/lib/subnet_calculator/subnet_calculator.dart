import 'dart:math';
import 'package:flutter/material.dart';

import '../api.dart';
import '../globals.dart';
import 'subnet_preset_button.dart';
import 'subnet_result_box.dart';

class SubnetCalculator extends StatefulWidget {
  const SubnetCalculator({super.key});

  @override
  State<SubnetCalculator> createState() => _SubnetCalculatorState();
}

class _SubnetCalculatorState extends State<SubnetCalculator> {

  @override
  void initState() {
    super.initState();
    getIpAddress();
  }

  Future getIpAddress() async {
    yourIPAddress = await API.getIPAddress();
    setState(() {});

    API.testInternetSpeed();
  }

  late String? yourIPAddress = "";

  double octetOne = 0;
  double octetTwo = 0;
  double octetThree = 0;
  double octetFour = 0;
  double mask = 0;

  bool octetOneLocked = false;
  bool octetTwoLocked = false;
  bool octetThreeLocked = false;
  bool octetFourLocked = false;
  bool maskLocked = false;

  String generateRandomIP(String ipClass) {  
    Map<String, List<int>> classRanges = {
      'A': [1, 126],
      'B': [128, 191],
      'C': [192, 223],
      'D': [224, 239],
      'E': [240, 255],
    };

    final random = Random();
    final range = classRanges[ipClass];

    if (range != null) {
      final firstOctet = range[0] + random.nextInt(range[1] - range[0] + 1);
      final octetTwo = random.nextInt(256);
      final octetThree = random.nextInt(256);
      final octetFour = random.nextInt(256);

      return '$firstOctet.$octetTwo.$octetThree.$octetFour';
      
    } else {
      return '';
    }
  }

  void toggleOctetLock(String octetName) {
   setState(() {
      switch (octetName) {
        case "oct 1":
          octetOneLocked = !octetOneLocked;
          break;
        case "oct 2":
          octetTwoLocked = !octetTwoLocked;
          break;
        case "oct 3":
          octetThreeLocked = !octetThreeLocked;
          break;
        case "oct 4":
          octetFourLocked = !octetFourLocked;
          break;
        case "mask":
          maskLocked = !maskLocked;
          break;
      }
    });
  }

  String getIpAddressInBinary() {
    final ipParts = ("$octetOne.$octetTwo.$octetThree.$octetFour").split('.');
    return ipParts.map((part) => int.parse(part).toRadixString(2).padLeft(8, '0')).join('.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 220),
                        child: Text(
                          getIpAddressInBinary(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          "Your IP Address is: $yourIPAddress",
                          style: const TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
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
                    buildSlider(octetOne, octetOneLocked, "oct 1", () {
                      setState(() {
                        octetOneLocked = !octetOneLocked;
                      });
                    }, (value) {
                      setState(() {
                        if (!octetOneLocked) octetOne = value;
                      });
                    }),

                    buildSlider(octetTwo, octetTwoLocked, "oct 2", () {
                      setState(() {
                        octetTwoLocked = !octetTwoLocked;
                      });
                    }, (value) {
                      setState(() {
                        if (!octetTwoLocked) octetTwo = value;
                      });
                    }),

                    buildSlider(octetThree, octetThreeLocked, "oct 3", () {
                      setState(() {
                        octetThreeLocked = !octetThreeLocked;
                      });
                    }, (value) {
                      setState(() {
                        if (!octetThreeLocked) octetThree = value;
                      });
                    }),

                    buildSlider(octetFour, octetFourLocked, "oct 4", () {
                      setState(() {
                        octetFourLocked = !octetFourLocked;
                      });
                    }, (value) {
                      setState(() {
                        if (!octetFourLocked) octetFour = value;
                      });
                    }),

                    buildSlider(mask, maskLocked, "mask", () {
                      setState(() {
                        maskLocked = !maskLocked;
                      });
                    }, (value) {
                      setState(() {
                       if (!maskLocked) mask = value;
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
                        if (!octetOneLocked)octetOne = 192;
                        if (!octetTwoLocked)octetTwo = 168;
                        if (!octetThreeLocked)octetThree = 0;
                        if (!octetFourLocked)octetFour = 0;
                        if (!maskLocked) mask = 24;
                      });
                    }),

                    SubnetPresetButton(label: "172", onPressed: () {
                      setState(() {
                        if (!octetOneLocked)octetOne = 172;
                        if (!octetTwoLocked)octetTwo = 16;
                        if (!octetThreeLocked)octetThree = 0;
                        if (!octetFourLocked)octetFour = 0;
                        if (!maskLocked) mask = 16;
                      });
                    }),

                    SubnetPresetButton(label: "10", onPressed: () {
                      setState(() {
                        if (!octetOneLocked)octetOne = 10;
                        if (!octetTwoLocked)octetTwo = 0;
                        if (!octetThreeLocked)octetThree = 0;
                        if (!octetFourLocked)octetFour = 0;
                        if (!maskLocked) mask = 8;
                      });
                    }),

                    SubnetPresetButton(label: "?", onPressed: () {
                      setState(() {
                        var random = Random();
                        if (!octetOneLocked) octetOne = random.nextInt(256) as double;
                        if (!octetTwoLocked) octetTwo = random.nextInt(256) as double;
                        if (!octetThreeLocked) octetThree = random.nextInt(256) as double;
                        if (!octetFourLocked) octetFour = random.nextInt(256) as double;
                        if (!maskLocked) mask = random.nextInt(33) as double;
                      });
                    }),

                    SubnetPresetButton(label: "0", onPressed: () {
                      setState(() {
                        if (!octetOneLocked) octetOne = 0;
                        if (!octetTwoLocked) octetTwo = 0;
                        if (!octetThreeLocked) octetThree = 0;
                        if (!octetFourLocked) octetFour = 0;
                        if (!maskLocked) mask = 0;
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
                        if (!octetOneLocked)octetOne = ipParts[0] as double;
                        if (!octetTwoLocked)octetTwo = ipParts[1] as double;
                        if (!octetThreeLocked)octetThree = ipParts[2] as double;
                        if (!octetFourLocked)octetFour = ipParts[3] as double;
                        if (!maskLocked) mask = 0;
                      });
                    }),

                    SubnetPresetButton(label: "B", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('B');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        if (!octetOneLocked)octetOne = ipParts[0] as double;
                        if (!octetTwoLocked)octetTwo = ipParts[1] as double;
                        if (!octetThreeLocked)octetThree = ipParts[2] as double;
                        if (!octetFourLocked)octetFour = ipParts[3] as double;
                        if (!maskLocked) mask = 0;
                      });
                    }),

                    SubnetPresetButton(label: "C", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('C');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        if (!octetOneLocked)octetOne = ipParts[0] as double;
                        if (!octetTwoLocked)octetTwo = ipParts[1] as double;
                        if (!octetThreeLocked)octetThree = ipParts[2] as double;
                        if (!octetFourLocked)octetFour = ipParts[3] as double;
                        if (!maskLocked) mask = 0;
                      });
                    }),

                    SubnetPresetButton(label: "D", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('D');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        if (!octetOneLocked)octetOne = ipParts[0] as double;
                        if (!octetTwoLocked)octetTwo = ipParts[1] as double;
                        if (!octetThreeLocked)octetThree = ipParts[2] as double;
                        if (!octetFourLocked)octetFour = ipParts[3] as double;
                        if (!maskLocked) mask = 0;
                      });
                    }),

                    SubnetPresetButton(label: "E", onPressed: () {
                      setState(() {
                        String randomIP = generateRandomIP('E');
                        List<int> ipParts = randomIP.split('.').map(int.parse).toList();
                        if (!octetOneLocked)octetOne = ipParts[0] as double;
                        if (!octetTwoLocked)octetTwo = ipParts[1] as double;
                        if (!octetThreeLocked)octetThree = ipParts[2] as double;
                        if (!octetFourLocked)octetFour = ipParts[3] as double;
                        if (!maskLocked) mask = 0;
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
  bool octetlock,
  final String title,
  final VoidCallback onLock,
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
          secondaryTrackValue: title == "mask" ? 16 : 127,
          secondaryActiveColor: const Color.fromARGB(255, 207, 207, 207),
          label: octet.toString(),
          max: title == "mask" ? 32 : 255,
          divisions: title == "mask" ? 32 : 255,
          value: octet,
          onChanged: onChanged,
        ),
      ),
      IconButton(
        onPressed: () {
          onLock();
        }, 
        icon: Icon(
          octetlock ? Icons.lock : Icons.lock_open,
          color: Colors.grey,
          size: 16,
        )
      )
    ],
  );
}
