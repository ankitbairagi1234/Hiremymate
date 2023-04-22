import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
        AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    CustomColors.grade1,
                    CustomColors.grade,
                  ],
                  stops: [
                    0,
                    1,
                  ]),
            ),
          ),
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColors.AppbarColor1.withOpacity(0.4)
                  ),
                  child: Icon(Icons.arrow_back,color: CustomColors.AppbarColor1,),
                ),
              )
          ),
          title: Text('"Notification',style: TextStyle(color: Colors.white,fontSize: 20),),
          // actions: [
          //   InkWell(
          //     onTap: (){
          //       Navigator.pop(context);
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(8),
          //       child: Container(
          //         height: 45,
          //         width: 45,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: CustomColors.AppbarColor1.withOpacity(0.4)
          //         ),
          //         child: InkWell(
          //             onTap: (){
          //               Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
          //             },
          //             child: Icon(Icons.notifications_none,color: CustomColors.AppbarColor1,)),
          //       ),
          //     ),
          //   ),
          // ],


        ),
        //customAppBar(text: "Notification",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 5),
                //   child: Align(
                //     alignment: Alignment.topRight,
                //     child: Text("Clear All",style: TextStyle(
                //         color: CustomColors.darkblack,fontSize: 18,fontWeight: FontWeight.normal
                //     ),),
                //   ),
                // ),

                Container(
                  child: ListView.builder(
                      physics:  NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                          //  height: MediaQuery.of(context).size.height/5.3,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child:Card(
                              elevation: 3,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: 5,left: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        // Padding(
                                        //   padding: const EdgeInsets.all(
                                        //       8.0),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.circular(50),
                                        //     child: Image.asset("assets/images/notification.png",
                                        //       height: 70,
                                        //       width: 70,
                                        //       fit: BoxFit.fill,
                                        //     ),
                                        //   ),
                                        // ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets
                                                  .only(top: 10),
                                              child: Text(
                                                'Johan Deo',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.2,
                                              child: Text(
                                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight
                                                        .normal,color: CustomColors.lightblackAllText),
                                                // overflow: TextOverflow.ellipsis,

                                              ),

                                            ),SizedBox(height: 8,),
                                            Row(
                                              children: [
                                                Icon(Icons.access_time,color: CustomColors.lightgray.withOpacity(0.2),size: 20,),
                                                SizedBox(width: 5,),
                                                Text("Just Now",style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight
                                                        .normal,color: CustomColors.lightgray.withOpacity(0.2)))
                                              ],
                                            ),
                                            SizedBox(height: 5,),


                                          ],
                                        ),

                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
