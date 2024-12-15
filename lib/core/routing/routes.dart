enum Routes{
  onboardingView('/'),
  loginView('/login'),
  registerView('/register'),
  homeView('/home'),
  chatView('/chat');

  final String path;
  const Routes(this.path);
}