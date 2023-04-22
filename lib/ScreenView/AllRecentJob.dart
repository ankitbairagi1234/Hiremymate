import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/ScreenView/jobDescription.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../Model/recentJobModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';

class AllRecentJob extends StatefulWidget {
  const AllRecentJob({Key? key}) : super(key: key);

  @override
  State<AllRecentJob> createState() => _AllRecentJobState();
}

class _AllRecentJobState extends State<AllRecentJob> {

  RecentJobModel? recentJobModel;
  getRecentJobs()async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=e50d052344b0c13605f8ef8be2d6c3a834438e7e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}latest_job'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = RecentJobModel.fromJson(json.decode(finalResult));
      setState(() {
        recentJobModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  saveToJob(id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}save_job'));
    request.fields.addAll({
      'job_id': '${id}',
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          getRecentJobs();
        });
      }

    }
    else {
      print(response.reasonPhrase);
    }
  }

  removeFromSave(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=5a37ed79b483f5766738a21c88679dc79add7041'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}remove_fav_job'));
    request.fields.addAll({'job_id': '${id}', 'user_id': '${userid}'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if (jsonResponse['status'] == true) {
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          getRecentJobs();
        //  getPopularJobs();
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getRecentJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.TransparentColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(text: "Recent Jobs",istrue: true ,),
            Expanded(
              child: recentJobModel == null  ? Center(child: CircularProgressIndicator(),) :  ListView.builder(
                // physics:  NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: recentJobModel!.data!.length,
                  itemBuilder: (context, index) {
                    return  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailScreen(jobData: recentJobModel,index: index,)));
                      },
                      child: Container(
                        // width: MediaQuery
                        //     .of(context)
                        //     .size
                        //     .width / 1.3,
                        child: Card(
                          elevation: 5,
                          color:Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            mainAxisAlignment: MainAxisAlignment
                                .start,
                            children: [
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 8,),
                                      recentJobModel!.data![index].img == "" || recentJobModel!.data![index].img == null ? Image.asset(
                                        "",
                                        height: 60,
                                        width: 60,
                                        // fit: BoxFit.fill,
                                      ) : Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: CustomColors.lightgray)
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),

                                          child: Image.network("${ApiPath.imageUrl}${recentJobModel!.data![index].img}",fit: BoxFit.fill,),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets
                                                .only(top: 10),
                                            child: Text(
                                              recentJobModel!.data![index].designation.toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .bold),
                                            ),
                                          ),
                                          SizedBox(height: 3,),
                                          Text(
                                            recentJobModel!.data![index].companyName.toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight
                                                    .normal),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, left: 5),
                                    child: Row(
                                      children: [
                                      recentJobModel!.data![index].veri != "yes" ? SizedBox.shrink() :  Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: Colors.green,width: 1)
                                          ),
                                          child:Text("Verified",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                                        ),
                                        SizedBox(width: 5,),
                                        InkWell(
                                          onTap: ()async{
                                            if(recentJobModel!.data![index].isFav == true){
                                              removeFromSave("${recentJobModel!.data![index].id}");
                                            }
                                            else{
                                            saveToJob(recentJobModel!.data![index].id);
                                          }},
                                          child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .AppbarColor1,
                                                  borderRadius: BorderRadius
                                                      .circular(50)
                                              ),
                                              child: recentJobModel!.data![index].isFav == true ? Icon(Icons.bookmark_rounded,size: 28,color: CustomColors.primaryColor,) : Icon(Icons.bookmark_outline_outlined,size: 28,)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 10),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].min.toString()))} - ${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].max.toString()))} ${recentJobModel!.data![index].salaryRange}",
                                          style: TextStyle(color: CustomColors.darkblack,
                                            fontSize: 15,
                                            fontWeight: FontWeight
                                                .w500,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: CustomColors.lightgray,  //color of divider
                                        //width space of divider
                                        thickness: 1, //thickness of divier line
                                        //Spacing at the bottom of divider.
                                      ),
                                      Expanded(
                                        child: Text(
                                          recentJobModel!.data![index].designation.toString(),
                                          style: TextStyle(color: CustomColors.darkblack,
                                              fontSize: 15,
                                              fontWeight: FontWeight
                                                  .w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      VerticalDivider(
                                        color:CustomColors.lightgray,  //color of divider
                                        //width space of divider
                                        thickness: 1, //thickness of divier line
                                        //Spacing at the bottom of divider.
                                      ),

                                      Expanded(
                                        child: Text(
                                          recentJobModel!.data![index].location.toString(),
                                          style: TextStyle(color: CustomColors.darkblack,
                                            fontSize: 15,
                                            fontWeight: FontWeight
                                                .w500,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // IntrinsicHeight(
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: Text(
                              //           "${recentJobModel!.data![index].min} - ${recentJobModel!.data![index].max} ${recentJobModel!.data![index].salaryRange}",
                              //           style: TextStyle(color: CustomColors.darkblack,
                              //             fontSize: 15,
                              //             fontWeight: FontWeight
                              //                 .normal,),
                              //           textAlign: TextAlign.start,
                              //         ),
                              //       ),
                              //       VerticalDivider(
                              //         color: CustomColors.lightgray,  //color of divider
                              //        //width space of divider
                              //         thickness: 1, //thickness of divier line
                              //       //Spacing at the bottom of divider.
                              //       ),
                              //       Expanded(
                              //         child: Text(
                              //           recentJobModel!.data![index].designation.toString(),
                              //           style: TextStyle(color: CustomColors.darkblack,
                              //               fontSize: 15,
                              //               fontWeight: FontWeight
                              //                   .normal),
                              //           textAlign: TextAlign.center,
                              //         ),
                              //       ),
                              //       VerticalDivider(
                              //         color:CustomColors.lightgray,  //color of divider
                              //         //width space of divider
                              //         thickness: 1, //thickness of divier line
                              //         //Spacing at the bottom of divider.
                              //       ),
                              //
                              //       Expanded(
                              //         child: Text(
                              //           recentJobModel!.data![index].location.toString(),
                              //           style: TextStyle(color: CustomColors.darkblack,
                              //             fontSize: 15,
                              //             fontWeight: FontWeight
                              //                 .normal,),
                              //           textAlign: TextAlign.center,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
