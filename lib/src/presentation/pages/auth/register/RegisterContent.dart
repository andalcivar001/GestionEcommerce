import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class RegisterContent extends StatelessWidget {
  RegisterBloc? _bloc;
  RegisterState _state;

  RegisterContent(this._bloc, this._state, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffF2F6FF), Color(0xffFCFDFF), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -72,
              right: -18,
              child: _BackgroundOrb(
                size: 184,
                colors: [Color(0xffD8E7FF), Color(0xffEEF4FF)],
              ),
            ),
            const Positioned(
              top: 230,
              left: -54,
              child: _BackgroundOrb(
                size: 132,
                colors: [Color(0xffE7F8F1), Color(0xffF7FCF9)],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 72, 22, 28),
              child: Form(
                key: _state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroCard(state: _state),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xffD8E4F5)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xff1D4ED8,
                            ).withValues(alpha: 0.10),
                            blurRadius: 28,
                            spreadRadius: -12,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informacion personal',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: const Color(0xff0F172A),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Completa tus datos para crear una cuenta moderna, segura y lista para comprar.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: const Color(0xff64748B),
                                  height: 1.4,
                                ),
                          ),
                          const SizedBox(height: 24),
                          _FieldBlock(
                            label: 'Nombre completo',
                            child: _textNombre(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Correo electronico',
                            child: _textEmail(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Telefono',
                            child: _textTelefono(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Contrasena',
                            child: _textPassword(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Confirmar contrasena',
                            child: _textConfirmPassword(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Fecha de nacimiento',
                            child: _textFechaNacimiento(context),
                          ),
                          const SizedBox(height: 26),
                          _buttonCrear(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 6,
              left: 0,
              child: DefaultIconBack(left: 18, top: 5, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textNombre() {
    return DefaultTextField(
      label: 'Nombre',
      icon: Icons.person_outline_rounded,
      textInputType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      hinText: 'Ej: Maria Lopez',
      onChanged: (text) {
        _bloc?.add(NameChangedRegisterEvent(nombre: BlocFormItem(value: text)));
      },
      validator: (value) {
        return _state.nombre.error;
      },
    );
  }

  Widget _textEmail() {
    return DefaultTextField(
      label: 'Correo electronico',
      icon: Icons.mail_outline_rounded,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      textInputType: TextInputType.emailAddress,
      hinText: 'correo@ejemplo.com',
      onChanged: (text) {
        _bloc?.add(EmailChangedRegisterEvent(email: BlocFormItem(value: text)));
      },
      validator: (value) {
        return _state.email.error;
      },
    );
  }

  Widget _textTelefono() {
    return DefaultTextField(
      label: 'Telefono',
      icon: Icons.phone_outlined,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      textInputType: TextInputType.phone,
      hinText: '0987654321',
      onChanged: (text) {
        _bloc?.add(
          TelefonoChangedRegisterEvent(telefono: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return _state.telefono.error;
      },
    );
  }

  Widget _textPassword() {
    return DefaultTextField(
      label: 'Contrasena',
      icon: Icons.lock_outline_rounded,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.newPassword],
      obscureText: true,
      hinText: 'Minimo 6 caracteres',
      validator: (value) {
        return _state.password.error;
      },
      onChanged: (text) {
        _bloc?.add(
          PasswordChangedRegisterEvent(password: BlocFormItem(value: text)),
        );
      },
    );
  }

  Widget _textConfirmPassword() {
    return DefaultTextField(
      label: 'Confirmar contrasena',
      icon: Icons.lock_person_outlined,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.password],
      obscureText: true,
      hinText: 'Repite tu contrasena',
      validator: (value) {
        return _state.confirmPassword.error;
      },
      onChanged: (text) {
        _bloc?.add(
          ConfirmPasswordChangedRegisterEvent(
            confirmPassword: BlocFormItem(value: text),
          ),
        );
      },
    );
  }

  Widget _textFechaNacimiento(BuildContext context) {
    final controller = TextEditingController(
      text: _state.fechaNacimiento.value,
    );

    return DefaultTextField(
      label: 'Fecha de nacimiento',
      icon: Icons.calendar_month_outlined,
      controller: controller,
      readOnly: true,
      hinText: 'Selecciona una fecha',
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (picked == null) return;

        final formatted =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

        _bloc?.add(
          FechaNacimientoChangedRegisterEvent(
            fechaNacimiento: BlocFormItem(value: formatted),
          ),
        );
      },
      validator: (_) => _state.fechaNacimiento.error,
    );
  }

  Widget _buttonCrear() {
    return DefaultButton(
      text: 'Crear cuenta',
      onPressed: () {
        if (_state.formKey!.currentState!.validate()) {
          _bloc?.add(SubmittedRegisterEvent());
        } else {
          AppToast.error('Formulario invalido');
        }
      },
    );
  }
}

class _HeroCard extends StatelessWidget {
  final RegisterState state;

  const _HeroCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final hasEmail = state.email.value.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff0F3DDE), Color(0xff2563EB), Color(0xff6CA7FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2563EB).withValues(alpha: 0.26),
            blurRadius: 30,
            spreadRadius: -10,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Crea tu cuenta',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasEmail
                ? 'Estas a un paso de registrarte con ${state.email.value.trim()}.'
                : 'Organiza tu perfil, guarda tus datos y empieza a comprar con una experiencia mas cuidada.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _InfoChip(text: 'Acceso rapido'),
              _InfoChip(text: 'Datos seguros'),
              _InfoChip(text: 'Perfil listo'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FieldBlock extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldBlock({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: const Color(0xff1E293B),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String text;

  const _InfoChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _BackgroundOrb extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const _BackgroundOrb({required this.size, required this.colors});

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
