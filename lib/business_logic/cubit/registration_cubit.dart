import 'package:blnk_mobile_task/data/models/user.dart';
import 'package:blnk_mobile_task/data/repository/registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationRepository registrationRepository;
  RegistrationCubit(this.registrationRepository) : super(RegistrationInitial());

  late User user;

  List<Map<String, dynamic>> getUserProfile() {
    List<Map<String, dynamic>> userProfile = [
      {
        "value": ["${user.firstName} ${user.lastName}"],
      },
      {
        "value": [user.mobileNumber, user.landline],
      },
      {
        "value": [user.email],
      },
      {
        "value": [
          "${user.building} ${user.streetName}, ${user.area}, ${user.city}, Floor ${user.floor}, Apartment ${user.apartment}, Landmark ${user.landMark}"
        ],
      },
      {
        "value": [user.nationalIDFront!.path, user.nationalIDBack!.path],
      },
    ];

    return userProfile;
  }

  void stepper1Submitted(List<Map<String, dynamic>> textFormFields) {
    emit(RegistrationInitial());

    if (textFormFields
        .every((element) => element["key"].currentState!.validate())) {
      user = User();

      user.firstName = textFormFields[0]["controller"].text;
      user.lastName = textFormFields[1]["controller"].text;
      user.mobileNumber = textFormFields[2]["controller"].text;
      user.landline = textFormFields[3]["controller"].text;
      user.email = textFormFields[4]["controller"].text;

      emit(Stepper1Completed());
    } else {
      emit(Stepper1Error(textFormFields));
    }
  }

  void stepper2Submitted(List<Map<String, dynamic>> textFormFields) {
    emit(RegistrationInitial());

    if (textFormFields
        .every((element) => element["key"].currentState!.validate())) {
      user.apartment = textFormFields[0]["controller"].text;
      user.floor = textFormFields[1]["controller"].text;
      user.building = textFormFields[2]["controller"].text;
      user.streetName = textFormFields[3]["controller"].text;
      user.area = textFormFields[4]["controller"].text;
      user.city = textFormFields[5]["controller"].text;
      user.landMark = textFormFields[6]["controller"].text;

      emit(Stepper2Completed(textFormFields));
    } else {
      emit(Stepper2Error(textFormFields));
    }
  }

  void back() {
    emit(StepperBack(user));
  }

  void uploadNationalIDFront(XFile? file) {
    emit(RegistrationInitial());
    user.nationalIDFront = file;
    emit(NationalIDFrontUploaded());
  }

  void uploadNationalIDBack(XFile? file) {
    emit(RegistrationInitial());
    user.nationalIDBack = file;

    emit(NationalIDBackUploaded(getUserProfile()));
  }

  void stepper3Submitted() async {
    emit(Stepper3Loading(getUserProfile()));

    Map<String, dynamic> drive = await registrationRepository.uploadToDrive(
        user.nationalIDFront!.path, user.nationalIDBack!.path);

    String error = drive["nationalIDFront"].toString().startsWith('Error')
        ? drive["nationalIDFront"]
        : drive["nationalIDBack"].toString().startsWith('Error')
            ? drive["nationalIDBack"]
            : 'Success';

    if (error == 'Success') {
      String spreadSheet = await registrationRepository.uploadToSpreadSheet([
        "${user.firstName} ${user.lastName}",
        user.mobileNumber!,
        user.landline!,
        user.email!,
        "${user.building} ${user.streetName}, ${user.area}, ${user.city}, Floor ${user.floor}, Apartment ${user.apartment}, Landmark ${user.landMark}",
        drive["nationalIDFront"],
        drive["nationalIDBack"]
      ]);

      if (spreadSheet == 'User Registered Successfully') {
        emit(Stepper3Completed());
      } else {
        emit(Stepper3Error('Error uploading user information to spreadsheet.',
            getUserProfile()));
      }
    } else {
      emit(Stepper3Error(
          'Error uploading images to drive: $error', getUserProfile()));
    }
  }
}
