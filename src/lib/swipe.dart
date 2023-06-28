import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Swipe extends StatefulWidget {

  Swipe(){}

  @override
  State<StatefulWidget> createState() => SwipeState();
}

class SwipeState extends State<Swipe>  with TickerProviderStateMixin {

  var text = null;

  @override
  Widget build(BuildContext context)  {
    final Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    final String idPart = arguments['id'];

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('feature').doc('Gvr9F4zCjZZTXOdQYQcG').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final Map<String,dynamic> features = snapshot.data.data() as Map<String, dynamic>;

            double _width = MediaQuery.of(context).size.width;
            double _height = MediaQuery.of(context).size.height;
            CardController controller; //Use this to trigger swap.

            return Scaffold(
                backgroundColor: Color.fromRGBO(147, 160, 191, 1),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (text != null) Text(text) ,
                      Container(
                        height: _height * 0.8,
                        child: TinderSwapCard(
                          totalNum: features.length,
                          stackNum : 2,
                          maxWidth: _width * .8,
                          maxHeight: _height * .8,
                          minWidth: _width * .799,
                          minHeight: _height * .799,
                          cardBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.all(_width * 0.060),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(47, 46, 65, 1),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Text(
                                    features[index.toString()],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    fontSize: _height * 0.038
                                  ),
                                )
                            );
                          },
                          cardController: controller = CardController(),
                          swipeCompleteCallback:
                              (CardSwipeOrientation orientation, int index) async {

                            bool choice = (orientation == CardSwipeOrientation.RIGHT);
                            CollectionReference voteRef = FirebaseFirestore.instance.collection('vote');
                            await voteRef.add({
                              'choix': choice,
                              'idFeature': index,
                              'idParticipant': idPart,
                              'important': null
                            });

                            //if(index == features.length-1)
                          },
                        ),
                      ),
                    ]
                )
            );

          } else if (snapshot.hasError) {
            return Text('Error fetching document');
          } else {
            return Text('Document does not exist');
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

