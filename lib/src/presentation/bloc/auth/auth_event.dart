part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String name;
  final String gender;

  RegisterUserEvent({
    required this.email,
    required this.name,
    required this.gender,
  });
}
