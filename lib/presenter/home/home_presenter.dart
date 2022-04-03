import 'package:flutter/material.dart';
import 'package:gasoline/presenter/home/home_presenter_componant.dart';
import 'package:gasoline/view/home/home_view_componant.dart';
import 'package:gasoline/view/time_counter_screen.dart';

class HomePresenter implements HomePresenterComponant{

  late HomeViewComponant viewComponant;
  @override
  void moveToNextScreen(BuildContext context , int price , int timer ) {
    // TODO: implement moveToNextScreen
    Navigator.push(context, MaterialPageRoute(builder: (context) => TimeCounterScreen(price , timer)),);
  }

  @override
  void setView(HomeViewComponant componant) {
    // TODO: implement setView
    viewComponant = componant;
  }


}