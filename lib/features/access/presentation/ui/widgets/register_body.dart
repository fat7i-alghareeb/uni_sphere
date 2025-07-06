import 'package:reactive_forms/reactive_forms.dart'
    show ReactiveForm, ReactiveFormConsumer;
import 'package:easy_localization/easy_localization.dart';
import 'package:test/common/constant/app_strings.dart';
import 'package:test/core/injection/injection.dart' show getIt;
import 'package:test/core/result_builder/result.dart';
import 'package:test/features/access/data/params/register_param.dart'
    show RegisterParam;
import 'package:test/features/access/presentation/input_forms/auth_input_keys.dart'
    show AuthInputKeys;
import 'package:test/features/access/presentation/input_forms/registre_form.dart'
    show RegisterForm;
import 'package:test/features/access/presentation/state/bloc/auth_bloc.dart'
    show AuthBloc, AuthState, RegisterEvent;
import 'package:test/shared/extensions/form_extension.dart';
import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/utils/helper/show_error_overlay.dart';
import 'package:test/shared/widgets/auth_button.dart';
import 'package:test/shared/widgets/custom_reative_field.dart';
import 'package:test/shared/widgets/custom_scaffold_body.dart'
    show CustomScaffoldBody;
import 'package:test/shared/widgets/passwrod_field.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({
    super.key,
  });

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeController;

  // Individual animations for each widget
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _userInfoAnimation;
  late Animation<double> _passwordAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create staggered animations
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.3, curve: Curves.elasticOut),
    ));

    _titleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeOutBack),
    ));

    _userInfoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
    ));

    _passwordAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 0.9, curve: Curves.easeOutCubic),
    ));

    _buttonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeOutBack),
    ));

    // Start animations
    _fadeController.forward();
    _animationController.forward();

    RegisterForm.clearForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _prefillUserData();
  }

  void _prefillUserData() {
    // Get the SimpleUser data from the previous screen result
    final authBloc = getIt<AuthBloc>();
    final simpleUser = authBloc.state.checkOneTimeResult.getDataWhenSuccess();

    if (simpleUser != null) {
      // Use the localized full name based on current locale
      final currentLanguage = context.locale.languageCode;
      RegisterForm.formGroup.setValue(
          AuthInputKeys.userName, simpleUser.getFullName(currentLanguage));
      RegisterForm.formGroup
          .setValue(AuthInputKeys.studentId, simpleUser.studentId);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: FadeTransition(
        opacity: _fadeController,
        child: ReactiveForm(
          key: ValueKey("register_form"),
          formGroup: RegisterForm.formGroup,
          child: Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppConstants.horizontalScreensPadding,
            ),
            child: CustomScaffoldBody(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    75.verticalSpace,
                    AnimatedBuilder(
                      animation: _logoAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - _logoAnimation.value)),
                            child: Container(
                              width: 150.r,
                              height: 150.r,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.person_add,
                                size: 80.r,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    16.verticalSpace,
                    AnimatedBuilder(
                      animation: _titleAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - _titleAnimation.value)),
                          child: Opacity(
                            opacity: _titleAnimation.value.clamp(0.0, 1.0),
                            child: Text(
                              AppStrings.register,
                              style: context.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                    AnimatedBuilder(
                      animation: _userInfoAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset:
                              Offset(50 * (1 - _userInfoAnimation.value), 0),
                          child: Opacity(
                            opacity: _userInfoAnimation.value.clamp(0.0, 1.0),
                            child: _userInfo(),
                          ),
                        );
                      },
                    ),
                    10.verticalSpace,
                    AnimatedBuilder(
                      animation: _passwordAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset:
                              Offset(-50 * (1 - _passwordAnimation.value), 0),
                          child: Opacity(
                            opacity: _passwordAnimation.value.clamp(0.0, 1.0),
                            child: _passwordFields(),
                          ),
                        );
                      },
                    ),
                    50.verticalSpace,
                    AnimatedBuilder(
                      animation: _buttonAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _buttonAnimation.value,
                          child: Opacity(
                            opacity: _buttonAnimation.value.clamp(0.0, 1.0),
                            child: BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state.registerResult.isError()) {
                                  showErrorOverlay(
                                    context,
                                    state.registerResult.getError(),
                                  );
                                }
                                if (state.registerResult.isLoaded()) {
                                  // Navigate to home or dashboard after successful registration
                                  // You can add navigation logic here
                                }
                              },
                              builder: (context, state) {
                                return AuthButton.primary(
                                  height: 50.h,
                                  isLoading: state.registerResult.isLoading(),
                                  title: AppStrings.createAccount,
                                  onPressed: () {
                                    if (RegisterForm.formGroup.isFormValid()) {
                                      getIt<AuthBloc>().add(
                                        RegisterEvent(
                                          registerParam: RegisterParam(
                                            userName: RegisterForm.formGroup
                                                .getValue(
                                                    AuthInputKeys.userName),
                                            studentId: RegisterForm.formGroup
                                                .getValue(
                                                    AuthInputKeys.studentId),
                                            password: RegisterForm.formGroup
                                                .getValue(
                                                    AuthInputKeys.password),
                                            confirmPassword: RegisterForm
                                                .formGroup
                                                .getValue(AuthInputKeys
                                                    .confirmPassword),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  context: context,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return Column(
        children: [
          CustomReactiveField(
            controller: AuthInputKeys.userName,
            hintText: AppStrings.enterUserName,
            title: AppStrings.userName,
            isRequired: true,
            readOnly: true, // Pre-filled from SimpleUser
          ),
        ],
      );
    });
  }

  Widget _passwordFields() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return Column(
        children: [
          PasswordField(
            isConfirmPassword: false,
            hintText: AppStrings.enterPassword,
            withTitle: true,
          ),
          10.verticalSpace,
          PasswordField(
            isConfirmPassword: true,
            hintText: AppStrings.enterConfirmPassword,
            withTitle: true,
          ),
        ],
      );
    });
  }
}
