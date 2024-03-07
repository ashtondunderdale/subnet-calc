import 'package:flutter/material.dart';

import '../globals.dart';

class SubnetPresetButton extends StatelessWidget {
  const SubnetPresetButton({super.key, required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        mini: true,
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}