import 'package:blnk_mobile_task/business_logic/cubit/registration_cubit.dart';
import 'package:blnk_mobile_task/presentation/widgets/app_bar.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_1.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_2.dart';
import 'package:blnk_mobile_task/presentation/widgets/registration_stepper_3.dart';
import 'package:flutter/material.dart';

import 'package:blnk_mobile_task/presentation/widgets/stepper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
          getNationalIDFrontFromCamera();
        } else if (state is NationalIDFrontUploaded) {
          getNationalIDBackFromCamera();
        } else if (state is NationalIDBackUploaded) {
          activeStep++;
        } else if (state is Stepper3Completed) {
          Navigator.pushNamed(context, '/registration-complete');
        } else if (state is StepperBack) {
          activeStep--;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
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
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> getNationalIDFrontFromCamera() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      return;
    }

    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      await EdgeDetection.detectEdge(
        imagePath,
        androidScanTitle: 'Scan National ID (Front)',
        androidCropTitle: 'Crop National ID (Front)',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      XFile? file = XFile(imagePath);
      registrationCubit?.uploadNationalIDFront(file);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> getNationalIDBackFromCamera() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      return;
    }

    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      await EdgeDetection.detectEdge(
        imagePath,
        androidScanTitle: 'Scan National ID (Back)',
        androidCropTitle: 'Crop National ID (Back)',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      XFile? file = XFile(imagePath);
      registrationCubit?.uploadNationalIDBack(file);
      // ignore: empty_catches
    } catch (e) {}
  }
}
