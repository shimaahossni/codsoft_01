import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../config/questionModel.dart';
class NextPage extends StatefulWidget {
  final String value;
  const NextPage({super.key, required this.value});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int score=0;
  int index=0;
  bool isSellected=false;
  Answer? selectedAnswer;
  @override
  Widget build(BuildContext context) {
    Size mediaquery=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.deepPurple,
        actions: [
          Text("Welcome ${widget.value}",style: const TextStyle(
              fontSize: 20,
              color: Colors.white
          ),),
          const SizedBox(width: 20,),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            LinearPercentIndicator(
              width: mediaquery.width,
              animation: true,
              lineHeight: 20,
             // percent: (index+.5).toDouble(),
              percent: (index+1)/(questions.length),
              barRadius: const Radius.circular(20),
              progressColor: const Color(0xff9AF09E),
              center: Text("${index+1}/${questions.length}",style: const TextStyle(fontSize: 20),),
            ),
            SizedBox(height: mediaquery.height*.05,),
            Container(
              width: mediaquery.width*.83,
              height: mediaquery.height*.27,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child:  Column(
                children: [
                  const SizedBox(height: 2,),
                  Text(questions[index].text,style: const TextStyle(
                    fontSize: 21,
                    color: Color(0xff461799),
                  ),),
                  Container(
                    // width:  mediaquery.width*.74,
                    clipBehavior: Clip.antiAlias,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Image.asset(questions[index].img,
                      width: mediaquery.width*.8,
                      fit: BoxFit.fill,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: mediaquery.height*.05,),

            for(int i=0;i<questions[index].answer.length;i++)
              answerButton(questions[index].answer[i]),

            nextButton(),

          ],
        ),
      ),
    );
  }

  answerButton(Answer answer){
    isSellected=answer==selectedAnswer;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22)
        ),
        elevation: 18,
        minWidth: MediaQuery.of(context).size.width*.75,
        height: MediaQuery.of(context).size.height*.07,
        color: isSellected? const Color(0xff9AF09E):const Color(0xff6835B6),
        onPressed: () {
          setState(() {
            selectedAnswer=answer;
          });
        }
        ,child: Text(answer.text,style: const TextStyle(
          fontSize: 27
      ),),),
    );
  }

  nextButton(){
    bool isLastQuestion=false;
    if (index==questions.length-1)
    {
      isLastQuestion=true;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)
          ),
          elevation: 20,
          minWidth: MediaQuery.of(context).size.width*.9,
          height: MediaQuery.of(context).size.height*.07,
          color: const Color(0xff6835B6),
          onPressed: () {
            setState(() {
              if(selectedAnswer!.isCorrect)
              {
                score++;
              }
              if(isLastQuestion)
              {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                  return AlertDialog(
                    title: score>questions.length*.6? Text("Your Score is : $score"): Text("Your Score is  : $score"),
                  content: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                      elevation: 18,
                      backgroundColor: const Color(0xff6835B6),

                    ),
                    onPressed: () {
                      setState(() {
                        index=0;
                        score=0;
                        selectedAnswer=null;
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Restart",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),),
                  ),

                  );
                },);
              }
              else
              {
                setState(() {
                  index++;
                  selectedAnswer=null;
                });
              }
            });
          },child:  Text(isLastQuestion?"submit":
      "Next",style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
    );
  }
}

