import 'package:shutter_stock/services/shutter_stock_services.dart';

bool ifItIsNull(ShutterStockServices myServices, int index, String check){

  return myServices.data[index][check] == null;
  
  // if(myServices.data[index][check] == null){
  //   return true;
  // }
  // else{
  //   return false;
  // }

}