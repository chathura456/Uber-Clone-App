import 'package:flutter/cupertino.dart';
import 'package:rider_app/Models/address.dart';



class AppData extends ChangeNotifier
{
Address? pickupLocation;

  void updatePickupLotionAddress(Address pickupAddress){

    pickupLocation=pickupAddress;
    notifyListeners();
  }
}