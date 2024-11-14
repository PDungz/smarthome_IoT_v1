import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';
import 'package:smarthome_iot/features/profile/domain/entities/account_entity.dart';
import 'package:smarthome_iot/features/profile/domain/repositories/account_repository.dart';

part 'account_info_event.dart';
part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  final AccountRepository accountRepository;
  final ImagePicker _picker = ImagePicker();

  AccountInfoBloc(this.accountRepository) : super(const AccountInfoState()) {
    on<UpdateFullName>(
      (event, emit) {
        printS("[UpdateFullName] value: ${event.newName}");
        final localAccountInfo = state.upddateLocalAccountData;
        final updatedInfo = localAccountInfo.copyWith(fullName: event.newName);
        emit(state.copyWith(upddateLocalAccountData: updatedInfo));
      },
    );
    on<UpdatePhoneNum>(
      (event, emit) {
        printS("[UpdatePhoneNum] value: ${event.newPhoneNum}");
        final localAccountInfo = state.upddateLocalAccountData;
        final updatedInfo =
            localAccountInfo.copyWith(phoneNumber: event.newPhoneNum);
        emit(state.copyWith(upddateLocalAccountData: updatedInfo));
      },
    );
    on<UpdatePassWord>(
      (event, emit) {
        printS("[UpdatePassword] value: ${event.password}");
        final localAccountInfo = state.upddateLocalAccountData;
        final updatedInfo = localAccountInfo.copyWith(password: event.password);
        emit(state.copyWith(upddateLocalAccountData: updatedInfo));
      },
    );
    on<SaveInfo>(
      (event, emit) async {
        emit(state.copyWith(status: StatusState.loading));
        final localImageFile = state.updatedLocalImageFile;
        var localAccountInfo = state.upddateLocalAccountData;
        if (localImageFile != null) {
          final avatarUrl = await uploadImageToFirebase(
              userId: event.userId, imageFile: localImageFile);
          if (avatarUrl != null) {
            localAccountInfo = localAccountInfo.copyWith(avatarUrl: avatarUrl);
          }
        }
        printS("[SaveInfo] Info is ready to save: $localAccountInfo");
        await accountRepository.createOrUpdateAccountData(
            event.userId, localAccountInfo);
        emit(state.copyWithoutLocalImageFile(
            successMsg: "Lưu thông tin thành công", status: StatusState.idle));
        add(FetchAccountInfo(userId: event.userId));
      },
    );

    on<FetchAccountInfo>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: StatusState.loading));
          final result = await accountRepository.getAccountData(event.userId);
          emit(state.copyWith(
              accountDataFromFirestore: result,
              upddateLocalAccountData: const AccountEntity()));
          printS("FetchAccountInfo successfully: $result");
        } catch (e) {
          printE("[FetchAccountInfo] error: $e");
        } finally {
          emit(state.copyWith(status: StatusState.idle));
        }
      },
    );

    on<PickImage>(
      (event, emit) async {
        try {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            emit(state.copyWith(updatedLocalImageFile: File(pickedFile.path)));
          }
        } catch (e) {
          printE("[AccountInfoBloc] - [PickImage] error: $e");
          emit(state.copyWith(
              errorMsg: "Đã xảy ra lỗi, không thể lấy hình ảnh"));
        } finally {
          emit(state.copyWith(status: StatusState.idle));
        }
      },
    );
  }

  bool get canUpdate {
    final updatedAccountInfo = state.upddateLocalAccountData;
    final fullname = updatedAccountInfo.fullName;
    final phoneNum = updatedAccountInfo.phoneNumber;
    final password = updatedAccountInfo.password;
    final updatedLocalImageFile = state.updatedLocalImageFile;
    return fullname != null ||
        phoneNum != null ||
        password != null ||
        updatedLocalImageFile != null;
  }

  Future<String?> uploadImageToFirebase(
      {required String userId, required File imageFile}) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$userId');

      await storageReference.putFile(imageFile);
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      printE("Upload failed: $e");
      return null;
    }
  }
}
