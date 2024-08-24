import 'dart:io';

import 'package:flutter/material.dart';

class NationalIDScreen extends StatelessWidget {
  final String imagePath;
  const NationalIDScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
      ),
      body: SafeArea(
          child: Center(
        child: Image.file(
          File(imagePath),
        ),
      )),
    );
  }
}
