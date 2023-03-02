import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Mybookmark/rents/rentBookmarkController.dart';
import '../SignIn/SignInController.dart';
import '../bookingScreen/bookingScreen.dart';

class RentCarDetails extends StatelessWidget {
  const RentCarDetails({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    SignInController sic = Get.put(SignInController());

    var data = Get.arguments;
    rentBookmarkController rbmc = Get.put(rentBookmarkController( ));

    var description = parse(data["cardescription"]);
    String parsedstring = description.documentElement!.text;

    var pid = data["id"].toString();


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){Get.back();},
            icon: Icon(CupertinoIcons.back),
        color: Colors.black,),
        actions: [
          StreamBuilder(
            stream:  FirebaseFirestore.instance
          .collection('rentalCar-bookmarks')
          .doc(sic.userId)
          .collection('productIds')
          .doc(pid)
          .snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:
              IconButton(onPressed: ()async{
                rbmc.toggleBookmark(data["id"].toString(), data["carname"].toString(),
                    data["carprice"].toString(), data["carimage"].toString());
                print(snapshot.hasData);
              },
                icon :(snapshot.hasData && snapshot.data!.exists)? Icon(
                    Icons.favorite ,
                    color:Colors.red
                )
                : Icon(
                Icons.favorite ,
                color:Colors.grey
            ),) //
            );
          },)
        ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
           //print(data["extraservices"][1].toString());
            Get.to(bookingScreen(),arguments:
            {"carimage": data!["carimage"].toString(),
              "carname":data!["carname"].toString(),
              "carprice":data!["carprice"].toString(),
              "extraservices":data!["extraservices"],
              "extraservicescharges":data!["extraservicescharges"],
              "id":data["id"]
            }
            );
          },
          child: Container(
            width: Get.width * 0.5,
            height: Get.height * 0.06,
            color: Colors.green,
            child: Center(
              child: Text("Next",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Get.width * 0.05
                ),),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: ListView(
          children: [


            CarouselSlider.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      //color: Colors.orange,
                        image: DecorationImage(
                            image: NetworkImage(data!["carimage"].toString()),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover
                        )
                    ),

                  ), options:  CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                //height: Get.height * 0.1,
                aspectRatio: 18/8,
                onPageChanged: (index, reason) {

                }),
            ),
            //-------
            Container(
              // color: Colors.pinkAccent,
              width: Get.width,
              height: Get.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                child: Padding(padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(data!["carname"].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Get.height * 0.02
                          ),
                          softWrap: true,
                        ),
                      ),
                      Text("\$${data!["carprice"].toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: Get.height * 0.02
                        ),),
                    ],
                  ),
                ),
              ),
            ),
            //----------------
            //--
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Text("About",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.02
                  ),),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                //data!["cardescription"].toString()

                child : Text(  parsedstring.toString(),
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: Get.height * 0.02
                  ),
                ),
                /*Text(  description.toString(),
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: Get.height * 0.02
                  ),
                ),*/
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Text("Car Specs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.02
                  ),),
              ),
            ),
            //
            Container(
              width: Get.width,
              height: Get.height * 0.05,
              //color: Colors.red,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for(var i = 0 ; i < data!["carspecs"].length ; i++)...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(data!["carspecs"][i].toString(),
                              softWrap:true,style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
            //
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Text("Car Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: Get.height * 0.025
                  ),),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 /* Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(var i = 0 ; i < data["cardetailicon"].length ; i++) ... [
                            Icon(
                            data["cardetailicon"][i],
                              size: 32.0,
                              color: Colors.green,
                            )
                      ]

                    ],
                  ),*/
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     for(var i = 0 ; i < data!["cardetail"].length ; i++)...[
                       Text(data["cardetail"][i].toString(),
                         style: TextStyle(
                             color: Colors.grey,
                           fontSize: Get.width * 0.045
                         ),),

                     ]
                    ],
                  ),
                  //

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(var i = 0 ; i < data!["cardetailinfo"].length ; i++)...[
                        Text(data["cardetailinfo"][i].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Get.width * 0.045
                          ),)
                      ]
                    ],
                  ),

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
