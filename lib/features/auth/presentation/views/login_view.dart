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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRoutes.home);
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 30,
            centerTitle: true,
            title: Text(
              'Login',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VerticalSpace(30),
                      Image.asset(Assets.appLogo, width: 200, height: 200),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Sign in to continue chatting',
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
                      const VerticalSpace(15),
                      CustomAuthTextFormField(
                        controller: passwordController,

                        hintText: 'Password',
                        obscureText: !isPasswordVisible,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: AppValidators.password,
                      ),
                      const VerticalSpace(24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.push(AppRoutes.forgotPassword);
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const VerticalSpace(20),
                      InkWell(
                        onTap: () {
                          context.go(AppRoutes.register);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: "Register",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const VerticalSpace(48),
                      CustomAuthButton(
                        text: state is AuthLoading ? 'Loading...' : 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                    ],
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
    passwordController.dispose();
    super.dispose();
  }
}
