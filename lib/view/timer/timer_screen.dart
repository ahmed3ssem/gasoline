import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gasoline/common/app_colors.dart';
import 'package:gasoline/model/timer/timer_model.dart';

class TimerScreen extends StatefulWidget {

  final int seconds;

   const TimerScreen(this.seconds, {Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer myTimer = Timer(const Duration(seconds: 1), (){});
  Duration myDuration = const Duration();

  void startTimer() {
    myTimer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      resetTimer();
    }
    setState((){
      myTimer.cancel();
    });
  }

  void resetTimer() {
    setState((){
      myDuration = Duration(seconds: widget.seconds);
    });
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      final priceSeconds = myDuration.inSeconds + addSeconds;
      if (priceSeconds < 0) {
        myTimer.cancel();
      } else {
        myDuration = Duration(seconds: priceSeconds);
      }
    });
  }

  Widget displayPriceTimer() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours);
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayTimerUI(time: seconds),
          SizedBox(width: ScreenUtil().setWidth(8),),
          displayTimerUI(time: minutes),
          SizedBox(width: ScreenUtil().setWidth(8),),
          displayTimerUI(time: hours),
        ]
    );
  }

  Widget displayTimerUI({required String time}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(8) , left: ScreenUtil().setWidth(8) , top: ScreenUtil().setHeight(8) , bottom: ScreenUtil().setHeight(8)),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Text(time, style: TextStyle(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: 45)),
          ),
        ],
      );


  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: TimerModel.counter,
          builder: (context, value, child) {
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              if(value == true){
                resetTimer();
                startTimer();
              } else {
                stopTimer();
              }
            });
            return const SizedBox();
          },
        ),
        displayPriceTimer(),
      ],
    );
  }
}

