enum Routes{
  onboardingView('/'),
  loginView('/login'),
  homeView('/home'),
  registerView('/register');

  final String path;
  const Routes(this.path);
}