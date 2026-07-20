import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/core/utils/assets.dart';
import 'package:chat_app/core/widgets/app_spacing.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.splashAnimationDuration,
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
    Future.delayed(AppConstants.splashDuration, () {
      if (!mounted) return;

      context.read<AuthCubit>().checkAuthStatus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          context.go(AppRoutes.login);
        } else if (state is EmailNotVerified) {
          context.go(AppRoutes.emailVerification);
        } else if (state is AuthAuthenticated) {
          context.go(AppRoutes.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.appLogo,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const VerticalSpace(16),
                    Text(
                      AppConstants.appName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const VerticalSpace(8),
                    Text(
                      'Connecting...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
