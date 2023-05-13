import 'package:event_management/blocs/button/button_bloc.dart';
import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/utils/toasts/app_toasts.dart';
import 'package:event_management/widgets/loading_widget/primary_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondaryButtonWidget extends StatefulWidget {
  const SecondaryButtonWidget({
    Key? key,
    required this.caption,
    required this.onPressed,
    this.width,
    this.height,
    this.margin,
  }) : super(key: key);

  final String caption;
  final VoidCallback onPressed;
  final double? width, height;
  final EdgeInsets? margin;

  @override
  State<SecondaryButtonWidget> createState() => _SecondaryButtonWidgetState();
}

class _SecondaryButtonWidgetState extends State<SecondaryButtonWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ButtonBloc>(
      create: (context) => ButtonBloc(),
      child: BlocConsumer<ButtonBloc, ButtonState>(
        listener: (context, state) {
          if (state is ButtonFailure) {
            isPressed = false;
            AppToasts.errorToast(state.error);
          } else if (state is ButtonLoading) {
            isPressed = true;
          } else {
            isPressed = false;
          }
        },
        builder: (context, state) => Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? 45,
          margin: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<ButtonBloc>(context).add(
                ButtonPressed(onPressed: widget.onPressed),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successColor,
              foregroundColor: AppColors.appWhiteColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child:
                isPressed ? const PrimaryButtonLoading() : Text(widget.caption),
          ),
        ),
      ),
    );
  }
}
