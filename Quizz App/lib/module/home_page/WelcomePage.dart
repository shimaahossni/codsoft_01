import 'package:flutter/material.dart';
import '../pages/next_page.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName="welcome";
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size mediaquery=MediaQuery.of(context).size;
    var Nametextcontroller= TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
     // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: mediaquery.height*.2,),
            Image.asset("assets/images/welcome.png"),
            const Row(
              children: [
                SizedBox(width: 20,),
                Text("Welcome",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Row(

              children: [
                SizedBox(width: 20,),
                Text("To ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                  ),
                ),
                SizedBox(width: 10,),
                Text("QuizApp",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(" Game",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              children: [
                SizedBox(width: 20,),
                Text("Play, Learn and Explore with Exciting Quizes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
             SizedBox(height: mediaquery.height*.1,),
            //SizedBox(height:MediaQuery.of(context).viewInsets.bottom),
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: Nametextcontroller,
                style: TextStyle(color: Colors.white,fontSize: 20),
                decoration:  InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    var route=MaterialPageRoute(builder: (context)=>NextPage(value: Nametextcontroller.text),
                    );
                    Navigator.of(context).push(route);
                  }, icon: const Icon(Icons.play_arrow_rounded,size: 50,color: Colors.white,)),
                  border: const OutlineInputBorder(),
                  hintText: 'Enter your name',
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                maxLength: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


