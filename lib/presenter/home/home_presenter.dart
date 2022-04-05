import 'package:flutter/material.dart';
import 'package:gasoline/presenter/home/home_presenter_componant.dart';
import 'package:gasoline/view/home/home_view_componant.dart';
import 'package:gasoline/view/timer/timer_screen.dart';

class HomePresenter implements HomePresenterComponant{

  late HomeViewComponant viewComponant;
  @override
  void moveToNextScreen(BuildContext context , int price , int count  , int speed) {
    // TODO: implement moveToNextScreen
    Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen(price , count , speed)),);
  }

  @override
  void setView(HomeViewComponant componant) {
    // TODO: implement setView
    viewComponant = componant;
  }


}