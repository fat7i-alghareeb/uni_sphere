import '../../../../../common/constant/app_strings.dart';
import '../../state/bloc/announcement_bloc.dart';
import '../widgets/all_news_widget.dart';
import '../widgets/my_news_widget.dart';

import '../../../../../core/injection/injection.dart';
import '../../../../../shared/imports/imports.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AnnouncementBloc>(),
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: context.lightPrimaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSegment(
                      context,
                      AppStrings.allNews,
                      0,
                    ),
                  ),
                  Expanded(
                    child: _buildSegment(
                      context,
                      AppStrings.myNews,
                      1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _selectedIndex == 0 ? _buildAllNews() : _buildMyNews(),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(BuildContext context, String text, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: REdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? context.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: 15.sp,
            color: isSelected
                ? context.backgroundColor
                : context.onBackgroundColor.withValues(alpha: 0.5),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildAllNews() {
    return const AllNewsWidget();
  }

  Widget _buildMyNews() {
    return const MyNewsWidget();
  }
}
