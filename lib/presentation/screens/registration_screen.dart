import 'package:blnk_mobile_task/business_logic/cubit/registration_cubit.dart';
import 'package:blnk_mobile_task/presentation/widgets/app_bar.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_1.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_2.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_3.dart';
import 'package:blnk_mobile_task/services/edge_detector.dart';
import 'package:flutter/material.dart';

import 'package:blnk_mobile_task/presentation/widgets/stepper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BlocConsumer<RegistrationCubit, RegistrationState>(
            listener: (context, state) {
              if (state is Stepper1Completed) {
                activeStep++;
              } else if (state is Stepper1Error) {
              } else if (state is Stepper2Completed) {
                getNationalIDFrontFromCamera();
              } else if (state is Stepper2Error) {
              } else if (state is NationalIDFrontUploaded) {
                getNationalIDBackFromCamera();
              } else if (state is NationalIDBackUploaded) {
                activeStep++;
              } else if (state is Stepper3Completed) {
                Navigator.pushNamed(context, '/registration-complete');
              } else if (state is Stepper3Error) {
                MotionToast.error(
                  title: const Text(
                    'Error',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  description: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                ).show(context);
              } else if (state is StepperBack) {
                activeStep--;
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  CustomAppBar(
                      activeStep: activeStep,
                      registrationCubit: registrationCubit!),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomStepper(activeStep),
                          activeStep == 0
                              ? RegistrationStepper1()
                              : activeStep == 1
                                  ? RegistrationStepper2()
                                  : RegistrationStepper3()
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getNationalIDFrontFromCamera() async {
    EdgeDetector edgeDetector = EdgeDetector();
    String imagePath = await edgeDetector.detect('National ID (Front)');

    if (imagePath != 'Error') {
      XFile? file = XFile(imagePath);
      registrationCubit?.uploadNationalIDFront(file);
    }
  }

  Future<void> getNationalIDBackFromCamera() async {
    EdgeDetector edgeDetector = EdgeDetector();
    String imagePath = await edgeDetector.detect('National ID (Back)');

    if (imagePath != 'Error') {
      XFile? file = XFile(imagePath);
      registrationCubit?.uploadNationalIDBack(file);
    }
  }
}
