import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Error) {
            AppToast.error(responseState.message);
          } else if (responseState is Success) {
            final authResponse = responseState.data as AuthResponse;
            _bloc?.add(SaveUserSessionLoginEvent(authResponse: authResponse));
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
            });
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final responseState = state.response;
            if (responseState is Loading) {
              return Stack(
                children: [
                  LoginContent(_bloc, state),
                  Container(
                    color: Colors.black.withValues(alpha: 0.18),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ],
              );
            }
            return LoginContent(_bloc, state);
          },
        ),
      ),
    );
  }
}
