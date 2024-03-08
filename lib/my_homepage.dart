import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shark/data.dart';
import 'package:shark/image_viewer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late CarouselController inner;
  late CarouselController outer;
  int innerCurrentPage = 0;
  int outerCurrentPage = 1;

  @override
  void initState() {
    inner = CarouselController();
    outer = CarouselController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 17, 48),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          toolbarHeight: double.infinity,
          backgroundColor: const Color.fromARGB(255, 243, 248, 0),
          leading: Image.asset('assets/images/menu.png'),
          title: Image.asset('assets/images/Component 7.png'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset('assets/images/search.png'),
            ),
          ],
          centerTitle: true,
        ),
      ),
      body:
         Stack(children:[
          // کل صفحه و عکس ها
          SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: 1000,
          child: Column(
            children: [
              //عکس های ردیف بالا
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      'Popular Shoes',
                      style: GoogleFonts.amaranth(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: height * .25,
                    width: width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CarouselSlider(
                            carouselController: inner,
                            items: AppData.inner.map((imagePath) {
                              return Builder(builder: (BuildContext context) {
                                return CustomImageViewer.show(
                                    context: context,
                                    url: imagePath,
                                    fit: BoxFit.cover);
                              });
                            }).toList(),
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.8,
                                onPageChanged: ((index, reason) {
                                  setState(() {
                                    innerCurrentPage = index;
                                  });
                                })),
                          ),
                        ),

                        Positioned(
                          bottom: height * .01,
                          child: Row(
                            children: List.generate(
                              AppData.inner.length,
                              (index) {
                                bool isSelected = innerCurrentPage == index;
                                return GestureDetector(
                                  onTap: () {
                                    inner.animateToPage(index);
                                  },
                                  child: AnimatedContainer(
                                    width: isSelected ? 55 : 17,
                                    height: 10,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: isSelected ? 6 : 3),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color.fromARGB(
                                              255, 243, 248, 0)
                                          : const Color.fromARGB(
                                              255, 1, 17, 48),
                                      borderRadius: BorderRadius.circular(
                                        40,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        //ایکون سمت چپ
                        Positioned(
                          left: 11,
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(200, 243, 248, 9),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconButton(
                                onPressed: () {
                                  inner.animateToPage(innerCurrentPage - 1);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),

                        //ایکون سمت  راست

                        Positioned(
                          right: 11,
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(200, 243, 248, 9),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: IconButton(
                                onPressed: () {
                                  inner.animateToPage(innerCurrentPage + 1);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 15,
              ),
              //عکس های ردیف پایین
              Column(
                children: [
                  //نوشته
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      'Most Liked Shoes',
                      style: GoogleFonts.amaranth(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //عکس ها
                  SizedBox(
                    height: height * .25,
                    width: width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CarouselSlider(
                            carouselController: outer,
                            items: AppData.outer.map((imagePath) {
                              return Builder(builder: (BuildContext context) {
                                return CustomImageViewer.show(
                                    context: context,
                                    url: imagePath,
                                    fit: BoxFit.cover);
                              });
                            }).toList(),
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.8,
                                onPageChanged: ((index, reason) {
                                  setState(() {
                                    outerCurrentPage = index;
                                  });
                                })),
                          ),
                        ),

                        // اسلایدر
                        Positioned(
                          bottom: height * .01,
                          child: Row(
                            children: List.generate(
                              AppData.outer.length,
                              (index) {
                                bool isSelected = outerCurrentPage == index;
                                return GestureDetector(
                                  onTap: () {
                                    outer.animateToPage(index);
                                  },
                                  child: AnimatedContainer(
                                    width: isSelected ? 55 : 17,
                                    height: 10,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: isSelected ? 6 : 3),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color.fromARGB(
                                              255, 243, 248, 0)
                                          : const Color.fromARGB(
                                              255, 1, 17, 48),
                                      borderRadius: BorderRadius.circular(
                                        40,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        //ایکون سمت چپ
                        Positioned(
                          left: 11,
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(200, 243, 248, 9),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconButton(
                                onPressed: () {
                                  outer.animateToPage(outerCurrentPage - 1);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),

                        //ایکون سمت  راست

                        Positioned(
                          right: 11,
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(200, 243, 248, 9),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: IconButton(
                                onPressed: () {
                                  outer.animateToPage(outerCurrentPage + 1);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              
              )
            ,
            
              
               
            ],
         
          ),
         )
        ,
      ),

      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Container(
                
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: const Color.fromARGB(255, 243, 248, 0)),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/ShoppingCart.png'),
                        Image.asset('assets/images/home.png'),
                        Image.asset('assets/images/heart.png'),
                                             
                      ],
                     ),
                      
                ),
        ),
      )
      ]),

      //باتم نویگیشن
       /*bottomNavigationBar: 

  


    Padding(
      padding: const EdgeInsets.only(bottom: 20,left: 70,right: 70),
      child: Container(

        height: 65,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: const Color.fromARGB(255, 243, 248, 0)),
           child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),                                            
    topRight: Radius.circular(30.0),
            ),
           child:
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/ShoppingCart.png'),
              Image.asset('assets/images/home.png'),
              Image.asset('assets/images/heart.png'),
    
            ],
           )),
            
      ),
    ),*/
    ));
  }
}
