import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/widgets/custom_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification email sent successfully.'),
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
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.mark_email_read_outlined, size: 100),
                    const SizedBox(height: 24),

                    Text(
                      'Verify Your Email',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    const SizedBox(height: 16),
                    Text(
                      'We have sent a verification link to your email address.\nPlease verify your email before continuing.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 40),
                    CustomAuthButton(
                      text: "I've Verified My Email",
                      onPressed: () async {
                        final isVerified = await context
                            .read<AuthCubit>()
                            .isEmailVerified();
                        if (isVerified) {
                          context.go(AppRoutes.home);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please verify your email first.'),
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 16),

                    CustomAuthButton(
                      text: "Resend Email",
                      onPressed: () {
                        context.read<AuthCubit>().sendEmailVerification();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
