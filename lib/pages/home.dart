import 'package:fitness/models/category_model.dart';
import 'package:fitness/models/diet_model.dart';
import 'package:fitness/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class HomePage extends StatelessWidget {
    HomePage({super.key});

    List<CategoryModel> categories = [];
    List<DietModel> diets = [];
    List<PopularDietsModel> popularDiets = [];

    void _getInitialInfo() {
      categories = CategoryModel.getCategories();
      diets = DietModel.getDiets();
      popularDiets = PopularDietsModel.getPopularDiets();
    }

    @override
    Widget build(BuildContext context) {
      _getInitialInfo();
        return Scaffold(
          appBar: appBar(),
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              _searchField(),
              const SizedBox(height: 40, ),
              _categoriesSection(),
              const SizedBox(height: 40,),
              _dietSection(),
              const SizedBox(height: 40,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ),
                  SizedBox(height: 15,),
                  ListView.separated(
                    itemCount: popularDiets.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 25),
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        // color: Colors.blue,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              popularDiets[index].iconPath,
                              width: 65,
                              height: 65
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popularDiets[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16
                                  ),
                                ),
                                Text(
                                  popularDiets[index].level + ' | ' + popularDiets[index].calorie,
                                  style: TextStyle(
                                    color: Color(0xff786F72),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600
                                  )
                                )
                              ]
                            ),
                            GestureDetector(
                              onTap : () {},
                              child: SvgPicture.asset(
                                'assets/icons/button.svg',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: popularDiets[index].boxIsSelected ? 
                            Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: popularDiets[index].boxIsSelected ? [
                            BoxShadow(
                              color: Color(0xff1D1617).withOpacity(0.07),
                              offset: Offset(0, 10),
                              blurRadius: 40,
                              spreadRadius: 0
                            ),
                          ] : []
                        ),
                      );
                    }
                  )
                ]
              ),
              SizedBox(height: 40,),
            ],
          )
        );
    }

    Column _dietSection() {
      return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Recommendation\nfor Diet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    )
                  
                  ),
                ),
                SizedBox(height:15,),
                Container(
                  // color: Colors.blue,
                  height:220,
                  child : ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        width: 210,
                        decoration: BoxDecoration(
                          color: diets[index].boxColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(diets[index].iconPath),
                            Text(
                              diets[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16
                              )
                            ),
                            Text(
                              diets[index].level + ' | ' + diets[index].duration + ' | ' + diets[index].calorie,
                              style: TextStyle(
                                color: Color(0xff786F72),
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                              )
                            ),
                            Container(
                              height: 45,
                              width: 130,
                              child: Center(
                                child: Text (
                                  'View',
                                  style: TextStyle(
                                    color: diets[index].viewIsSelected ? Colors.white : Color(0xffC588F2),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                  )
                                )
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    diets[index].viewIsSelected ? Color(0xff9DCEFF) : Colors.transparent,
                                    diets[index].viewIsSelected ? Color(0xff92A3FD) : Colors.transparent
                                  ]
                                ),
                                borderRadius: BorderRadius.circular(50)
                              )
                            )
                          ]
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 25,),
                    itemCount : diets.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20
                    )
                  )
                )
              ]
            );
    }

    Column _categoriesSection() {
      return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Category',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    )
                  ),
                ),
                SizedBox(height: 15, ),
                Container(
                  height: 150,
                  // color: Colors.white,
                  child: ListView.separated(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 25,),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: categories[index].boxColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              child : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(categories[index].iconpath),
                              ),
                            ),
                            Text(
                              categories[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14
                              )
                            ),
                          ],
                        )
                      );
                    },
                  )
                )
              ],
            );
    }

    Container _searchField() {
      return Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff1D1617).withOpacity(0.11),
                    blurRadius: 40,
                    spreadRadius: 0.0
                  )

                ]
              ),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Search Pancake',
                  hintStyle: TextStyle(
                    color: Color(0xffDDDADA),
                    fontSize: 14
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/Search.svg'),
                  ),
                  suffixIcon: Container(
                    width: 100,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          VerticalDivider(
                            color: Colors.black,
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset('assets/icons/Filter.svg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                  )
                )
              ),
            );
    }

    AppBar appBar() {
      return AppBar(
          title: Text(
            'Breakfast',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              
            },
            child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)
            ),
            child: SvgPicture.asset(
              'assets/icons/Arrow - Left 2.svg',
              height: 20,
              width: 20,
              )
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {

              },
              child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 20,
              decoration: BoxDecoration(
                color: Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)
              ),
              child: SvgPicture.asset(
                'assets/icons/dots.svg',
                width: 20,
                height: 20,
              )
            ),
            )
          ],
        );
    }
}