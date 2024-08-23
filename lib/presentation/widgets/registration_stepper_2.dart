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
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Floor",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Building",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Street Name",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
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
      "key": GlobalKey<FormFieldState>()
    },
  ];

  RegistrationCubit? registrationCubit;

  @override
  Widget build(BuildContext context) {
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
