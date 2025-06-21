import 'package:beamer/beamer.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../data/params/check_one_time_param.dart';
import '../../input_forms/auth_input_keys.dart';
import '../../state/bloc/auth_bloc.dart';
import 'package:test/features/access/presentation/ui/screens/register_screen.dart'
    show RegisterScreen;
import 'package:test/features/access/presentation/ui/widgets/major_selector.dart';
import 'package:test/shared/extensions/form_extension.dart';
import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/states/bloc/info_bloc.dart';
import 'package:test/shared/utils/helper/show_error_overlay.dart';
import 'package:test/shared/widgets/auth_button.dart';
import 'package:test/shared/widgets/custom_reative_field.dart';
import 'package:test/shared/widgets/custom_scaffold_body.dart'
    show CustomScaffoldBody;

import '../../input_forms/check_one_time_code_from.dart';

class CheckOneTimeCodeBody extends StatefulWidget {
  const CheckOneTimeCodeBody({
    super.key,
  });

  @override
  State<CheckOneTimeCodeBody> createState() => _CheckOneTimeCodeBodyState();
}

class _CheckOneTimeCodeBodyState extends State<CheckOneTimeCodeBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeController;

  // Individual animations for each widget
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _majorSelectorAnimation;
  late Animation<double> _studentInfoAnimation;
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

    _majorSelectorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
    ));

    _studentInfoAnimation = Tween<double>(
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

    getIt<InfoBloc>().add(GetFacultiesEvent());
    CheckOneTimeCodeForm.clearForm();
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
          key: ValueKey("check_one_time_code_form"),
          formGroup: CheckOneTimeCodeForm.formGroup,
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
                                Icons.school,
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
                              AppStrings.checkOneTimeCode,
                              style: context.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                    AnimatedBuilder(
                      animation: _majorSelectorAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                              50 * (1 - _majorSelectorAnimation.value), 0),
                          child: Opacity(
                            opacity:
                                _majorSelectorAnimation.value.clamp(0.0, 1.0),
                            child: MajorSelector(),
                          ),
                        );
                      },
                    ),
                    10.verticalSpace,
                    AnimatedBuilder(
                      animation: _studentInfoAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                              -50 * (1 - _studentInfoAnimation.value), 0),
                          child: Opacity(
                            opacity:
                                _studentInfoAnimation.value.clamp(0.0, 1.0),
                            child: _studentInfo(),
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
                                if (state.checkOneTimeResult.isError()) {
                                  showErrorOverlay(
                                    context,
                                    state.checkOneTimeResult.getError(),
                                  );
                                }
                                if (state.checkOneTimeResult.isLoaded() &&
                                    !AuthBloc.isCheckingOneTimeCode) {
                                  AuthBloc.isCheckingOneTimeCode = true;
                                  context.beamToNamed(RegisterScreen.pagePath);
                                }
                              },
                              builder: (context, state) {
                                return AuthButton.primary(
                                  height: 50.h,
                                  isLoading:
                                      state.checkOneTimeResult.isLoading(),
                                  title: AppStrings.checkYourAccessCode,
                                  onPressed: () {
                                    if (CheckOneTimeCodeForm.formGroup
                                        .isFormValid()) {
                                      getIt<AuthBloc>().add(
                                        CheckOneTimeCodeEvent(
                                          checkOneTimeParam: CheckOneTimeParam(
                                            studentNumber: CheckOneTimeCodeForm
                                                .formGroup
                                                .getValue(
                                              AuthInputKeys.studentNumber,
                                            ),
                                            code: CheckOneTimeCodeForm.formGroup
                                                .getValue(
                                              AuthInputKeys.oneTimeCode,
                                            ),
                                            majorId: CheckOneTimeCodeForm
                                                .formGroup
                                                .getValue(
                                              AuthInputKeys.majorId,
                                            ),
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

  Widget _studentInfo() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return Column(
        children: [
          CustomReactiveField(
            controller: AuthInputKeys.studentNumber,
            hintText: AppStrings.enterCollageNumber,
            title: AppStrings.collageNumber,
            isRequired: true,
            readOnly: form.getValue(AuthInputKeys.facultyId) == null ||
                form.getValue(AuthInputKeys.majorId) == null,
          ),
          10.verticalSpace,
          CustomReactiveField(
            controller: AuthInputKeys.oneTimeCode,
            hintText: AppStrings.enterOneTimeCode,
            readOnly: form.getValue(AuthInputKeys.facultyId) == null ||
                form.getValue(AuthInputKeys.majorId) == null,
            title: AppStrings.oneTimeCode,
            isRequired: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ],
      );
    });
  }
}
