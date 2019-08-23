import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.dispatch(LoginFetchSettings());

    _onLoginButtonPressed() {
      loginBloc.dispatch(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSettingsLoaded) {
//            _usernameController.text = 'user@e154.ru';
//            _passwordController.text = 'user';
            _usernameController.text = state.credentials.userLogin;
            _passwordController.text = state.credentials.userPassword;
          }

          return Form(
            child: state is LoginLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'username'),
                        controller: _usernameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'password'),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      RaisedButton(
                        onPressed: state is! LoginLoading
                            ? _onLoginButtonPressed
                            : null,
                        child: Text('Login'),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}