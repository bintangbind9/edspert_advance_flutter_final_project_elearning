part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class IsUserSignedInEvent extends AuthEvent {}
