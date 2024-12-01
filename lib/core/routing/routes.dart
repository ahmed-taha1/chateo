enum Routes{
  onboardingView('/'),
  loginView('/login'),
  homeView('/home'),
  chatView('/chat');

  final String path;
  const Routes(this.path);
}