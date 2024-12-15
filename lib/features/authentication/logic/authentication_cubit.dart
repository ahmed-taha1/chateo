import 'package:bloc/bloc.dart';
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
      await authRepo.loginWithGoogle();
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
