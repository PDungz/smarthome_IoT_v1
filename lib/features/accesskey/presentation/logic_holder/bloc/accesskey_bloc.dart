import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/features/accesskey/domain/repositories/accesskey_repository.dart';

import '../../../../../core/enums/status_state.dart';
import '../../../domain/entities/accesskey.dart';

part 'accesskey_event.dart';
part 'accesskey_state.dart';

class AccessKeyBloc extends Bloc<AccessKeyEvent, AccessKeyState> {
  final AccessKeyRepository accessKeyRepository;

  AccessKeyBloc(this.accessKeyRepository) : super(AccessKeyInitial()) {
    on<LoadAccessKey>(_onLoadAccessKey);
    on<PostAccessKey>(_onPostAccessKey);
  }
  Future<void> _onLoadAccessKey(
      LoadAccessKey event, Emitter<AccessKeyState> emit) async {
    emit(AccessKeyLoading());
    try {
      final accessKeys = await accessKeyRepository.getAccessKeys();
      emit(AccessKeyLoaded(accesskey: accessKeys ?? []));
    } catch (e) {
      emit(AccessKeyError(Msg: "Failed to load accessKeys: ${e.toString()}"));
    }
  }

  Future<void> _onPostAccessKey(
      PostAccessKey event, Emitter<AccessKeyState> emit) async {
    emit(AccessKeyPost(status: StatusState.loading));
    try {
      final success = await accessKeyRepository.postAccessKey();
      if (success) {
        emit(AccessKeyPost(
            status: StatusState.success, Msg: "AccessKey added successfully"));
      } else {
        emit(AccessKeyPost(
            status: StatusState.failure, Msg: "Failed to add AccessKey"));
      }
    } catch (e) {
      emit(AccessKeyPost(
          status: StatusState.failure, Msg: "Error: ${e.toString()}"));
    }
  }
}
