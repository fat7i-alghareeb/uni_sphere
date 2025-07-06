import 'package:beamer/beamer.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../router/router_config.dart' show BeamerBuilder;
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/news_entity.dart';
import '../widgets/news_details_content.dart';
import '../widgets/news_details_image.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({
    super.key,
    required this.news,
  });

  final NewsEntity news;
  static const String pagePath = 'news_details';

  static BeamerBuilder pageBuilder = (context, state, data) {
    final news = data as NewsEntity?;
    if (news == null) {
      return BeamPage(
        key: const ValueKey('news_details_error'),
        type: BeamPageType.fadeTransition,
        child: Scaffold(
          body: Center(
            child: Text(AppStrings.newsNotFound),
          ),
        ),
      );
    }
    return BeamPage(
      key: ValueKey('news_details_${news.id}'),
      child: NewsDetailsScreen(news: news),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;
  bool _isDisposed = false;
  bool _hasAnimated = false;
  String? _selectedImageUrl;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _selectedImageUrl = widget.news.image?.firstOrNull;
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animations = List.generate(
      2, // Header and Content
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * (0.5 / 2),
            (index * (0.5 / 2)) + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    if (!_isDisposed && !_hasAnimated) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  void _handleImageSelection(String imageUrl) {
    setState(() {
      _selectedImageUrl = imageUrl;
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _hasAnimated = false;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          NewsDetailsImage(
            id: widget.news.id,
            imageUrl: _selectedImageUrl ?? '',
            images: widget.news.image ?? [],
            selectedImageUrl: _selectedImageUrl,
            onImageSelected: _handleImageSelection,
          ),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animations.last,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * (1 - _animations.last.value)),
                  child: Opacity(
                    opacity: _animations.last.value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 9.0),
                child: NewsDetailsContent(
                  news: widget.news,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
