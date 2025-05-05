import 'package:test/core/styles/colors.dart';

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
            circleSize: 80,
            child: Padding(
              padding: REdgeInsets.all(18.0),
              child: Text(
                AppStrings.yourSubjects,
                style: context.textTheme.titleLarge,
              ),
            ),
          ),
        ),
        20.verticalSpace,
        Divider(
          height: 1.h,
          thickness: 2.h,
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
  });

  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: AppColors.primaryShadow(context),
        ),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
