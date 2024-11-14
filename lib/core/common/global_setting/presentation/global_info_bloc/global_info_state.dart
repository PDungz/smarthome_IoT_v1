// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_info_bloc.dart';

class GlobalInfoState extends Equatable {
  final StatusState status;
  final Locale? currentLocale;
  final String? errMsg;

  GlobalInfoState({
    this.status = StatusState.idle,
    this.currentLocale,
    this.errMsg,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [status, errMsg, currentLocale];

  GlobalInfoState copyWith({
    StatusState? status,
    Locale? currentLocale,
    String? errMsg,
  }) {
    return GlobalInfoState(
      status: status ?? this.status,
      currentLocale: currentLocale ?? this.currentLocale,
      errMsg: errMsg ?? this.errMsg,
    );
  }
}
