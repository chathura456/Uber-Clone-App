import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/Assistants/requestAssistant.dart';
import 'package:rider_app/DataHandler/appData.dart';
import 'package:rider_app/configMaps.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickuptextEditingController=TextEditingController();
  TextEditingController dropfftextEditingController=TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    String placeAddress = Provider.of<AppData>(context).pickupLocation!.placeName ?? "";
    pickuptextEditingController.text = placeAddress;


    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 6.5,
                  offset: Offset(0.7,0.7)
                ),
              ]),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0,top: 25.0,right: 25.0,bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Icon(
                            Icons.arrow_back
                        ),
                      ),

                      Center(
                        child: Text("Set Drop Off",style: TextStyle(fontSize: 18.0,fontFamily: "Brand-Bold"),),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),

                  Row(
                    children: [
                      Image.asset("images/pickicon.png",height: 16.0,),

                      SizedBox(height: 18.0),

                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                controller: pickuptextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Pickup Location",
                                  fillColor: Colors.grey[400],
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),

                  SizedBox(height: 10.0),

                  Row(
                    children: [
                      Image.asset("images/desticon.png",height: 16.0,),

                      SizedBox(height: 18.0),

                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                onChanged: (val)
                                {
                                  findPlce(val);
                                },
                                controller: dropfftextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Where to?",
                                  fillColor: Colors.grey[400],
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> findPlce(String placeName) async {
    if(placeName.length>1)
      {
        String autoCompleteUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapkey&sessiontoken=1234567890&components=country:lk";

        var res = await RequestAssistant.getRequest(Uri.parse(autoCompleteUrl));

        if(res == "failed")
          {
            return;
          }

        print("Place Predection Response :: ");
        print(res);
      }
  }
}
