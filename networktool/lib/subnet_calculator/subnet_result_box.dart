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

  String calculateWildcardMask(int mask) {
    return List.generate(4, (i) {
      int onesInOctet = mask >= 8 ? 8 : mask;
      int octetValue = (1 << (8 - onesInOctet)) - 1;
      
      mask -= onesInOctet;
      
      return octetValue;
    }).join('.');
  }
  
String identifyIPClass(String ipAddress) {
  int firstOctet = int.parse(ipAddress.split('.')[0]);

  if (firstOctet == 0) return 'default route';

  return (firstOctet >= 1 && firstOctet <= 126)   ? 'Class A' :
         (firstOctet == 127)                      ? 'Loopback address' :
         (firstOctet >= 128 && firstOctet <= 191) ? 'Class B' :
         (firstOctet >= 192 && firstOctet <= 223) ? 'Class C' :
         (firstOctet >= 224 && firstOctet <= 239) ? 'Class D (multicast)' :
         (firstOctet >= 240 && firstOctet <= 255) ? 'Class E (experimental)' :
         'Invalid IP Address';
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: 600,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildResultText("subnet", "$octetOne.$octetTwo.$octetThree.$octetFour/$mask"),
              buildResultText("devices: ", mask < 31 ? "${pow(2, 32 - mask)}(-2)" : "${pow(2, 32 - mask)}"),
              buildResultText("wildcard", calculateWildcardMask(mask.toInt())),
              //buildResultText("mask", calculateSubnetmask(mask.toInt())),
              buildResultText("class", identifyIPClass("$octetOne.$octetTwo.$octetThree.$octetFour")),
            ],
          ),
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
        padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
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
      Text(
        value,
        style: const TextStyle(
          color: Color.fromARGB(255, 96, 96, 96),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1
        ), 
      ),
    ],
  );
}