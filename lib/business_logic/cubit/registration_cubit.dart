import 'package:blnk_mobile_task/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      print(user.toJson());

      emit(Stepper2Completed());
    } else {
      emit(Stepper2Error(textFormFields));
    }
  }

  void back() {
    emit(StepperBack(user));
  }
}
