import 'package:test/core/styles/colors.dart';
import 'package:test/shared/widgets/custom_network_image.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';
import '../../../domain/entities/subjects_entity.dart';
import '../../state/bloc/subjects_bloc.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  void initState() {
    super.initState();
    getIt<SubjectsBloc>().add(GetSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SubjectsBloc>(),
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
        20.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppConstants.horizontalScreensPadding,
          ),
          child: Divider(
            height: 1.h,
            thickness: 1.h,
            color: context.primaryColor.withOpacity(0.5),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: REdgeInsets.only(
              top: 10.h,
              right: AppConstants.horizontalScreensPadding,
              left: AppConstants.horizontalScreensPadding,
            ),
            itemBuilder: (context, index) =>
                SubjectItemCard(subject: subjects[index]),
            itemCount: subjects.length,
          ),
        ),
      ],
    );
  }
}

class SubjectItemCard extends StatelessWidget {
  const SubjectItemCard({
    super.key,
    required this.subject,
    this.height = 140,
    this.haveFullInfo = false,
  });
  final bool haveFullInfo;
  final SubjectEntity subject;
  final double height;
  @override
  Widget build(BuildContext context) {
    final containerHorizontalPadding = 12.w;
    final containerVerticalPadding = 14.h;
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height.h,
      margin: REdgeInsets.symmetric(vertical: 6),
      padding: REdgeInsets.symmetric(
        horizontal: containerHorizontalPadding,
        vertical: containerVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: AppColors.primaryShadow(context),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CustomNetworkImage(
              imageUrl: subject.imageUrl,
              borderRadius: 22,
              fit: BoxFit.cover,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: _subjectInfo(
              context: context,
              haveFullInfo: haveFullInfo,
            ),
          )
        ],
      ),
    );
  }

  Column _subjectInfo(
      {required BuildContext context, bool haveFullInfo = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            subject.title,
            style: context.textTheme.titleMedium!
                .withColor(context.onBackgroundColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            subject.professorName,
            style: context.textTheme.labelMedium!.withColor(context.greyColor),
            maxLines: 1,
          ),
        ),
        10.verticalSpace,
        Flexible(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _getSubInfoContainer(
              context: context,
              haveFullInfo: haveFullInfo,
            ),
          ),
        )
      ],
    );
  }

  List<Container> _getSubInfoContainer(
      {required BuildContext context, bool haveFullInfo = false}) {
    final subInfo = _getNeededSubInfo(fullInfo: haveFullInfo);
    return List.generate(
      subInfo.length,
      (index) => Container(
        decoration: BoxDecoration(
          color: subInfo[index].color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: REdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            subInfo[index].title,
            style:
                context.textTheme.labelSmall!.withColor(subInfo[index].color),
          ),
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

  String _getAnswer(bool state) {
    return state ? AppStrings.yes : AppStrings.no;
  }
}

class SubInfo {
  final String title;
  final Color color;

  SubInfo({required this.title, required this.color});
}
