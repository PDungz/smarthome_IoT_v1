// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_info_bloc.dart';

class AccountInfoState extends Equatable {
  final StatusState status;
  final AccountEntity? accountDataFromFirestore;
  final AccountEntity upddateLocalAccountData;
  final String? successMsg;
  final String? errorMsg;
  final File? updatedLocalImageFile;

  const AccountInfoState({
    this.status = StatusState.idle,
    this.accountDataFromFirestore,
    this.upddateLocalAccountData = const AccountEntity(),
    this.successMsg,
    this.errorMsg,
    this.updatedLocalImageFile,
  });

  @override
  List<Object?> get props {
    return [
      status,
      accountDataFromFirestore,
      upddateLocalAccountData,
      successMsg,
      errorMsg,
      updatedLocalImageFile,
    ];
  }

  AccountInfoState copyWith({
    StatusState? status,
    AccountEntity? accountDataFromFirestore,
    AccountEntity? upddateLocalAccountData,
    String? successMsg,
    String? errorMsg,
    File? updatedLocalImageFile,
  }) {
    return AccountInfoState(
      status: status ?? this.status,
      accountDataFromFirestore:
          accountDataFromFirestore ?? this.accountDataFromFirestore,
      upddateLocalAccountData:
          upddateLocalAccountData ?? this.upddateLocalAccountData,
      successMsg: successMsg,
      errorMsg: errorMsg,
      updatedLocalImageFile:
          updatedLocalImageFile ?? this.updatedLocalImageFile,
    );
  }

  AccountInfoState copyWithoutLocalImageFile({
    StatusState? status,
    AccountEntity? accountDataFromFirestore,
    AccountEntity? upddateLocalAccountData,
    String? successMsg,
    String? errorMsg,
    File? updatedLocalImageFile,
  }) {
    return AccountInfoState(
      status: status ?? this.status,
      accountDataFromFirestore:
          accountDataFromFirestore ?? this.accountDataFromFirestore,
      upddateLocalAccountData:
          upddateLocalAccountData ?? this.upddateLocalAccountData,
      successMsg: successMsg,
      errorMsg: errorMsg,
      updatedLocalImageFile: updatedLocalImageFile,
    );
  }
}
