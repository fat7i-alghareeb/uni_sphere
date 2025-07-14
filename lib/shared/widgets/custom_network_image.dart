// 📦 Package imports:
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

// 🌎 Project imports:
import '../../core/constants/app_url.dart';
import '../imports/imports.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.fill,
    this.width,
    this.height,
    this.borderRadius,
    this.filterQuality = FilterQuality.high,
    this.cacheKey,
    this.useOldImageOnUrlChange = false,
  });

  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double? borderRadius;
  final FilterQuality filterQuality;
  final String? cacheKey;
  final bool useOldImageOnUrlChange;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  late final Dio _dio;

  @override
  void initState() {
    super.initState();
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio();

    // Configure SSL certificate handling
    if (_dio.httpClientAdapter is IOHttpClientAdapter) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    // Set timeout for requests
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.sendTimeout = const Duration(seconds: 30);
  }

  String get fullUrl {
    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) return '';
    return widget.imageUrl!.startsWith("http")
        ? widget.imageUrl!
        : AppUrl.baseUrlDevelopment + widget.imageUrl!;
  }

  Widget _buildErrorWidget(BuildContext context, String? url, dynamic error) {
    final isSSLError = error.toString().contains('CERTIFICATE_VERIFY_FAILED') ||
        error.toString().contains('HandshakeException');

    return Container(
      width: widget.width?.w,
      height: widget.height?.h,
      decoration: BoxDecoration(
        color: context.greyColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSSLError ? Icons.security : Icons.image_not_supported,
            color: context.greyColor,
            size: (widget.width != null && widget.width! > 0)
                ? (widget.width! * 0.3)
                : 24.r,
          ),
          4.verticalSpace,
          Text(
            isSSLError ? 'SSL Error' : 'Image Error',
            style: context.textTheme.bodySmall!.copyWith(
              color: context.greyColor,
              fontSize: (widget.width != null && widget.width! > 0)
                  ? (widget.width! * 0.08)
                  : 10.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorImage = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      child: Image.asset(
        "assets/images/error.png",
        fit: BoxFit.fill,
      ),
    );

    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) {
      return errorImage;
    }

    // Use Dio with SSL certificate bypass for images
    return FutureBuilder<Response>(
      future:
          _dio.get(fullUrl, options: Options(responseType: ResponseType.bytes)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: widget.width?.w,
            height: widget.height?.h,
            decoration: BoxDecoration(
              color: context.greyColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: context.primaryColor,
                strokeWidth: (widget.width != null && widget.width! > 0)
                    ? (widget.width! * 0.05)
                    : 4,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return _buildErrorWidget(context, fullUrl, snapshot.error);
        }

        if (snapshot.hasData && snapshot.data != null) {
          final image = Image.memory(
            snapshot.data!.data,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
            filterQuality: widget.filterQuality,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Image rendering error: $error');
              return _buildErrorWidget(context, null, error);
            },
          );

          if (widget.borderRadius == null) {
            return image;
          } else {
            return ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius!.r),
              child: image,
            );
          }
        }

        return _buildErrorWidget(context, fullUrl, 'No image data');
      },
    );
  }
}
