import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {

  Login(){}

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {

  final textNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('personne').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return Scaffold(
              backgroundColor: Color.fromRGBO(147, 160, 191, 1),
              body :  ListView(
                  children : [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.width * 0.08)
                          ),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                            text(context, "Qui est l'heureuse personne\n"+
                                "se prêtant à ce sublime\n"+
                                "features-swapping\n"+
                                "développé par le plus parfait\n"+
                                "des Techs Annéciens ?"),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.77,
                                child:
                                Row(children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      child: TextField(
                                          controller: textNameController,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              hintText: 'Omelette du fromage',
                                              filled: true,
                                              fillColor: Color.fromRGBO(245, 245, 245, 1),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
                                                borderSide: BorderSide.none,
                                              )
                                          )
                                      )
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.05
                                  ),
                                  bouton(context,textNameController)
                                ])
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05
                            )
                          ],
                        )
                    )
                  ]
              )
          );
        }
      );



  }
}

text(BuildContext context, String text){
  return Text(text,
      style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w700,
          fontSize: MediaQuery.of(context).size.height * 0.030,
          color: Color.fromRGBO(47, 46, 65, 1)
      ));
}

bouton(context, TextEditingController textController){
 return  Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      color: Color.fromRGBO(235, 107, 107, 1),
      shape: BoxShape.circle,
    ),
    child: InkWell(
      customBorder: CircleBorder(),
      onTap: () async {
        if(textController.text != null && textController.text.isNotEmpty) {
          CollectionReference participantsRef = FirebaseFirestore.instance.collection('participant');
          DocumentReference newParticipantRef = await participantsRef.add({
            'nom': textController.text,
          });
          Navigator.pushNamed(context, '/swipe', arguments: {'id' : newParticipantRef.id});
        }
      },
      child: Center(
        child: Text(
          'OK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
