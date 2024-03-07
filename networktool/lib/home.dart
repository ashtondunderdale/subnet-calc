import 'package:flutter/material.dart';

import 'subnet_calculator/subnet_calculator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SubnetCalculator(),
        ],
      ),
    );
  }
}