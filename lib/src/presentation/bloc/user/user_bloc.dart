import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user_model/user_model.dart';
import '../../../domain/entities/user_model/user_registration_req.dart';
import '../../../domain/usecases/get_user_by_email_usecase.dart';
import '../../../domain/usecases/register_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RegisterUserUsecase registerUserUsecase;
  final GetUserByEmailUsecase getUserByEmailUsecase;

  UserBloc({
    required this.registerUserUsecase,
    required this.getUserByEmailUsecase,
  }) : super(UserInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterUserLoading());

      final responseModel =
          await registerUserUsecase(event.userRegistrationReq);

      if (responseModel != null) {
        if (responseModel.data != null) {
          emit(RegisterUserSuccess(userModel: responseModel.data!));
        } else {
          emit(RegisterUserError(
            message: responseModel.message ?? 'Register User Failed',
          ));
        }
      } else {
        emit(RegisterUserError(
          message: 'Oops! Register User Failed. Something went wrong.',
        ));
      }
    });

    on<GetUserAppEvent>((event, emit) async {
      emit(GetUserAppLoading());

      final responseModel = await getUserByEmailUsecase(event.email);

      if (responseModel != null) {
        if (responseModel.status == 1 && responseModel.data != null) {
          emit(GetUserAppSuccess(userModel: responseModel.data!));
        } else {
          emit(GetUserAppApiError(
            message: responseModel.message ?? 'Get User App Failed',
          ));
        }
      } else {
        emit(GetUserAppInternalError(
          message: 'Oops! Get User App Failed. Something went wrong.',
        ));
      }
    });

    on<GetUserByEmailEvent>((event, emit) async {
      emit(GetUserByEmailLoading());

      final responseModel = await getUserByEmailUsecase(event.email);

      if (responseModel != null) {
        if (responseModel.status == 1 && responseModel.data != null) {
          emit(GetUserByEmailSuccess(userModel: responseModel.data!));
        } else {
          emit(GetUserByEmailError(
            message: responseModel.message ?? 'Get User Failed',
          ));
        }
      } else {
        emit(GetUserByEmailError(
          message: 'Oops! Get User Failed. Something went wrong.',
        ));
      }
    });
  }
}
