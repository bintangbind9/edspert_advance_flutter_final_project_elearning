part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class RegisterUserEvent extends UserEvent {
  final UserRegistrationReq userRegistrationReq;
  RegisterUserEvent({required this.userRegistrationReq});
}

class GetUserAppEvent extends UserEvent {
  final String email;
  GetUserAppEvent({required this.email});
}

class GetUserByEmailEvent extends UserEvent {
  final String email;
  GetUserByEmailEvent({required this.email});
}
