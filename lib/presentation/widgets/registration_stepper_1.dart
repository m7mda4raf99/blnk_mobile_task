import 'package:blnk_mobile_task/business_logic/cubit/registration_cubit.dart';
import 'package:blnk_mobile_task/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegistrationStepper1 extends StatelessWidget {
  RegistrationStepper1({super.key});

  List<Map<String, dynamic>> textFormFields = [
    {
      "name": "First Name",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.text
    },
    {
      "name": "Last Name",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.text
    },
    {
      "name": "Mobile Number",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.number
    },
    {
      "name": "Landline",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.number
    },
    {
      "name": "Email",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.emailAddress
    },
  ];

  RegistrationCubit? registrationCubit;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < textFormFields.length - 1; i++) {
      textFormFields[i]["next"] = textFormFields[i + 1]["focusNode"];
    }

    registrationCubit = BlocProvider.of<RegistrationCubit>(context);

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state is Stepper1Error) {
          textFormFields = state.textFormFields;
        } else if (state is StepperBack) {
          textFormFields[0]["controller"].text = state.user.firstName;
          textFormFields[1]["controller"].text = state.user.lastName;
          textFormFields[2]["controller"].text = state.user.mobileNumber;
          textFormFields[3]["controller"].text = state.user.landline;
          textFormFields[4]["controller"].text = state.user.email;
        }

        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Welcome! Let's get started by gathering some basic information about you. Please fill out the following fields.",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF777777),
                  ),
                ),
                const SizedBox(height: 20),
                for (var textFormField in textFormFields)
                  Column(
                    children: [
                      CustomTextField(field: textFormField),
                      const SizedBox(height: 20)
                    ],
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    registrationCubit?.stepper1Submitted(textFormFields);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 12),
                      backgroundColor: const Color(0xFF217FEB),
                      foregroundColor: Colors.white),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
