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

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRoutes.emailVerification);
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
              'Register',
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
                      const VerticalSpace(20),
                      Text(
                        'Sign up to start chatting with your friends :)',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      const VerticalSpace(20),
                      CustomAuthTextFormField(
                        controller: nameController,
                        hintText: 'Full name',
                        obscureText: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.person),
                        validator: AppValidators.name,
                      ),
                      const VerticalSpace(15),

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
                        textInputAction: TextInputAction.next,
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
                      const VerticalSpace(15),
                      CustomAuthTextFormField(
                        controller: confirmPasswordController,

                        hintText: 'Confirm Password',
                        obscureText: !isConfirmPasswordVisible,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const VerticalSpace(24),
                      InkWell(
                        onTap: () {
                          context.go(AppRoutes.login);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'Login',
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
                        text: state is AuthLoading ? 'Loading...' : 'Register',
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().register(
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
