import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => AuthenticationStatePage();
}

class AuthenticationStatePage extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthWithToken()),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) {
          return previous.authStatus != current.authStatus ||
              current.isLoading == false;
        },
        listener: (context, state) {
          if (state.authStatus == AuthStatus.validToken) {
            Navigator.of(context).pushReplacementNamed('/home');
            return;
          }
          if (state.authStatus == AuthStatus.invalidToken) {
            Navigator.of(context).pushReplacementNamed('/login');
            return;
          }
        },
        buildWhen: (previous, current) {
          return previous.isLoading != current.isLoading &&
              previous.authStatus != current.authStatus;
        },
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
