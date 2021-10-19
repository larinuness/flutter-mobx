import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    //autorun é reação que vai ter sempre que tiver algum dado lido/mudado no observer
    //aparece no terminar
    // autorun((_) {
    //   print(isFormValid);
    // });
  }

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  void setPassword(String value) => password = value;

  @action
  Future<void> login() async {
    loading = true;
    //processa dados
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    loggedIn = true;
    email = "";
    password = "";
  }

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  //sempre que tiver um computed usar um getter
  @computed
  bool get isFormValid => isPasswordValid && isEmailValid;

  @action
  void logout() {
    loggedIn = false;
  }
}
