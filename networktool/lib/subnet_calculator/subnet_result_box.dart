import 'package:flutter/material.dart';

import '../globals.dart';

class SubnetResultBox extends StatelessWidget {
  const SubnetResultBox({super.key, required this.octetOne, required this.octetTwo, required this.octetThree, required this.octetFour, required this.mask});

  final double octetOne;
  final double octetTwo;
  final double octetThree;
  final double octetFour;
  final double mask;

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
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                "subnet: $octetOne.$octetTwo.$octetThree.$octetFour/$mask",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}