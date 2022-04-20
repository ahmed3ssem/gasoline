import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gasoline/common/app_colors.dart';
import 'package:gasoline/view/home/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class TimerScreen extends StatefulWidget {

  final int  price;
  final int count;
  final int speed;
  final int priceDecimal;
  final int countDecimal;

   const TimerScreen(this.price, this.count , this.speed , this.priceDecimal , this.countDecimal ,  {Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer priceTimer = Timer(const Duration(seconds: 1), (){});
  Duration priceDuration = const Duration();
  Timer countTimer = Timer(const Duration(seconds: 1), (){});
  Duration countDuration = const Duration();
  int priceSeconds = 0;
  int countSeconds = 0;
  int priceTimerSeconds = 0;
  int countTimerSeconds = 0;

  void startTimer() {
    //Average speed
    if(widget.speed == 0){
      priceTimer = Timer.periodic(const Duration(seconds: 1), (_) => addPriceTimer());
      countTimer = Timer.periodic(const Duration(seconds: 1), (_) => addCountTime());
    }
    //Fast Speed
    if(widget.speed == 1){
      priceTimer = Timer.periodic(const Duration(microseconds: 10), (_) => addPriceTimer());
      countTimer = Timer.periodic(const Duration(microseconds: 10), (_) => addCountTime());
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
      priceDuration = Duration(seconds: 0);
      countDuration = Duration(seconds: 0);
    });
  }

  void addPriceTimer() {
    const addSeconds = 1;
    setState(() {
      priceTimerSeconds = priceDuration.inSeconds + addSeconds;
      priceDuration = Duration(seconds: priceTimerSeconds);
      if(priceTimerSeconds >= priceSeconds){
        priceTimer.cancel();
      }
    });
  }


  void addCountTime() {
    const addSeconds = 1;
    setState(() {
      countTimerSeconds = countDuration.inSeconds + addSeconds;
      countDuration = Duration(seconds: countTimerSeconds);
      if(countTimerSeconds >= countSeconds){
        countTimer.cancel();
      }
    });
  }

  Widget displayPriceTimer() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    String strDigitsMinutes(int n) => n.toString().padLeft(4, '0');
    String minutes = strDigitsMinutes(priceDuration.inMinutes);
    final seconds = strDigits(priceDuration.inSeconds.remainder(100));
    if(widget.priceDecimal>=60 && priceTimerSeconds >= priceSeconds){
      minutes = strDigitsMinutes(priceDuration.inMinutes-1);
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayCountUI(time: seconds),
          Text('.', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.black, fontSize: 100)),
          displayCountUI(time: minutes),
        ]
    );
  }

  Widget displayCountTimer() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    String strDigitsMinutes(int n) => n.toString().padLeft(4, '0');
    String minutes = strDigitsMinutes(countDuration.inMinutes);
    final seconds = strDigits(countDuration.inSeconds.remainder(100));
    if(widget.countDecimal>=60 && countTimerSeconds >= countSeconds){
      minutes = strDigitsMinutes(countDuration.inMinutes-1);
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayTimerUI(time: seconds),
          Text('.', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.black, fontSize: 100)),
          displayTimerUI(time: minutes),
        ]
    );
  }

  Widget displayTimerUI({required String time}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.black, fontSize: 100)),
        ],
      );


  Widget displayCountUI({required String time}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.black, fontSize: 120)),
        ],
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    priceSeconds = widget.price*widget.count*60+widget.priceDecimal;
    countSeconds = widget.count*60+widget.countDecimal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,

      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: ScreenUtil().setHeight(20),),
          displayPriceTimer(),
          SizedBox(height: ScreenUtil().setHeight(20),),
          displayCountTimer(),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Center(
            child: Text((widget.price).toString()+'ج', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.black, fontSize: 70)),
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

