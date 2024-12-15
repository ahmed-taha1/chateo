part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}
final class AuthenticationLoading extends AuthenticationState {}
final class AuthenticationLoginSuccess extends AuthenticationState {}
final class AuthenticationLoginWithGoogleSuccess extends AuthenticationState {}
final class AuthenticationLoginWithGooglePhoneNumberMissing extends AuthenticationState {}
final class AuthenticationRegisterSuccess extends AuthenticationState {}
final class AuthenticationOtpSent extends AuthenticationState {}
final class AuthenticationFailed extends AuthenticationState {
  final String message;
  const AuthenticationFailed(this.message);
  @override
  List<Object> get props => [message];
}
