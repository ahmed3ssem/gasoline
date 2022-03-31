import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gasoline/common/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gasoline/model/home/home_model.dart';
import 'package:gasoline/presenter/home/home_presenter.dart';
import 'package:gasoline/presenter/home/home_presenter_componant.dart';
import 'package:gasoline/view/home/home_view_componant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeViewComponant{

  final HomeModel model = HomeModel();
  late HomePresenterComponant componant;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    componant = HomePresenter();
    componant.setView(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gasoline'.tr().toString()),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: ScreenUtil().setHeight(50),),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(18), right: ScreenUtil().setWidth(18)),
            child: Text('gasolineCost'.tr().toString() , style: TextStyle(color: AppColors.black , fontSize: 15.sp , fontWeight: FontWeight.w400),),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(3) , right: ScreenUtil().setWidth(15) , left: ScreenUtil().setWidth(15)),
            height: ScreenUtil().setHeight(55),
            child: TextField(
              onChanged: (val){
                setState(() {
                  model.gasCost = val;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '100',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(18) , right: ScreenUtil().setWidth(18)),
            child: Text('gasolineCount'.tr().toString() , style: TextStyle(color: AppColors.black , fontSize: 15.sp , fontWeight: FontWeight.w400),),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(3) , right: ScreenUtil().setWidth(15) , left: ScreenUtil().setWidth(15)),
            height: ScreenUtil().setHeight(55),
            child: TextField(
              onChanged: (val){
                setState(() {
                  model.gasCount = val;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '20',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(18) , right: ScreenUtil().setWidth(18)),
            child: Text('gasolineTimer'.tr().toString() , style: TextStyle(color: AppColors.black , fontSize: 15.sp , fontWeight: FontWeight.w400),),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(3) , right: ScreenUtil().setWidth(15) , left: ScreenUtil().setWidth(15)),
            height: ScreenUtil().setHeight(55),
            child: TextField(
              onChanged: (val){
                setState(() {
                  model.timer = val;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '10',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(245),),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor
                ),
                onPressed: (){
                  componant.moveToNextScreen(context, int.parse(model.gasCost) , int.parse(model.timer));
                },
                child: Text('go'.tr().toString() , style: TextStyle(fontWeight: FontWeight.w700 , color: AppColors.white , fontSize: 17.sp),)
            ),
          )
        ],
      ),
    );
  }
}
