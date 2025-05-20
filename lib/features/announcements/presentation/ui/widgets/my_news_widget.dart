import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/utils/helper/colored_print.dart';
import '../../../domain/entities/announcement_entity.dart';
import '../../state/bloc/announcement_bloc.dart';

class MyNewsWidget extends StatefulWidget {
  const MyNewsWidget({super.key});

  @override
  State<MyNewsWidget> createState() => _MyNewsWidgetState();
}

class _MyNewsWidgetState extends State<MyNewsWidget> {
  @override
  void initState() {
    super.initState();
    printR("initState my news");
    getIt<AnnouncementBloc>().add(GetMyAnnouncementEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementBloc, AnnouncementState>(
      builder: (context, state) => ResultBuilder<List<AnnouncementEntity>>(
        success: (data) => const SizedBox(),
        result: state.myAnnouncementResult,
      ),
    );
  }
}
