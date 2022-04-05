import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gasoline/common/app_colors.dart';
import 'package:gasoline/view/home/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class TimerScreen extends StatefulWidget {

  final int price;
  final int count;
  final int speed;

   const TimerScreen(this.price, this.count , this.speed ,  {Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer priceTimer = Timer(const Duration(seconds: 1), (){});
  Duration priceDuration = const Duration();
  Timer countTimer = Timer(const Duration(seconds: 1), (){});
  Duration countDuration = const Duration();

  void startTimer() {
    //Average speed
    if(widget.speed == 0){
      priceTimer = Timer.periodic(const Duration(seconds: 1), (_) => addPriceTimer());
      countTimer = Timer.periodic(const Duration(seconds: 1), (_) => addCountTime());
    }
    //Fast Speed
    if(widget.speed == 1){
      priceTimer = Timer.periodic(const Duration(milliseconds: 10), (_) => addPriceTimer());
      countTimer = Timer.periodic(const Duration(milliseconds: 10), (_) => addCountTime());
    }
    //Slow Speed
    if(widget.speed == 2){
      priceTimer = Timer.periodic(const Duration(seconds: 10), (_) => addPriceTimer());
      countTimer = Timer.periodic(const Duration(seconds: 10), (_) => addCountTime());
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      resetTimer();
    }
    setState((){
      priceTimer.cancel();
      countTimer.cancel();
    });
  }

  void resetTimer() {
    setState((){
      priceDuration = Duration(seconds: widget.price);
      countDuration = Duration(seconds: widget.count);
    });
  }

  void addPriceTimer() {
    const addSeconds = -1;
    setState(() {
      final priceSeconds = priceDuration.inSeconds + addSeconds;
      if (priceSeconds < 0) {
        priceTimer.cancel();
      } else {
        priceDuration = Duration(seconds: priceSeconds);
      }
    });
  }

  void addCountTime() {
    const addSeconds = -1;
    setState(() {
      final priceSeconds = countDuration.inSeconds + addSeconds;
      if (priceSeconds < 0) {
        countTimer.cancel();
      } else {
        countDuration = Duration(seconds: priceSeconds);
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

  Widget displayCountTimer() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(countDuration.inHours);
    final minutes = strDigits(countDuration.inMinutes.remainder(60));
    final seconds = strDigits(countDuration.inSeconds.remainder(60));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('gasoline'.tr().toString()),
        centerTitle: true,
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: ScreenUtil().setHeight(20),),
          displayPriceTimer(),
          SizedBox(height: ScreenUtil().setHeight(20),),
          displayCountTimer(),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Container(
            width: ScreenUtil().setWidth(50),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(120) , left: ScreenUtil().setWidth(120)),
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(8) , left: ScreenUtil().setWidth(8) , top: ScreenUtil().setHeight(8) , bottom: ScreenUtil().setHeight(8)),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text((widget.count*widget.price).toString()+'ج', style: TextStyle(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: 45)),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor,
                      //padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)
                    ),
                    onPressed: (){
                      setState(() {
                        resetTimer();
                        startTimer();
                      });
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
                      setState(() {
                        stopTimer();
                      });
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
          ),

        ],
      ),
    );
  }
}

