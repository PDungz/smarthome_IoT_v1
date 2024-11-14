import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/features/login/domain/repositories/auth_repository.dart';
import '../../../../../core/services/logger_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc(
    this.repository,
  ) : super(LoginState()) {
    on<loginWithPhoneNumberPassword>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusState.loading));
        final isLoginSuccess = await repository.loginWithPhoneNumberPassword(
            phoneNumber: event.phoneNumber, password: event.password);
        if (isLoginSuccess) {
          emit(state.copyWith(
              canNavigateToEntryScreen: true, status: StatusState.success));
        } else {
          throw Exception("Unable to login with Username and Password");
        }
      } catch (e) {
        printE("[LoginBloc] - [LoginWithUsernameAndPassword] error: $e");
        emit(state.copyWith(
            errorMsg: "Không thể đăng nhập, vui lòng thử lại sau",
            status: StatusState.failure));
      } finally {
        emit(state.copyWith(status: StatusState.idle));
      }
    });
  }
}
