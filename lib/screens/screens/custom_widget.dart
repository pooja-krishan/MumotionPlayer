import 'package:flutter/material.dart';
import 'package:mumotionplayer/constants.dart';
class CustomWidget extends StatelessWidget {
  final double size;
  final Widget child;
  final double borderWidth;
  final image;
  final bool networkImage;
  final bool isActive;
  final VoidCallback onTap;
  final bool radius;
  CustomWidget({this.child,@required this.onTap, @required this.size, this.borderWidth = 2, this.image, this.isActive = false,this.networkImage,this.radius});



  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: radius?BorderRadius.all(
        Radius.circular(200),
      ):BorderRadius.all(
        Radius.circular(0),
      ),
      border: Border.all(
        width: borderWidth,
        color: isActive ? AppColors.darkBlue : AppColors.mainColor,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.lightBlueShadow,
          blurRadius: 10,
          offset: Offset(5,5),
          spreadRadius: 3,
        ),
        BoxShadow(
          color: Colors.white,
          blurRadius: 10,
          offset: Offset(-5,-5),
          spreadRadius: 3,
        )
      ],

    );

    if(networkImage==true){
      boxDecoration = boxDecoration.copyWith(image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover,),);
    }else{
      if(image!=null){
        boxDecoration = boxDecoration.copyWith(image: DecorationImage(image: ExactAssetImage(image), fit: BoxFit.cover,),);

      }
    }
    if(isActive){
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(
          colors: [
            AppColors.lightBlue,
            AppColors.darkBlue,
          ],),);
    }else{
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(
          colors: [
            AppColors.mainColor,
            AppColors.mainColor,
            AppColors.mainColor,
            Colors.white,
          ],),);
    }
    return Container(
      height: size,
      width: size,
      decoration: boxDecoration,
      child: FlatButton(

          padding: EdgeInsets.all(0),
          onPressed: onTap,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(200),)
          ),
          child: child ?? Container()),
    );
  }
}