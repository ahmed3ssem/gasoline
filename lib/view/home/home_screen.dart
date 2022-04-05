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
  List<String> speedList = ['سريع' , 'متوسط' , 'بطي'];
  String chosenSpeed = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    componant = HomePresenter();
    componant.setView(this);
    chosenSpeed = speedList[1];
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
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              width: double.infinity,
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(15) , left: ScreenUtil().setWidth(15)),
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(10) , left: ScreenUtil().setWidth(10)),
              child: DropdownButton<String>(
                value: chosenSpeed,
                isExpanded: true,
                iconSize: 24.w,
                underline: const Text(''),
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    chosenSpeed = newValue!;
                  });
                },
                items: speedList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor
                ),
                onPressed: (){
                  if(chosenSpeed == speedList[0]){
                    componant.moveToNextScreen(context, int.parse(model.gasCost) , int.parse(model.gasCount) , 1);
                  }
                  if(chosenSpeed == speedList[1]){
                    componant.moveToNextScreen(context, int.parse(model.gasCost) , int.parse(model.gasCount) , 0);
                  }
                  if(chosenSpeed == speedList[2]){
                    componant.moveToNextScreen(context, int.parse(model.gasCost) , int.parse(model.gasCount) , 2);
                  }
                },
                child: Text('go'.tr().toString() , style: TextStyle(fontWeight: FontWeight.w700 , color: AppColors.white , fontSize: 17.sp),)
            ),
          )
        ],
      ),
    );
  }
}
