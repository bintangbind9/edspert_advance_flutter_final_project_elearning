part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Sign In With Google
final class SignInWithGoogleLoading extends AuthState {}

final class SignInWithGoogleSuccess extends AuthState {
  final String email;

  SignInWithGoogleSuccess({required this.email});
}

final class SignInWithGoogleError extends AuthState {
  final String message;

  SignInWithGoogleError({required this.message});
}

// Sign Out
final class SignOutLoading extends AuthState {}

final class SignOutSuccess extends AuthState {}

final class SignOutError extends AuthState {
  final String message;
  SignOutError({required this.message});
}

// Is User Signed In
final class IsUserSignedInLoading extends AuthState {}

final class IsUserSignedInTrue extends AuthState {}

final class IsUserSignedInFalse extends AuthState {}
