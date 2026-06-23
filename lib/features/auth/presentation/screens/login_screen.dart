import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/auth/demo_auth_service.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_curved_header.dart';
import '../../../../shared/widgets/smart_stitch_logo.dart';
import '../../../../shared/widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final user = DemoAuthService.authenticate(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
        ),
      );
      return;
    }

    AuthSession.signIn(user);
    context.go(DemoAuthService.homeRouteFor(user.role));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthCurvedHeader(
              height: MediaQuery.sizeOf(context).width < 360 ? 240 : 260,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final logoMaxWidth =
                      (constraints.maxWidth * 0.32).clamp(100.0, 140.0);

                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.paddingOf(context).top + AppSpacing.md,
                      ),
                      child: SmartStitchLogo(
                        variant: SmartStitchLogoVariant.iconOnly,
                        maxWidth: logoMaxWidth,
                      ),
                    ),
                  );
                },
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -AppSpacing.xl),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        label: 'Email/Username',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Password',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textHint,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppButton(
                        label: 'Sign In',
                        onPressed: _onSignIn,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forget Password?',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const OrDivider(),
                      const SizedBox(height: AppSpacing.lg),
                      SocialLoginButton(
                        label: 'Continue with Google',
                        icon: const GoogleIcon(),
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSpacing.md),
                      SocialLoginButton(
                        label: 'Continue with Facebook',
                        icon: const FacebookIcon(),
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.push(RouteNames.createAccount),
                            child: Text(
                              'Sign Up',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
