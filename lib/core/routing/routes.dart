enum Routes{
  onboardingView('/'),
  loginView('/login'),
  registerView('/register'),
  homeView('/home'),
  addNumberView('/addNumberView'),
  loginWithPhoneNumber('/loginWithPhoneNumber'),
  chatView('/chat');

  final String path;
  const Routes(this.path);
}