import 'package:blnk_mobile_task/business_logic/cubit/registration_cubit.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_1.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_2.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_3.dart';
import 'package:flutter/material.dart';

import 'package:blnk_mobile_task/presentation/widgets/stepper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int activeStep = 0;

  RegistrationCubit? registrationCubit;

  @override
  Widget build(BuildContext context) {
    registrationCubit = BlocProvider.of<RegistrationCubit>(context);

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state is Stepper1Completed) {
          activeStep++;
        } else if (state is Stepper2Completed) {
          activeStep++;
        } else if (state is StepperBack) {
          activeStep--;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // toolbarHeight: 40,
            backgroundColor: Colors.white,
            leading: activeStep > 0
                ? FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      registrationCubit?.back();
                    },
                    child: const Icon(Icons.arrow_back_outlined),
                  )
                : const SizedBox(
                    width: 15,
                  ),
            title: const Center(
              child: Text('Create Account',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
            ),
            actions: const [SizedBox(width: 50)],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomStepper(activeStep),
                  activeStep == 0
                      ? RegistrationStepper1()
                      : activeStep == 1
                          ? RegistrationStepper2()
                          : const RegistrationStepper3()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
