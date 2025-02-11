import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class SearchField extends StatefulWidget {
  const SearchField(
      {super.key,
      this.boxConstraints,
      this.focusNode,
      this.borderRadius,
      this.borderColor,
      this.onSaved,
      required this.onSearch,
      this.labelColor,
      this.textFaded,
      required this.labelText,
      this.textColor,
      required this.hintText,
      this.showIcon,
      this.fieldKey,
      this.controller,
      this.autofillHints,
      this.currentPass = false,
      this.onChanged});
  final BoxConstraints? boxConstraints;
  final FocusNode? focusNode;
  final double? borderRadius;
  final Color? borderColor;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function() onSearch;
  final Color? labelColor;
  final Color? textFaded;
  final String labelText;
  final Color? textColor;
  final String hintText;
  final bool? showIcon;
  final Key? fieldKey;
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;
  final bool currentPass;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: widget.autofillHints,
      controller: widget.controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      key: widget.fieldKey,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.text,
      onSaved: (value) => widget.onSaved!(value),
      onChanged: (value) => widget.onChanged!(value),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
        constraints: widget.boxConstraints,
        suffixIconConstraints: BoxConstraints(
          maxHeight: 40.h,
          maxWidth: 40.w,
          minWidth: 40.w,
          minHeight: 40.h,
        ),
        suffixIcon: widget.showIcon != null
            ? IconButton(
                onPressed: () => setState(() => widget.onSearch.call()),
                icon: const Center(
                  child: Icon(Icons.search),
                ),
              )
            : null,
        errorMaxLines: 8,
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 9.sp),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 9.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 9.sp),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 9.sp),
        ),
      ),
    );
  }
}
