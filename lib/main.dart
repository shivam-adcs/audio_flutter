import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioRecorder record;
  bool is_Playing=false;
 
Future<dynamic> start_recording() async{
  try{
    print(await record.hasPermission());
    if(await record.hasPermission()){
    await record.start(RecordConfig(), path: "abc.m4a");
    print("it has permissions ++++++++++++++++++++++++++++++++++++++++");
    }
  }
  catch(e){
    print(e.toString());
  }
}

Future<dynamic> stop_recording() async{
  
  try{
    final path=await record.stop();
    print(path);
  }
  catch(e){
    print(e.toString());
  }
}

@override
  void initState() {
    super.initState();
    record=AudioRecorder();
  }

  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Audio Recorder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(onPressed: ()async {
              if(!is_Playing){
                await start_recording();
                is_Playing=!is_Playing;
              }
              else{
                await stop_recording();
                is_Playing=!is_Playing;
              }

              setState(() {
                
              });
            }, icon: is_Playing?Icon(CupertinoIcons.pause):Icon(CupertinoIcons.mic),label:Text("")),
          ],
        ),
      ),
    );
  }
}
