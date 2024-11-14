import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';

import '../../../../entry_point/domain/entities/user.dart';
import '../../../../entry_point/domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(
    this.userRepository,
  ) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUser();
      emit(UserLoaded(user: user!));
    } catch (e) {
      emit(UserError(Msg: e.toString()));
      printE("Error: $e");
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserUpdated(status: StatusState.loading));
    try {
      final success = await userRepository.putUser(event.user, event.password);
      print(success);
      if (success) {
        emit(UserUpdated(status: StatusState.success));
      } else {
        throw Exception("Unable to Update with user and password");
      }
    } catch (e) {
      printE("[UserBloc] - [UpdateUser] error: $e");
      emit(UserUpdated(status: StatusState.failure));
    } finally {
      emit(UserUpdated(status: StatusState.idle));
    }
  }
}
