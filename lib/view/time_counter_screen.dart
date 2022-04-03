import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gasoline/common/app_colors.dart';
import 'package:gasoline/model/timer/timer_model.dart';
import 'package:gasoline/view/home/home_screen.dart';
import 'package:gasoline/view/timer/timer_screen.dart';

class TimeCounterScreen extends StatefulWidget {

  final int coast;
  final int time;

  const TimeCounterScreen(this.coast, this.time, {Key? key}) : super(key: key);

  @override
  State<TimeCounterScreen> createState() => _TimeCounterScreenState();
}

class _TimeCounterScreenState extends State<TimeCounterScreen> {

  TimerModel model = TimerModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gasoline'.tr().toString()),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: ScreenUtil().setHeight(40),),
          TimerScreen(widget.coast),
          SizedBox(height: ScreenUtil().setHeight(20),),
          TimerScreen(widget.time),
          SizedBox(height: ScreenUtil().setHeight(415),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    //padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)
                  ),
                  onPressed: (){
                    setState(() {
                      TimerModel.counter.value = true;
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
                      TimerModel.counter.value = false;
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
          )
        ],
      ),
    );
  }
}
