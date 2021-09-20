import 'package:avatar_view/avatar_view.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'dart:io' as platform;

import 'package:flutter/widgets.dart';

class CameraWithMaskFiltersScreen extends StatefulWidget {
  const CameraWithMaskFiltersScreen({Key? key}) : super(key: key);

  @override
  _CameraWithMaskFiltersScreenState createState() => _CameraWithMaskFiltersScreenState();
}

class _CameraWithMaskFiltersScreenState extends State<CameraWithMaskFiltersScreen> {

  late CameraDeepArController cameraDeepArController;
  String platformVersion = "Unknown";
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffects= Effects.none;
  Filters currentFilters= Filters.none;
  Masks currentMask = Masks.none;
  String path1 = "Android/data/com.example.todo_app/files/Pictures";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [


            //DEEP AR CAMERA
            CameraDeepAr(

          onCameraReady: (isReady){
            platformVersion = "Camera Status $isReady";
            print(platformVersion);
            setState(() {

            });
      },
              onImageCaptured: (path1){
                platformVersion = "Image saved at $path1";
                print(platformVersion);
                setState(() {

                });
              },
              androidLicenceKey: "2c0c13631dd1ed05568a0e7291adad75931106a2c86aba75f3abf6818612213b40eca1f9bfb6d62c",
        cameraDeepArCallback: (c) async{
            cameraDeepArController = c;
            setState(() {

            });
        },

            ),

            //FACE MASk FILTERS- icon button

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 28.0,right: 28.0),
                    child: Expanded(
                      child: ElevatedButton(
                          child: Icon(Icons.camera_enhance,color: Colors.white,),
                        onPressed:(){
                            if(null == cameraDeepArController){
                              return;
                            }else{
                              cameraDeepArController.snapPhoto();
                            }
                        } ,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),

                      ),),


                    ),),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                        List.generate(8,(page){

    bool active = currentPage == page;

    return platform.Platform.isIOS
    //IOS APP VIEW
    ?GestureDetector(
      onTap: (){
        currentPage = page;
        cameraDeepArController.changeMask(page);
        setState(() {

        });
      },
      child: AvatarView(
        radius: active ? 65 : 30,
        borderColor: Colors.yellowAccent,
        borderWidth: 2,
        isOnlyText: false,
        avatarType: AvatarType.CIRCLE,
        backgroundColor: Colors.red,
        imagePath: "assets/ios/${page.toString()}.jpg",
        placeHolder: Icon(Icons.person,size: 50,),
        errorWidget: Container(
          child: Icon(Icons.error,size: 50,),
        ),
      ),
    )


    //ANDROID APP VIEW
        :
    GestureDetector(

      onTap: (){
        currentPage = page;
        cameraDeepArController.changeMask(page);
        setState(() {

        });
      },
      child: AvatarView(
        radius: active ? 45 : 25,
        borderColor: Colors.yellowAccent,
        borderWidth: 2,
        isOnlyText: false,
        avatarType: AvatarType.CIRCLE,
        backgroundColor: Colors.red,
        imagePath: "assets/android/${page.toString()}.jpg",
        placeHolder: Icon(Icons.person,size: 50,),
        errorWidget: Container(
          child: Icon(Icons.error,size: 50,),
        ),
      ),


    );
    }
                        )




                      ),
                    )
                  ],
                ),
              ),
            )



          ],
        ),
      ),
    );
  }
}
