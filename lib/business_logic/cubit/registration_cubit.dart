import 'package:blnk_mobile_task/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  late User user;

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

    List<Map<String, dynamic>> userProfile = [
      {
        "value": ["${user.firstName} ${user.lastName}"],
      },
      {
        "value": [user.mobileNumber],
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

    emit(NationalIDBackUploaded(userProfile));
  }

  void stepper3Submitted(List<Map<String, dynamic>> textFormFields) {
    emit(RegistrationInitial());

    // call repository and api

    emit(Stepper3Completed());
  }
}
