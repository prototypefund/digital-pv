import 'package:flutter/material.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/custom_track_shape.dart';
import 'package:pd_app/general/view_components/directive_visualization/border_slider_thumb_shape.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_form_change_notification.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';
import 'package:provider/provider.dart';

class NewAspect<ViewModelClass extends NewAspectViewModel> extends StatelessWidget with Logging {
  @override
  Widget build(BuildContext context) {
    final ViewModelClass viewModel = context.watch();

    return Row(
      children: [
        card(
            showCheckboxBelow: false,
            markdown: viewModel.selectedItemContent,
            assetPath: "assets/images/create.svg",
            more: viewModel.more),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (viewModel.runtimeType == NewFutureSituationViewModel) ...[
                  buildRowWithExpandedText(
                    context,
                    (viewModel as NewFutureSituationViewModel).descriptionOne,
                    viewModel.explanationOne,
                    width: 300,
                    color: DefaultThemeColors.darkBlue,
                  ),
                  const SizedBox(height: 40),
                ],
                MarkdownBody(
                  content: viewModel.title,
                  textAlignment:
                      viewModel.runtimeType == NewFutureSituationViewModel ? WrapAlignment.center : WrapAlignment.start,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: TextField(
                    onChanged: (text) {
                      NewAspectFormChangeNotification().dispatch(context);
                    },
                    controller: viewModel.aspectTextFieldController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 25),
                      labelText: viewModel.aspectNameLabel,
                      hintText: viewModel.aspectNameHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(width: 2, color: DefaultThemeColors.magenta), // change color here
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(width: 2, color: DefaultThemeColors.veryDarkMagenta), // change color here
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                if (viewModel.runtimeType != NewFutureSituationViewModel) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: viewModel.detailDescriptionController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 25),
                        labelText: viewModel.aspectDetailLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              const BorderSide(width: 2, color: DefaultThemeColors.magenta), // change color here
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              width: 2, color: DefaultThemeColors.veryDarkMagenta), // change color here
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
                Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    MarkdownBody(content: viewModel.sliderLabel),
                    SizedBox(
                      height: 80,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: DefaultThemeColors.magenta,
                          inactiveTrackColor: DefaultThemeColors.lightMagenta.withOpacity(0.5),
                          trackShape: CustomTrackShape(),
                          trackHeight: 40.0,
                          thumbColor: Colors.white,
                          thumbShape: BorderSliderThumbShape(thumbRadius: 30, borderThickness: 6),
                          overlayColor: DefaultThemeColors.magenta.withAlpha(32),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 40.0),
                          tickMarkShape: const RoundSliderTickMarkShape(),
                          activeTickMarkColor: DefaultThemeColors.darkMagenta,
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: DefaultThemeColors.veryDarkMagenta.withOpacity(0.8),
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: Slider(
                          value: viewModel.weight,
                          min: 0.0,
                          max: 1.0,
                          // divisions: 5,
                          label: viewModel.weight.round().toString(),
                          onChanged: (double value) {
                            viewModel.weight = value;
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(viewModel.lowWeightLabel),
                        Text(viewModel.middleWeightLabel),
                        Text(viewModel.highWeightLabel),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
