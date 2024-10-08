import 'package:blnk_mobile_task/business_logic/cubit/registration_cubit.dart';
import 'package:blnk_mobile_task/presentation/widgets/custom_dropdown_field.dart';
import 'package:blnk_mobile_task/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegistrationStepper2 extends StatelessWidget {
  RegistrationStepper2({super.key});

  List<Map<String, dynamic>> textFormFields = [
    {
      "name": "Apartment",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.number
    },
    {
      "name": "Floor",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.number
    },
    {
      "name": "Building",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.number
    },
    {
      "name": "Street Name",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.text
    },
    {
      "name": "Area",
      "isDropdown": true,
      "items": [
        'Zamalek',
        'Maadi',
        'Heliopolis',
        'Nasr City',
        'Giza',
        'Mohandessin'
      ],
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "City",
      "isDropdown": true,
      "items": [
        'Cairo',
        'Alexandria',
        'Giza',
        'Luxor',
        'Aswan',
        'Sharm El-Sheikh'
      ],
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Land Mark",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>(),
      "type": TextInputType.text
    },
  ];

  RegistrationCubit? registrationCubit;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 3; i++) {
      textFormFields[i]["next"] = textFormFields[i + 1]["focusNode"];
    }

    registrationCubit = BlocProvider.of<RegistrationCubit>(context);

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state is Stepper2Error) {
          textFormFields = state.textFormFields;
        } else if (state is StepperBack) {
          textFormFields[0]["controller"].text = state.user.apartment;
          textFormFields[1]["controller"].text = state.user.floor;
          textFormFields[2]["controller"].text = state.user.building;
          textFormFields[3]["controller"].text = state.user.streetName;
          textFormFields[4]["controller"].text = state.user.area;
          textFormFields[5]["controller"].text = state.user.city;
          textFormFields[6]["controller"].text = state.user.landMark;
        } else if (state is Stepper2Completed) {
          textFormFields[0]["controller"].text =
              state.textFormFields[0]["controller"].text;
          textFormFields[1]["controller"].text =
              state.textFormFields[1]["controller"].text;
          textFormFields[2]["controller"].text =
              state.textFormFields[2]["controller"].text;
          textFormFields[3]["controller"].text =
              state.textFormFields[3]["controller"].text;
          textFormFields[4]["controller"].text =
              state.textFormFields[4]["controller"].text;
          textFormFields[5]["controller"].text =
              state.textFormFields[5]["controller"].text;
          textFormFields[6]["controller"].text =
              state.textFormFields[6]["controller"].text;
        }

        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CustomTextField(field: textFormFields[i]),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(field: textFormFields[3]),
                const SizedBox(height: 20),
                Row(
                  children: [
                    for (int i = 4; i < 6; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CustomDropdownField(field: textFormFields[i]),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(field: textFormFields[6]),
                const SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () {
                    registrationCubit?.stepper2Submitted(textFormFields);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 12),
                    backgroundColor: const Color(0xFF217FEB),
                    foregroundColor: Colors.white,
                  ),
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
