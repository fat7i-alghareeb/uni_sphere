import 'package:test/core/styles/colors.dart';
import 'package:test/shared/widgets/custom_network_image.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';
import '../../../domain/entities/subjects_entity.dart';
import '../../state/bloc/subjects_bloc.dart';

/// A screen that displays a list of subjects.
class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  late final SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = getIt<SubjectsBloc>();
    _subjectsBloc.add(GetSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _subjectsBloc,
      child: BlocBuilder<SubjectsBloc, SubjectsState>(
        builder: (context, state) {
          return ResultBuilder<List<SubjectEntity>>(
            result: state.result,
            success: (data) => SubjectsScreenBody(subjects: data),
          );
        },
      ),
    );
  }
}

/// The body of the subjects screen that displays the list of subjects.
class SubjectsScreenBody extends StatelessWidget {
  const SubjectsScreenBody({
    super.key,
    required this.subjects,
  });

  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(context),
        _buildDivider(context),
        Expanded(
          child: _buildSubjectsList(),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppConstants.horizontalScreensPadding,
          ),
          child: DecoratedContainer(
            circleSize: 100,
            child: Padding(
              padding: REdgeInsets.all(18.0),
              child: Text(
                AppStrings.yourSubjects,
                style: context.textTheme.headlineLarge!
                    .withColor(context.primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Divider(
        height: 1.h,
        thickness: 1.h,
        color: context.primaryColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildSubjectsList() {
    return ListView.builder(
      padding: REdgeInsets.only(
        top: 10.h,
        right: AppConstants.horizontalScreensPadding,
        left: AppConstants.horizontalScreensPadding,
      ),
      itemBuilder: (context, index) =>
          SubjectItemCard(subject: subjects[index]),
      itemCount: subjects.length,
    );
  }
}

/// A card widget that displays information about a subject.
class SubjectItemCard extends StatelessWidget {
  const SubjectItemCard({
    super.key,
    required this.subject,
    this.haveFullInfo = false,
  });

  final bool haveFullInfo;
  final SubjectEntity subject;

  static const double _containerHorizontalPadding = 12;
  static const double _containerVerticalPadding = 14;
  static const double _borderRadius = 22;
  static const double _spacing = 10;
  static const double _imageSize = 112;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: REdgeInsets.symmetric(vertical: 6),
      padding: REdgeInsets.symmetric(
        horizontal: _containerHorizontalPadding.w,
        vertical: _containerVerticalPadding.h,
      ),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(_borderRadius.r),
        boxShadow: AppColors.primaryShadow(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _imageSize.w,
            height: _imageSize.h,
            child: _buildSubjectImage(),
          ),
          _spacing.horizontalSpace,
          Expanded(
            child: _buildSubjectInfo(context),
          )
        ],
      ),
    );
  }

  Widget _buildSubjectImage() {
    return CustomNetworkImage(
      imageUrl: subject.imageUrl,
      borderRadius: _borderRadius,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSubjectInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(context),
        _buildProfessorName(context),
        _spacing.verticalSpace,
        _buildSubInfoTags(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      subject.title,
      style:
          context.textTheme.titleMedium!.withColor(context.onBackgroundColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProfessorName(BuildContext context) {
    return Text(
      subject.professorName,
      style: context.textTheme.labelMedium!.withColor(context.greyColor),
      maxLines: 1,
    );
  }

  Widget _buildSubInfoTags(BuildContext context) {
    final tags = _buildSubInfoContainers(context);
    final halfLength = (tags.length / 2).ceil();

    return SizedBox(
      height: 60.h, // Height for two rows
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tags.sublist(0, halfLength),
              ),
            ),
          ),
          // 5.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tags.sublist(halfLength),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSubInfoContainers(BuildContext context) {
    return _getNeededSubInfo(fullInfo: haveFullInfo)
        .map((info) => Padding(
              padding: REdgeInsets.only(right: 8),
              child: _buildSubInfoContainer(context, info),
            ))
        .toList();
  }

  Widget _buildSubInfoContainer(BuildContext context, SubInfo info) {
    return Container(
      decoration: BoxDecoration(
        color: info.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: REdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          info.title,
          style: context.textTheme.labelSmall!.withColor(info.color),
        ),
      ),
    );
  }

  List<SubInfo> _getNeededSubInfo({bool fullInfo = false}) {
    return [
      SubInfo(
        title: "${AppStrings.theYear} ${subject.year}",
        color: const Color(0xFF496ce5),
      ),
      SubInfo(
        title: subject.semester,
        color: const Color(0xFFfc7cac),
      ),
      SubInfo(
        title:
            "${AppStrings.isMultipleChoice} ${_getAnswer(subject.isMultipleChoice)}",
        color: const Color.fromARGB(255, 252, 182, 52),
      ),
      SubInfo(
        title: "${AppStrings.lab} ${_getAnswer(subject.doesHaveALab)}",
        color: const Color(0xFFa874f3),
      ),
      if (fullInfo) ...[
        SubInfo(
          title: "${AppStrings.isPassed} ${_getAnswer(subject.isPassed)}",
          color: subject.isPassed ? const Color(0xFF1dceb2) : Colors.red,
        ),
        SubInfo(
          title: "${AppStrings.canEnroll} ${_getAnswer(subject.canEnroll)}",
          color: const Color(0xFF1dceb2),
        ),
        SubInfo(
          title: "${AppStrings.theGrade} ${subject.totalGrade}",
          color: const Color(0xFF70e8dc),
        ),
      ]
    ];
  }

  String _getAnswer(bool state) => state ? AppStrings.yes : AppStrings.no;
}

/// A class that holds information about a subject's sub-info tag.
class SubInfo {
  final String title;
  final Color color;

  const SubInfo({
    required this.title,
    required this.color,
  });
}
