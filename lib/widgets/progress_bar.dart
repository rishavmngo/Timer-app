import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:timer_app/riverpod/timer.dart';

class ProgressBar extends ConsumerWidget {
  const ProgressBar({super.key});

  final double progressBarRadius = 270;
  final double barThickness = 1;
  final double circularMarkerWidth = 25;
  final double progressValue = 90;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(timerProvider)?.percent;
    return SizedBox(
      height: progressBarRadius,
      width: progressBarRadius,
      child: SfRadialGauge(
        axes: [
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: -90,
            endAngle: 270,
            axisLineStyle: AxisLineStyle(
              thickness: barThickness,
              //cornerStyle: CornerStyle.bothCurve,
              color: const Color(0xFFe4e2a7),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
          ),
          RadialAxis(
            minimum: 0,
            maximum: 100,
            startAngle: -90,
            endAngle: 270,
            showLabels: false,
            showTicks: false,
            pointers: <GaugePointer>[
              RangePointer(
                value: percent ?? 100.0,
                width: .1,
                color: const Color(0xFF8ec133),
                cornerStyle: CornerStyle.bothCurve,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              MarkerPointer(
                value: percent ?? 100.00,
                markerType: MarkerType.circle,
                markerWidth: circularMarkerWidth,
                markerHeight: circularMarkerWidth,
                color: const Color(0xFF8ec133),
              ),
            ],
            axisLineStyle: const AxisLineStyle(
              thickness: .1,
              //cornerStyle: CornerStyle.bothCurve,
              color: Color(0xFFc3c36d),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            annotations: [
              GaugeAnnotation(
                  verticalAlignment: GaugeAlignment.center,
                  horizontalAlignment: GaugeAlignment.center,
                  widget: Container(
                    height: 250,
                    width: 250,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage("assets/Timer_tree.png"))),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
