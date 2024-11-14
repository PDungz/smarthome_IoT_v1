import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(
    this.userRepository,
  ) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
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
}
