import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
// import 'savewebview.dart';

List<String> articleTitle= [
  "Indian Women are Inspiring Individual",
  "We have to end Violance",
  "Make a Change",
  "You are strong",
];

List<String> imageSliders= [
  "https://cnichannel.in/wp-content/uploads/2019/11/sss.jpg",
  "https://tse1.explicit.bing.net/th?id=OIP.eqZyS7ZiVIOSNA0fmp8zigHaEK&pid=Api&P=0&h=220",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6cQ2vF1vIMvIM4jl0NOo59f7h57ubbOXazQ&usqp=CAU",
  "https://www.shutterstock.com/image-photo/group-confident-young-indian-women-260nw-2289069895.jpg",

];

class Customcarouel extends StatelessWidget {

  const Customcarouel ({Key? key}): super(key: key);

  void navigateToRoute(BuildContext context, Widget route){

          Navigator.push(context, CupertinoPageRoute(builder: (context)=> route));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: List.generate(imageSliders.length, 
        (index)=> Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // child: InkWell(
              //  onTap: () {
              //     if (index==0){
              //       navigateToRoute(
              //         context,
              //         SafeWebView(
              //           url:
              //             "https://economictimes.indiatimes.com/markets/expert-view/market-leadership-stays-with-psus-stay-invested-as-the-best-is-yet-to-come-ramesh-damani/articleshow/106174564.cms",
              //         )
              //       )
              //     } else if (index==1){
              //       navigateToRoute(
              //         context,
              //         SafeWebView(
              //           url:
              //             "https://pub.dev/packages/webview_flutter/install",
              //         )
              //       )
              //     } else if (index==2){
              //       navigateToRoute(
              //         context,
              //         SafeWebView(
              //           url:
              //             "https://api.flutter.dev/flutter/cupertino/cupertino-library.html",
              //         )
              //       )
              //     } else {
              //       navigateToRoute(
              //         context,
              //         SafeWebView(
              //           url:
              //             "https://www.mha.gov.in/en/divisionofmha/women-safety-division",
              //         )
              //       )
              //     }   
                 
              //  },
            child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageSliders[index],
                )
                )
            ),
            child: Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient:
                  LinearGradient(colors: [Colors.black.withOpacity(0.5),
                  Colors.transparent,
                  ]),
               ),
                 child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8),
            child: Text(
              articleTitle[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width*0.05,
              ),
            ),
            ),
           
          )
            ),
            
          ),
          // ),
         
          
        ),
        ),
      )
    );

  }
}