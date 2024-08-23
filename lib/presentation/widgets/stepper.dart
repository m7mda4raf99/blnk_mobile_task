import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomStepper extends StatelessWidget {
  final int activeStep;

  CustomStepper(this.activeStep, {super.key});

  List<int> steps = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 65,
            child: EasyStepper(
              direction: Axis.horizontal,
              finishedStepBackgroundColor: const Color(0xFF338CD0),
              finishedStepBorderColor: const Color(0xFF338CD0),
              activeStep: activeStep,
              lineStyle: const LineStyle(
                  lineLength: 87,
                  lineType: LineType.normal,
                  defaultLineColor: Color(0xFFD2D2D2),
                  finishedLineColor: Color(0xFF338CD0)),
              internalPadding: 0,
              showLoadingAnimation: false,
              stepRadius: 15,
              showStepBorder: false,
              steps: [
                for (int i = 0; i < steps.length; i++)
                  EasyStep(
                    customStep: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: activeStep >= i
                              ? const Color(0xFF338CD0)
                              : const Color(0xFFD2D2D2),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: activeStep >= i
                            ? const Color(0xFF338CD0)
                            : Colors.white,
                        child: Text(steps[i].toString(),
                            style: TextStyle(
                                color: activeStep >= i
                                    ? Colors.white
                                    : const Color(0xFFD2D2D2))),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
