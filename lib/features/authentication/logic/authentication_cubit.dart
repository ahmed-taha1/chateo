import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chateo/core/services/cache_service.dart';
import 'package:chateo/features/authentication/data/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepo authRepo;

  AuthenticationCubit(this.authRepo) : super(AuthenticationInitial());

  Future<void> loginViaEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthenticationLoading());
    try {
      await authRepo.loginWithEmailAndPassword(email: email, password: password);
      emit(AuthenticationLoginSuccess());
    } catch (e) {
      emit(AuthenticationFailed(e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthenticationLoading());
    try {
      if(await authRepo.loginWithGoogle()){
        emit(AuthenticationLoginSuccess());
      }
      else {
        log("Phone number missing");
        emit(AuthenticationLoginWithGooglePhoneNumberMissing());
      }
    } catch (e) {
      emit(AuthenticationFailed(e.toString()));
    }
  }

  Future<void> addPhoneNumberToGoogleAccount(String phoneNumber) async {
    emit(AuthenticationLoading());
    try {
      if(phoneNumber.isEmpty || await authRepo.isPhoneNumberExists(phoneNumber)){
        emit(const AuthenticationFailed("Phone number already exists"));
        return;
      }
      String userId = await CacheService.getData(key: CacheServiceConstants.userId);
      await authRepo.addPhoneNumberToGoogleAccount(userId, phoneNumber);
      emit(AuthenticationLoginWithGoogleSuccess());
    } catch (e) {
      emit(AuthenticationFailed(e.toString()));
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    emit(AuthenticationLoading());
    try {
      await authRepo.sendOtp(phoneNumber);
      emit(AuthenticationOtpSent());
    } catch (e) {
      emit(AuthenticationFailed(e.toString()));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(AuthenticationLoading());
    try {
      await authRepo.verifyOtp(otp);
      emit(AuthenticationLoginSuccess());
    } catch (e) {
      emit(AuthenticationFailed(e.toString()));
    }
  }

  Future<void> registerViaEmailAndPassword(
      {required String name,
      required String email,
      required String password,
      required String phoneNumber}) async {
    emit(AuthenticationLoading());
    try {
      if(name.isEmpty || email.isEmpty || password.isEmpty || phoneNumber.isEmpty) {
        emit(const AuthenticationFailed("Please fill all the fields"));
        return;
      }
      else if(password.length < 6) {
        emit(const AuthenticationFailed("Password must be at least 6 characters"));
        return;
      }
      else if(await authRepo.isPhoneNumberExists(phoneNumber)){
        emit(const AuthenticationFailed("Phone number already exists"));
        return;
      }
      await authRepo.createUserWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      emit(AuthenticationRegisterSuccess());
    } catch (e) {
      emit(AuthenticationFailed(e.toString()));
    }
  }
}
