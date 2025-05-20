import 'package:test/core/result_builder/result_builder.dart';
import 'package:test/features/announcements/domain/entities/announcement_entity.dart';
import 'package:test/features/announcements/presentation/state/bloc/announcement_bloc.dart';
import 'package:test/shared/utils/helper/colored_print.dart';

import '../../../../../core/injection/injection.dart';
import '../../../../../shared/imports/imports.dart';
import 'all_news_card.dart';

class AllNewsWidget extends StatefulWidget {
  const AllNewsWidget({super.key});

  @override
  State<AllNewsWidget> createState() => _AllNewsWidgetState();
}

class _AllNewsWidgetState extends State<AllNewsWidget> {
  @override
  void initState() {
    super.initState();
    printR("initState all news");
    getIt<AnnouncementBloc>().add(GetAnnouncementEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementBloc, AnnouncementState>(
      builder: (context, state) => ResultBuilder<List<AnnouncementEntity>>(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        success: (data) => ListView.builder(
          padding: REdgeInsets.only(
              left: AppConstants.horizontalScreensPadding,
              right: AppConstants.horizontalScreensPadding,
              // top: 22.h,
              bottom: 100.h),
          itemCount: data.length,
          itemBuilder: (context, index) => AllNewsCard(
            announcementEntity: data[index],
          ),
        ),
        result: state.result,
      ),
    );
  }
}
