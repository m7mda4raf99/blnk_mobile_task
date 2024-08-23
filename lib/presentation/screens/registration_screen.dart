import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_1.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_2.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_3.dart';
import 'package:flutter/material.dart';

import 'package:blnk_mobile_task/presentation/widgets/stepper.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        leading: activeStep > 0
            ? IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_back_outlined))
            : const SizedBox(
                width: 15,
              ),
        leadingWidth: 15,
        title: const Center(
          child: Text('Create Account',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomStepper(activeStep),
              activeStep == 0
                  ? const RegistrationStepper1()
                  : activeStep == 1
                      ? const RegistrationStepper2()
                      : const RegistrationStepper3()
            ],
          ),
        ),
      ),
    );
  }
}
