import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../stores/login_store.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_field.dart';
import 'list_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginStore loginStore;

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginStore = Provider.of<LoginStore>(context);

    //maneira 1 de trocar de tela

    // autorun((_) {
    //   print(loginStore.loggedIn);
    //   if (loginStore.loggedIn) {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => ListScreen()));
    //   }
    // });

    //maneira 2 de trocar de tela
    //só executa quando tem a troca do valor
    //disposer pra não fica rodando infinitamente
    disposer = reaction(
      (_) => loginStore.loggedIn,
      (loggedIn) {
        if (loggedIn != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ListScreen()));
        }
      },
    );
  }

  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return CustomTextField(
                        obscure: false,
                        hint: 'E-mail',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        //passa a função sem os parametros
                        onChanged: loginStore.setEmail,
                        enabled: !loginStore.loading,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(
                      builder: (_) {
                        return CustomTextField(
                          hint: 'Senha',
                          prefix: Icon(
                            Icons.lock,
                          ),
                          obscure: !loginStore.passwordVisible,
                          //passa a função sem os parametros sem o ()
                          onChanged: loginStore.setPassword,
                          enabled: !loginStore.loading,
                          suffix: CustomIconButton(
                            radius: 32,
                            iconData: loginStore.passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onTap: loginStore.togglePasswordVisibility,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //o Observer vai notar que tem um computed aqui dentro
                    //sempre que modifica o estado, o observer vai refazer a parte
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onSurface:
                                Theme.of(context).primaryColor.withAlpha(100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                          ),
                          onPressed: loginStore.isFormValid
                              ? () {
                                  loginStore.login();
                                  // Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ListScreen()));
                                }
                              : null,
                          child: loginStore.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),

                        // disabledColor:
                        //     Theme.of(context).primaryColor.withAlpha(100),
                      );
                    })
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
