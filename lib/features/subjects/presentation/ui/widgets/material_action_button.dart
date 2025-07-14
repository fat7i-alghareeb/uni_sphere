import 'package:test/common/constant/app_strings.dart';
import 'package:test/features/subjects/domain/entities/materials_entity.dart'
    as materials;
import 'package:test/features/subjects/services/materials_service.dart';
import 'package:test/shared/imports/imports.dart';

class MaterialActionButton extends StatefulWidget {
  const MaterialActionButton({
    super.key,
    required this.material,
    this.isDownloadedOverride,
  });

  final materials.MaterialEntity material;
  final bool? isDownloadedOverride;

  @override
  State<MaterialActionButton> createState() => _MaterialActionButtonState();
}

class _MaterialActionButtonState extends State<MaterialActionButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final materialsService = MaterialsService();
    return FutureBuilder<bool>(
      future: widget.isDownloadedOverride != null
          ? Future.value(widget.isDownloadedOverride)
          : materialsService.isFileActuallyDownloaded(widget.material.url),
      builder: (context, snapshot) {
        final isDownloaded = snapshot.data ?? false;
        return GestureDetector(
          onTap: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await materialsService.handleMaterialAction(
                        context, widget.material);
                  } catch (e) {
                    String errorMessage = _getErrorMessage(e.toString());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
          child: Container(
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDownloaded
                  ? Colors.blue.withValues(alpha: 0.1)
                  : context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.primaryColor,
                    ),
                  )
                : Icon(
                    isDownloaded
                        ? materialsService.getViewIcon()
                        : materialsService.getActionIcon(widget.material.type),
                    color: isDownloaded ? Colors.blue : context.primaryColor,
                    size: 20.r,
                  ),
          ),
        );
      },
    );
  }

  String _getErrorMessage(String error) {
    if (error.contains('UnimplementedError') ||
        error.contains('Download not supported')) {
      return 'Download not supported';
    } else if (error.contains('SSL certificate error')) {
      return 'SSL certificate error';
    } else if (error.contains('CERTIFICATE_VERIFY_FAILED')) {
      return 'Certificate verification failed';
    } else if (error.contains('HandshakeException')) {
      return 'Connection error';
    } else if (error.contains('Could not open link')) {
      return 'Failed to open link';
    } else if (error.contains('Could not access storage directory')) {
      return 'Storage access denied';
    } else if (error.contains('Network connection error')) {
      return 'Network connection error';
    } else {
      return 'An error occurred';
    }
  }
}
