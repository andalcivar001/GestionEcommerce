import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  final LoginBloc? _bloc;
  final LoginState _state;

  const LoginContent(this._bloc, this._state, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffEAF2FF), Color(0xffF7FAFF), Color(0xffFFFFFF)],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -50,
              right: -10,
              child: _BackgroundShape(
                size: 170,
                colors: [Color(0xffD9E7FF), Color(0xffEDF4FF)],
              ),
            ),
            const Positioned(
              bottom: -70,
              left: -20,
              child: _BackgroundShape(
                size: 210,
                colors: [Color(0xffDDEBFF), Color(0xffF5F9FF)],
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffDCE6F8)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff24408E).withValues(alpha: 0.14),
                          blurRadius: 32,
                          spreadRadius: -12,
                          offset: const Offset(0, 22),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _state.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _TopBanner(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _FieldLabel(
                                  title: 'Correo electronico',
                                  subtitle:
                                      'Ingresa el correo asociado a tu cuenta.',
                                ),
                                const SizedBox(height: 10),
                                _textEmail(),
                                const SizedBox(height: 18),
                                _FieldLabel(
                                  title: 'Contrasena',
                                  subtitle:
                                      'Escribe tu clave para entrar al panel.',
                                ),
                                const SizedBox(height: 10),
                                _textPassword(),
                                const SizedBox(height: 24),
                                _buttonEntrar(),
                                const SizedBox(height: 16),
                                _buildFooter(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xffF8FBFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffE2EAF8)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xffEEF4FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.person_add_alt_1_outlined,
              color: Color(0xff3154F6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Aun no tienes cuenta?',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13.5,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(
                        color: Color(0xff173A7A),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textEmail() {
    return DefaultTextField(
      label: 'Correo electronico',
      hinText: 'ejemplo@correo.com',
      icon: Icons.email_outlined,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      onChanged: (text) {
        _bloc?.add(EmailChangedLoginEvent(email: BlocFormItem(value: text)));
      },
      validator: (value) {
        return _state.email.error;
      },
    );
  }

  Widget _textPassword() {
    return DefaultTextField(
      label: 'Contrasena',
      hinText: 'Ingresa tu contrasena',
      icon: Icons.lock_outline_rounded,
      validator: (value) {
        return _state.password.error;
      },
      obscureText: true,
      autofillHints: const [AutofillHints.password],
      textInputAction: TextInputAction.go,
      onChanged: (text) {
        _bloc?.add(
          PasswordChangedLoginEvent(password: BlocFormItem(value: text)),
        );
      },
    );
  }

  Widget _buttonEntrar() {
    return DefaultButton(
      text: 'Entrar',
      onPressed: () {
        if (_state.formKey!.currentState!.validate()) {
          _bloc?.add(SubmittedLoginEvent());
        } else {
          AppToast.error('Formulario invalido');
        }
      },
    );
  }
}

class _TopBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 22),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff163674), Color(0xff2558D9), Color(0xff5A95FF)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withValues(alpha: 0.16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            ),
            child: const Icon(
              Icons.lock_person_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Iniciar sesion',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Accede rapidamente a tu panel administrativo con un diseno limpio y directo.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.86),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _BannerChip(icon: Icons.flash_on_rounded, text: 'Acceso rapido'),
              _BannerChip(
                icon: Icons.security_rounded,
                text: 'Ingreso seguro',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String title;
  final String subtitle;

  const _FieldLabel({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: const Color(0xff102A43),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xff64748B),
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _BannerChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BannerChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundShape extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const _BackgroundShape({required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
