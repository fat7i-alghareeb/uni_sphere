import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/shared/utils/helper/colored_print.dart';
import '../../../../../shared/imports/imports.dart';
import '../../state/bloc/home_bloc.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    printR("initState");
    getIt<HomeBloc>().add(GetHomeEvent());
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: const HomeBody(),
    );
  }
}
