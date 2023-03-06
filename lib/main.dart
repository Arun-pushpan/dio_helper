import 'dart:convert';

import 'dart:math';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesing/screen/model/card_image_model.dart';
import 'package:tesing/screen/services/dio_helper.dart';
import 'package:tesing/screen/services/repository/card_repo.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

   MyHomePage({required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   String? fullName="Arun";
   String? email="arun@gmail.com";
   int? phoneNo=8796869692;
   String? cardType="normal";
   String? backGroundImage;
   File? addImage;



  @override
 final ApiHelper apihelper =ApiHelper();
 final CardRepo cardRepo = CardRepo();
  late  List<Carding?> cardImageList;

  void initState(){
    super.initState();
    cardImageList=[];
    getCard();
  }
  getCard() async {
    // creating a function
    Response? response = await cardRepo.getCardImage();
   print(response);
    try {
      if (response?.statusCode == 200) {
        var data = json.encode(
            response?.data);
        print(data);
        // response assign to the data variable
        CardImageModel result = cardImageModelFromJson(
            data); // calling the data from the model class
        cardImageList = result.cards;
      }
      } catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                  )),
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.20,
              child: addImage != null
                  ? Container(
                height: MediaQuery.of(context).size.height * 0.10,

                width: MediaQuery.of(context).size.width * 0.20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(addImage!),
                        fit: BoxFit.cover)),
              )
                  : IconButton(
                  onPressed: () {
                    proPickImage();
                  },
                  icon: Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 40,
                  ))),
          /// text with inkwell
          InkWell(
              onTap: () {
                proPickImage();
              },
              child: const Text("Upload Your Photo",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400))),
           SizedBox(height: 30,),

          TextFormField(
            decoration: InputDecoration(

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),),


            ),


          )
        ],
      )
      // body: ListView.builder(
      //   itemCount: cardImageList.length,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         title: Text(cardImageList[index]?.fullName?? ''),
      //         subtitle: Text(cardImageList[index]?.email??''),
      //
      //       );
      //     },)
    );
  }
  Future proPickImage() async {
    try {
      final proImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 60);
      if (proImage == null) {
        return;
      }
      final imageTemporary = File(proImage.path);
      setState(() => addImage = imageTemporary);
    } on PlatformException {
      return "Failed to Pick";
    }
  }
  postData( )async{
    try{

      Response response= cardRepo.postImage(fullName!, email!, phoneNo!, cardType!, backGroundImage as File) as Response;
      if(response.statusCode == 200){
        CardImageModel cardImageModel =CardImageModel.fromJson(response.data);
      }
    }catch(e){
      throw Exception(e);
    }
  }
}
