import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gasoline/common/app_colors.dart';
import 'package:gasoline/view/home/home_screen.dart';

class TimerScreen extends StatefulWidget {

  final int price;
  final int time;

  const TimerScreen(this.price, this.time, {Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer priceTimer = Timer(const Duration(seconds: 1), (){});
  Duration priceDuration = const Duration();
  Timer timeTimer = Timer(const Duration(seconds: 1), (){});
  Duration timeDuration = const Duration();


  void startTimer() {
    priceTimer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    timeTimer  = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      resetTimer();
    }
    setState((){
      priceTimer.cancel();
      timeTimer.cancel();
    });
  }

  void resetTimer() {
    setState((){
      priceDuration = Duration(seconds: widget.price);
      timeDuration = Duration(seconds: widget.time);
    });
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      final priceSeconds = priceDuration.inSeconds + addSeconds;
      final timeSeconds = timeDuration.inSeconds + addSeconds;
      if (priceSeconds < 0) {
        priceTimer.cancel();
      } else {
        priceDuration = Duration(seconds: priceSeconds);
      }
      if(timeSeconds < 0){
        timeTimer.cancel();
      } else {
        timeDuration = Duration(seconds: timeSeconds);
      }
    });
  }

  Widget displayPriceTimer() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(priceDuration.inHours);
    final minutes = strDigits(priceDuration.inMinutes.remainder(60));
    final seconds = strDigits(priceDuration.inSeconds.remainder(60));
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

  Widget displayTimeTimer() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(timeDuration.inHours);
    final minutes = strDigits(timeDuration.inMinutes.remainder(60));
    final seconds = strDigits(timeDuration.inSeconds.remainder(60));
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

  Widget displayTimerButtons() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                //padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)
              ),
              onPressed: (){
                resetTimer();
                startTimer();
              },
              child: Text(
                'start'.tr().toString(), style: TextStyle(fontSize: 20, color: AppColors.white),)
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                //padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)
              ),
              onPressed: (){
                stopTimer();
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              },
              child: Text(
                'back'.tr().toString(), style: TextStyle(fontSize: 20, color: AppColors.white),)
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gasoline'.tr().toString()),
        centerTitle: true,
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: ScreenUtil().setHeight(40)),
          displayPriceTimer(),
          SizedBox(height: ScreenUtil().setHeight(30),),
          displayTimeTimer(),
          SizedBox(height: ScreenUtil().setHeight(380)),
          displayTimerButtons()
        ],
      ),
    );
  }
}

