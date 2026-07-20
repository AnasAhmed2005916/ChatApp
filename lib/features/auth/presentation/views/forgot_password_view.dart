import 'package:chat_app/core/helpers/validators.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/core/utils/assets.dart';
import 'package:chat_app/core/widgets/app_spacing.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/widgets/custom_auth_button.dart';
import 'package:chat_app/features/auth/presentation/widgets/custom_auth_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "If an account exists for this email, a password reset link has been sent.",
              ),
            ),
          );
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 30,
              centerTitle: true,
              title: Text(
                'Forgot Password',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.appLogo, width: 200, height: 200),
                        Text(
                          'Forgot Password',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const VerticalSpace(10),
                        Text(
                          "Enter your email address and we'll send you a password reset link.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const VerticalSpace(20),
                        CustomAuthTextFormField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email),
                          validator: AppValidators.email,
                        ),
                        const VerticalSpace(20),
                        CustomAuthButton(
                          text: state is AuthLoading
                              ? 'Sending...'
                              : 'Send Reset Link',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().forgotPassword(
                                email: emailController.text.trim(),
                              );
                            }
                          },
                        ),
                        const VerticalSpace(8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            child: Text(
                              'Back to Login',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            onTap: () {
                              context.go(AppRoutes.login);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
