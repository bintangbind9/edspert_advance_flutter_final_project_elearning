part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

// Register User
final class RegisterUserLoading extends UserState {}

final class RegisterUserSuccess extends UserState {
  final UserModel userModel;
  RegisterUserSuccess({required this.userModel});
}

final class RegisterUserError extends UserState {
  final String message;
  RegisterUserError({required this.message});
}

// Get User App
final class GetUserAppLoading extends UserState {}

final class GetUserAppSuccess extends UserState {
  final UserModel userModel;
  GetUserAppSuccess({required this.userModel});
}

final class GetUserAppInternalError extends UserState {
  final String message;
  GetUserAppInternalError({required this.message});
}

final class GetUserAppApiError extends UserState {
  final String message;
  GetUserAppApiError({required this.message});
}

// Get User by Email
final class GetUserByEmailLoading extends UserState {}

final class GetUserByEmailSuccess extends UserState {
  final UserModel userModel;
  GetUserByEmailSuccess({required this.userModel});
}

final class GetUserByEmailError extends UserState {
  final String message;
  GetUserByEmailError({required this.message});
}

// Update User
final class UpdateUserLoading extends UserState {}

final class UpdateUserSuccess extends UserState {
  final UserModel userModel;
  UpdateUserSuccess({required this.userModel});
}

final class UpdateUserApiError extends UserState {
  final String message;
  UpdateUserApiError({required this.message});
}

final class UpdateUserInternalError extends UserState {
  final String message;
  UpdateUserInternalError({required this.message});
}
