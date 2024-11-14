import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:smarthome_iot/core/common/global_setting/domain/usecase/global_info_usecases.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';

part 'global_info_event.dart';
part 'global_info_state.dart';

class GlobalInfoBloc extends Bloc<GlobalInfoEvent, GlobalInfoState> {
  final GlobalInfoUsecases usecase;
  GlobalInfoBloc(
    this.usecase,
  ) : super(GlobalInfoState()) {
    on<GetGlobalInfo>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: StatusState.loading));
          final currentLocale = await usecase.getLocale();
          printS(
              "[GlobalInfoBloc] - [GetGlobalInfo] currentLocale: $currentLocale");
          emit(state.copyWith(currentLocale: currentLocale));
        } catch (e) {
          printE("[GlobalInfoBloc] - [GetGlobalInfo] error: ${e.toString()}");
          emit(state.copyWith(
              status: StatusState.failure, errMsg: "error occured"));
        } finally {
          emit(state.copyWith(status: StatusState.idle));
        }
      },
    );

    on<SetSavedLangCode>(
      (event, emit) async {
        final isSuccess = await usecase.setSaveLangCode(event.langCode);
        if (isSuccess) {
          final currentLocale = await usecase.getLocale();
          emit(state.copyWith(currentLocale: currentLocale));
        }
      },
    );
  }
}
