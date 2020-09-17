import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sahayogihaath/routes.dart';
import '../../screens/donationDetail.dart';
import '../../constants/transaction_const.dart';
//transaction card
class TransactionCard extends StatelessWidget {
   DateTime day;
   String donee;
   String donor;
   String time;
   double amount;
  String donorImage;
  TransactionCard({this.day,@required this.donor, @required this.donee, @required this.time, @required this.donorImage, @required this.amount});
  
                      
String setDate(DateTime day){
  
  DateTime now = DateTime.now();
  final day2 = DateTime(day.year,day.month,day.day);
  int day1 = now.difference(day2).inDays;
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year,now.month,now.day-1);
  var timeAgo = day1.toString();
  String ago ;
  if(day2 == today){
    ago = 'Today';
  }
  else if(day2 == yesterday){
      ago = 'Yesterday';
  }
  else if(day1 >=2  && day1 < 30){
    ago = '$timeAgo days ago';
  } 

  else if(day1 >=30 && day1<=32){
    ago = ' 1 month ago';
  }
  else{
    ago = 'Few months ago';
  }
  return(ago);       
}
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double height =  queryData.size.height*0.007;
    double cardWidth = MediaQuery.of(context).size.width*0.9;
    double width = cardWidth*0.035;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(setDate(day), style: kTransactionCardBoxText,),
        SizedBox(
                    height: queryData.size.height*0.007,
                  ),
        Container(
              margin: EdgeInsets.symmetric(vertical: height),
              width:MediaQuery.of(context).size.width*0.95,
              height:MediaQuery.of(context).size.height*0.1,
              decoration:kHomeDecoration,
              padding: EdgeInsets.all(width),
              child: Container(
                 width: cardWidth*1,
                child: Row(
                  children: <Widget>[
                  FittedBox(
                    child: Container(
                      width: cardWidth*0.12,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://image.shutterstock.com/image-photo/mountains-during-sunset-beautiful-natural-260nw-407021107.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth*0.03,
                  ),
                  Container(
                    width: cardWidth*0.35,
                    child: FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  'to:',
                                  style: kTransactionCardBoxText
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.02,
                              ),
                              FittedBox(
                                child: Text(
                                  donee, 
                                  style: kTransactionCardDoneeBoxText
                                ),
                              ),
                            ]
                          ),
                          FittedBox(
                            child: Wrap(
                               alignment: WrapAlignment.spaceBetween,
                               direction: Axis.vertical,
                               children: [
                                Text( 
                                    donor, 
                                    style:kDetailTransactionCardText
                                  ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.02,
                                ),
                                Text(
                                  '$time',
                                  style: kDetailTransactionCardText
                                ),
                              ],
                            ),
                          ),
                          
                        ]
                      ),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth*0.05,
                  ),
                    Container(
                      alignment: Alignment(1.0,0.0),
                      width: cardWidth*0.40,
                      child: FittedBox(
                              child: Row(
                                children: [
                                  FittedBox(
                                                                      child: Text('Rs $amount',
                                      style: kAmount,
                                    ),
                                  ),
                                  FittedBox(
                                    child: IconButton(
                                      iconSize: MediaQuery.of(context).size.width*0.09,
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=> DonationDetail(
                                            orgName: donee,
                                            amount: amount,
                                            time: time,
                                            donor: donor,
                                          ),
                                        ),
                                        ) ;                                     
                                      },
                                      icon:Icon(
                                        Icons.arrow_right,
                                      )
                                    ),
                                ),
                                ],
                              ),
                            ),
                             
                    ),  
                  ]
                  
                ),
              ),
                  
        
        ),
        SizedBox(
                    height: height*0.02,
                  ),
      ],
    );
  }
}

