import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/injection/injection.dart';

import '../../../../../shared/imports/imports.dart';
import '../../state/bloc/home_bloc.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: const Scaffold(
        body: HomeBody(),
      ),
    );
  }
}
