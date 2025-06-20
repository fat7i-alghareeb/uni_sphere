// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test/common/constant/app_strings.dart';
import 'package:test/core/styles/colors.dart' show AppColors;
import 'package:test/shared/entities/drop_down_data.dart' show DropDownData;
import 'package:test/shared/widgets/custom_reative_field.dart' show CustomReactiveField;
import 'package:test/shared/widgets/loading_progress.dart' show LoadingProgress;

// 🌎 Project imports:
import '../imports/imports.dart';
import 'custom_drop_down_menu.dart' show CustomDropDownMenuMain;

// ignore: must_be_immutable
class CustomPickerField extends StatelessWidget {
  // List of dropdown items
  final List<DropDownData> data;

  // Hint text to display when no item is selected
  final String? hintText;

  // Callback for when an item is selected
  final void Function(String? name, String? id) onSelect;

  final void Function(DropDownData? data)? onFormattedSelect;

  // Currently selected dropdown item
  final DropDownData? selectedItem;

  // Whether search is enabled within the dropdown
  final bool enableSearch;

  // Whether there is a validation error
  bool? isError;

  // Validation error message
  final String? validationMessage;

  // Width of the dropdown menu
  final double width;

  // Optional text style for the hint text
  final TextStyle? hintTextStyle;

  // Optional maximum height of the dropdown
  final double? maxHeight;

  // Icon to display at the end of the dropdown
  final Widget trailingIcon;

  // Optional icon to display at the start of the dropdown
  final Widget? leadingIcon;

  final String title;

  final bool isLoading;

  final bool readOnly;

  final FormGroup? formGroup; // readOnly Case

  final String? controller; // readOnly Case

  final bool isItemRequired;

  final void Function(String query)? onSearchCallback;
  final bool isCustomerNumber;

  CustomPickerField({
    super.key,
    required this.data,
    this.hintText,
    required this.onSelect,
    this.selectedItem,
    required this.enableSearch,
    this.validationMessage,
    required this.width,
    this.hintTextStyle,
    this.maxHeight,
    this.trailingIcon = const Icon(Icons.arrow_drop_down),
    this.leadingIcon,
    this.isError,
    required this.title,
    required this.isLoading,
    required this.readOnly,
    this.formGroup,
    this.onFormattedSelect,
    this.controller,
    this.isItemRequired = false,
    this.onSearchCallback,
    this.isCustomerNumber = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(right: 3),
          child: Row(
            children: [
              Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
              if (isItemRequired)
                Text(
                  "*",
                  style: context.textTheme.titleMedium
                      ?.copyWith(color: AppColors.danger),
                ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        isLoading
            ? Container(
                width: width,
                height: 48.h,
                decoration: BoxDecoration(
                  color: context.greyColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: context.greyColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingProgress(
                      color: context.primaryColor,
                      size: 20.r,
                    ),
                    8.horizontalSpace,
                    Text(
                      AppStrings.loading,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.greyColor,
                      ),
                    ),
                  ],
                ),
              )
            : readOnly
                ? ReactiveForm(
                    formGroup: formGroup!,
                    child: CustomReactiveField(
                      controller: controller!,
                      readOnly: true,
                    ),
                  )
                : CustomDropDownMenuMain(
                    data: data,
                    hintText: hintText,
                    onSelect: onSelect,
                    width: width,
                    isError: isError,
                    selectedItem: selectedItem,
                    enableSearch: enableSearch,
                    validationMessage: validationMessage,
                    hintTextStyle: hintTextStyle,
                    trailingIcon: trailingIcon,
                    leadingIcon: leadingIcon,
                    maxHeight: maxHeight,
                    isItemRequired: isItemRequired,
                    onFormattedSelect: onFormattedSelect,
                    onSearchCallback: onSearchCallback,
                    isCustomerNumber: isCustomerNumber,
                  ),
      ],
    );
  }
}
