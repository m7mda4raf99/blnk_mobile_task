import 'package:blnk_mobile_task/business_logic/cubit/registration_cubit.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final int activeStep;
  final RegistrationCubit registrationCubit;
  const CustomAppBar(
      {super.key, required this.activeStep, required this.registrationCubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        activeStep > 0
            ? FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                onPressed: () {
                  registrationCubit.back();
                },
                child: const Icon(Icons.arrow_back_outlined),
              )
            : const SizedBox(width: 55, height: 55),
        const Text('Create Account',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        const SizedBox(width: 55, height: 55),
      ],
    );
  }
}
