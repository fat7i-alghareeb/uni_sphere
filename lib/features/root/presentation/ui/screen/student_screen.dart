import 'package:beamer/beamer.dart' show BeamPage, BeamPageType;
import 'package:easy_localization/easy_localization.dart';
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/auth_data_source/local/auth_local.dart';
import '../../../../../core/injection/injection.dart' show getIt;
import '../../../../../shared/entities/user.dart' show User;
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_network_image.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';
import '../../../../../shared/widgets/spacing.dart';

import '../../../../../router/router_config.dart' show BeamerBuilder;

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  static const String pagePath = 'student';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey('student_screen'),
      child: const StudentScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen>
    with TickerProviderStateMixin {
  late final User? user;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    user = getIt<AuthLocal>().getUser();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Fade animation for smooth appearance
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    // Slide animation for content
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Scale animation for profile image
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start animations with staggered timing
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: CustomScaffoldBody(
          title: AppStrings.studentProfile,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off,
                  size: 80.r,
                  color: context.greyColor,
                ),
                verticalSpace(16),
                Text(
                  AppStrings.noUserDataAvailable,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScaffoldBody(
        title: AppStrings.studentProfile,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: REdgeInsets.symmetric(
                horizontal: AppConstants.horizontalScreensPadding,
              ),
              child: Column(
                children: [
                  verticalSpace(24),
                  _buildProfileHeader(context),
                  verticalSpace(32),
                  _buildPersonalInfoCard(context),
                  verticalSpace(16),
                  _buildAcademicInfoCard(context),
                  verticalSpace(16),
                  _buildEnrollmentInfoCard(context),
                  verticalSpace(32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: REdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.primaryColor.withValues(alpha: 0.1),
              context.primaryColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: context.primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Profile Image
            Container(
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.primaryColor.withValues(alpha: 0.3),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: user!.studentImageUrl.isNotEmpty
                    ? CustomNetworkImage(
                        imageUrl: user!.studentImageUrl,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      )
                    : Container(
                        color: context.primaryColor.withValues(alpha: 0.1),
                        child: Icon(
                          Icons.person,
                          size: 60.r,
                          color: context.primaryColor,
                        ),
                      ),
              ),
            ),
            verticalSpace(16),
            // Full Name
            Text(
              '${user!.getFirstName(context.locale.languageCode)} ${user!.getLastName(context.locale.languageCode)}',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onBackgroundColor,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(8),
            // Student Number
            Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: context.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'ID: ${user!.studentNumber}',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context) {
    return _buildInfoCard(
      context: context,
      title: AppStrings.personalInformation,
      icon: Icons.person_outline,
      children: [
        _buildInfoRow(context, AppStrings.firstName,
            user!.getFirstName(context.locale.languageCode)),
        _buildInfoRow(context, AppStrings.lastName,
            user!.getLastName(context.locale.languageCode)),
        _buildInfoRow(context, AppStrings.fatherName,
            user!.getFatherName(context.locale.languageCode)),
        // Student ID removed for privacy
      ],
    );
  }

  Widget _buildAcademicInfoCard(BuildContext context) {
    return _buildInfoCard(
      context: context,
      title: AppStrings.academicInformation,
      icon: Icons.school_outlined,
      children: [
        _buildInfoRow(context, AppStrings.major,
            user!.getMajorName(context.locale.languageCode)),
        _buildInfoRow(context, AppStrings.currentYear,
            '${AppStrings.year} ${user!.year}'),
        _buildInfoRow(
          context,
          AppStrings.majorDuration,
          '${user!.numberOfMajorYears} ${AppStrings.year}',
        ),
      ],
    );
  }

  Widget _buildEnrollmentInfoCard(BuildContext context) {
    return _buildInfoCard(
      context: context,
      title: AppStrings.enrollmentStatus,
      icon: Icons.assignment_outlined,
      children: [
        _buildInfoRow(
          context,
          AppStrings.status,
          user!.getEnrollmentStatusName(context.locale.languageCode),
          valueColor: _getStatusColor(context,
              user!.getEnrollmentStatusName(context.locale.languageCode)),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Row(
            children: [
              Container(
                padding: REdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: context.primaryColor,
                  size: 20.r,
                ),
              ),
              horizontalSpace(12),
              Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.onBackgroundColor,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          // Card Content
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: REdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.greyColor,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          horizontalSpace(16),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: context.textTheme.bodyMedium?.copyWith(
                color: valueColor ?? context.onBackgroundColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'enrolled':
        return Colors.green;
      case 'inactive':
      case 'suspended':
        return Colors.red;
      case 'pending':
      case 'waiting':
        return Colors.orange;
      default:
        return context.onBackgroundColor;
    }
  }
}
