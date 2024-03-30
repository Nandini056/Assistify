import 'package:assistify/feature_box.dart';
import 'package:assistify/openai_service.dart';
import 'package:assistify/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //all this for speech function and already code is present on the pub.dev site plugin speech-to-text
final speechToText=SpeechToText();
String lastWords='';
final OpenAIService  openAIService=OpenAIService();
  @override
  void initState() {//for speech plugin we have to use init
    // TODO: implement initState
    super.initState();
    initSpeechToText();

  }
Future<void> initSpeechToText() async{
  await speechToText.initialize();
  setState(() {

  });
}
Future<void>  startListening() async {
  await speechToText.listen(onResult: onSpeechResult);
  setState(() {});
}

Future< void >stopListening() async {
  await speechToText.stop();
  setState(() {});
}

void onSpeechResult(SpeechRecognitionResult result) {
  setState(() {
    lastWords = result.recognizedWords;
  });
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assistify'),
        leading: const Icon(Icons.menu),//for corner 3 lines for options in the title bar
      centerTitle: true,//"assistify" in the center
      ),
      body: SingleChildScrollView(// this is used if the app screen is small and exeeding then it will convert content in scroll feature
        child: Column(
          children: [
            //virtual assistant picture section
            Stack(//circleavatar is smaller than the assiatnts image as a stack of two images
              children: [
              
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top:4),// the appbar and image will not overlap
                  decoration: const BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle,
                  ),
                  ),
                ),
                Container(
                  height: 123, //slightly bigger than the circle
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png'))
                ),
                ),
              ],
            ),
           //chat box section
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,//these are for the text inside the box means the padding inside the box when user write somthing
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(// the spaces outside the box from above(image) and below(we didnt use vertical bcz it was not appropriate here
                horizontal: 40).copyWith(
                  top:30,
                ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.blackColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,//we want one side without carve
                ),//to carve the edges of box a little inside
              ),
              child: const Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Good Morning, What task can I do  for you?',
                  style: const TextStyle( fontFamily:'Cera Pro',color: Pallete.mainFontColor, fontSize: 25),),
              ),
              ),
           // the starting line
            Container(
              padding: const EdgeInsets.all(10),
                  alignment:Alignment.centerLeft,
                  margin:EdgeInsets.only(top: 10,left: 30),
                  child: const Text('Here are a few features', style: TextStyle(fontFamily:'Cera Pro', color:Pallete.mainFontColor, fontSize: 20, fontWeight:FontWeight.bold  ),)),
            //features list
            Column(
              children: const [
                FeatureBox(color:Pallete.firstSuggestionBoxColor, headerText: 'ChatGPT',descriptionText:'A smarter way to stay organized and informed with ChatGPT' ,),// this new file is created bcz it will be easier to add differernt feature box with different colors
                FeatureBox(color:Pallete.secondSuggestionBoxColor, headerText: 'Dall-E',descriptionText:'Get inspired and stay creative with your personal assistant powered by Dall-E' ,),
                FeatureBox(color:Pallete.thirdSuggestionBoxColor, headerText: 'Smart Voice Assistant',descriptionText:'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT' ,),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(onPressed:() async {
        if(await speechToText.hasPermission && speechToText.isNotListening ){
          await startListening();
        }else if(speechToText.isListening){
          await openAIService.isArtPromptAPI(lastWords);
          await stopListening();
        }else{
          initSpeechToText();}
      },
        child: const Icon(Icons.mic),),//bcz of material3 mic only good with color and square shaped
    );
  }
}

