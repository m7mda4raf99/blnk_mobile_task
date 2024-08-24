import 'package:blnk_mobile_task/business_logic/cubit/registration_cubit.dart';
import 'package:blnk_mobile_task/presentation/widgets/view_user_data.dart';
import 'package:blnk_mobile_task/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

// ignore: must_be_immutable
class RegistrationStepper3 extends StatelessWidget {
  RegistrationStepper3({super.key});

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  List<Map<String, dynamic>> userProfile = [
    {
      "title": "Full Name",
      "value": ["John Doe"],
      "icon": ImageConstant.user
    },
    {
      "title": "Phone Number",
      "value": ["1234567890"],
      "icon": ImageConstant.phone
    },
    {
      "title": "Email Address",
      "value": ["johndoe@gmail.com"],
      "icon": ImageConstant.email
    },
    {
      "title": "Home Address",
      "value": ["123 Main Street, New York, NY 10010"],
      "icon": ImageConstant.address
    },
    {
      "title": "National ID",
      "value": ["1234567890", "1234567890"],
      "icon": ImageConstant.nationalID
    },
  ];

  RegistrationCubit? registrationCubit;

  @override
  Widget build(BuildContext context) {
    registrationCubit = BlocProvider.of<RegistrationCubit>(context);

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state is NationalIDBackUploaded) {
          for (var i = 0; i < userProfile.length; i++) {
            userProfile[i]["value"] = state.userProfile[i]["value"];
          }
        } else if (state is Stepper3Completed) {
          _btnController.reset();
        } else if (state is Stepper3Error) {
          _btnController.reset();

          for (var i = 0; i < userProfile.length; i++) {
            userProfile[i]["value"] = state.userProfile[i]["value"];
          }
        }

        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var userProfile in userProfile)
                  Column(
                    children: [
                      ViewUserData(userProfile: userProfile),
                      const SizedBox(height: 20),
                    ],
                  ),
                const SizedBox(height: 10),
                RoundedLoadingButton(
                  controller: _btnController,
                  onPressed: () {
                    registrationCubit?.stepper3Submitted();
                  },
                  child: const Text('Submit',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
