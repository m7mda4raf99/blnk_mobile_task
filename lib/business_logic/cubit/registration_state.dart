part of 'registration_cubit.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class Stepper1Completed extends RegistrationState {}

final class Stepper1Error extends RegistrationState {
  final List<Map<String, dynamic>> textFormFields;
  Stepper1Error(this.textFormFields);
}

final class Stepper2Completed extends RegistrationState {
  final List<Map<String, dynamic>> textFormFields;
  Stepper2Completed(this.textFormFields);
}

final class Stepper2Error extends RegistrationState {
  final List<Map<String, dynamic>> textFormFields;
  Stepper2Error(this.textFormFields);
}

final class NationalIDFrontUploaded extends RegistrationState {}

final class NationalIDBackUploaded extends RegistrationState {
  final List<Map<String, dynamic>> userProfile;
  NationalIDBackUploaded(this.userProfile);
}

final class Stepper3Completed extends RegistrationState {}

final class Stepper3Error extends RegistrationState {
  final String errorMessage;
  final List<Map<String, dynamic>> userProfile;
  Stepper3Error(this.errorMessage, this.userProfile);
}

final class StepperBack extends RegistrationState {
  final User user;
  StepperBack(this.user);
}
