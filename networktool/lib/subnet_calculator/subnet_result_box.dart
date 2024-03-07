import 'dart:math';

import 'package:flutter/material.dart';

import '../globals.dart';

class SubnetResultBox extends StatelessWidget {
  const SubnetResultBox({super.key, required this.octetOne, required this.octetTwo, required this.octetThree, required this.octetFour, required this.mask});

  final double octetOne;
  final double octetTwo;
  final double octetThree;
  final double octetFour;
  final double mask;

  String calculateSubnetMask(int mask) {
    List<int> subnetMaskOctets = [];
      
    for (int i = 0; i < 4; i++) {
      int onesInOctet = mask >= 8 ? 8 : mask;
      
      int octetValue = (1 << (8 - onesInOctet)) - 1;
      subnetMaskOctets.add(octetValue);

      mask -= onesInOctet;
    }
      
    return subnetMaskOctets.join('.');
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: 600,
        height: 100,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildResultText("subnet", "$octetOne.$octetTwo.$octetThree.$octetFour/$mask"),
            buildResultText("devices: ", mask < 31 ? "${pow(2, 32 - mask)}(-2)" : "${pow(2, 32 - mask)}"),
            buildResultText("wildcard", calculateSubnetMask(mask.toInt())),
          ],
        ),
      ),
    );
  }
}

Widget buildResultText(
  final String label,
  final String value,
) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ), 
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ), 
        ),
      ),
    ],
  );
}