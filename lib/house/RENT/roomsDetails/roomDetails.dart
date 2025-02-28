import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../rentStepper/rentStepper.dart';

class roomDetails extends StatelessWidget {
  const roomDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    final PageController _pageController =
    PageController();

    List<String> imagesUrl = [
      "assets/home.png",
      "assets/home.png",
      "assets/home.png",

    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
        title: Text("Available Rooms",
          style: TextStyle(
              color: Colors.black
          ),),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.09,
        // color: Colors.teal,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
            child: InkWell(
              onTap: (){
               // print(data["houseprice"]);
               Get.to(rentStepper(),
                arguments: {
                  "extraservices":data["extraservices"],
                  "extraservicescharges":data["extraservicescharges"],
                  "houseprice":data["houseprice"],
                  "id":data["id"]
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                width: Get.width,
                height: Get.height,
                child: Center(
                  child: Text("Go to booking",
                    style: TextStyle(
                        fontSize: Get.width * 0.04
                    ),),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  // color: Colors.teal,
                  //
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imagesUrl.length,
                    itemBuilder: (_, index) => Container(
                      width: Get.width * 2,
                      height: Get.height,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                              imagesUrl[index],
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                            child: Text("Superior Double Room",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),)),
                      ),
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: imagesUrl.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.black), // your preferred effect

                ),

                //--------

                //----
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Get.width * 0.05
                    ),),
                ),
                //

                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("WebSearch the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: Get.width * 0.036
                      ),),
                  ),
                ),
                //
                //--------

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.07,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.bathtub_rounded,color: Colors.red,size: 25,),
                            Text("4")
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.07,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.bed_sharp,color: Colors.red,size: 25,),
                            Text("4")
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.07,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.scale,color: Colors.red,size: 25,),
                            Text("1000sqY")
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                //----

              ],
            ),
          ),
        ),
      ),
    );
  }
}
