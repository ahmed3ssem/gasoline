import 'package:flutter/material.dart';
import 'package:gasoline/presenter/home/home_presenter_componant.dart';
import 'package:gasoline/view/home/home_view_componant.dart';
import 'package:gasoline/view/timer/timer_screen.dart';

class HomePresenter implements HomePresenterComponant{

  late HomeViewComponant viewComponant;
  @override
  void moveToNextScreen(BuildContext context , double price , double count  , int speed) {
    // TODO: implement moveToNextScreen
    double priceSum = price*count;
    int priceValue = 0;
    int countValue = 0;
    int priceDecimal = 0;
    int countDecimal = 0;
    List<String> priceSplit = priceSum.toString().split('.');
    if(priceSplit[1].toString().length>2){
      priceSum = double.parse((priceSum).toStringAsFixed(2));
      priceSplit = priceSum.toString().split('.');
    }
    final countSplit = count.toString().split('.');
    priceValue = int.parse(priceSplit[0]);
    priceDecimal = int.parse(priceSplit[1]);
    countValue = int.parse(countSplit[0]);
    countDecimal = int.parse(countSplit[1]);
    if(priceDecimal.toString().length>2){
      priceDecimal = int.parse(priceDecimal.toString().substring(0,2));
    }
    if(countDecimal.toString().length>2){
      countDecimal = int.parse(countDecimal.toString().substring(0 , 2));
    }
    print(priceSum);
    print(priceSplit.runtimeType);
    print('PriceValue '+priceValue.toString()+' PriceD '+priceDecimal.toString()+' CV '+countValue.toString()+' CD '+countDecimal.toString());
    print(priceValue.toString()+priceDecimal.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen(priceValue , countValue , speed , priceDecimal , countDecimal , price)),);
  }

  @override
  void setView(HomeViewComponant componant) {
    // TODO: implement setView
    viewComponant = componant;
  }


}