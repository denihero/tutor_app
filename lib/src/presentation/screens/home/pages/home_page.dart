import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/categories_cubit.dart';
import 'package:tutor_app/src/logic/cubit/course__cubit.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/course_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? choiceIndex;
  List<String> name = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 41,
          margin: const EdgeInsets.only(left: 17, bottom: 43),
          child: BlocBuilder<CategoriesCubit, Cat>(builder: (context, state) {
            name = state.categories.keys.toList();
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: name.length - name.length + 1,
                itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Wrap(
                      spacing: 10,
                      children: techChips(index),
                    )));
          }),
        ),
        BlocBuilder<SurveyCubit, SurveyState>(
          builder: (context, state) {
            var data = state.surveys;
            return Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) => CourseCard(
                  course: Course(
                    nameOfCourse: data[index].nameOfCourse,
                    category: data[index].category,
                    lessons: data[index].lessons,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> techChips(int index) {
    List<Widget> chips = [];
    for (int i = 0; i < name.length; i++) {
      Widget item = ChoiceChip(
        label: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            name[i],
          ),
        ),
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        selectedColor: const Color(0xFFFE793D),
        selected: choiceIndex == i,
        shadowColor: Colors.black,
        labelStyle: choiceIndex == i
            ? const TextStyle(
                color: Colors.white,
              )
            : const TextStyle(
                color: Colors.black,
              ),
        onSelected: (isSelected) {
          setState(() {
            if (isSelected) {
              choiceIndex = i;
            } else {
              choiceIndex = null;
            }
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}

/*class CategoryButton extends StatefulWidget {
  const CategoryButton({
    Key? key,
    required this.name,
    required this.index,
    this.color = const Color(0xFFFAFAFA),
    this.selectedColor = const Color(0xFFFE793D), required this.ii,
  }) : super(key: key);

  final String name;
  final List ii;
  final int index;
  final Color color, selectedColor;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}


class _CategoryButtonState extends State<CategoryButton> {
  int? choiceIndex;
  @override
  Widget build(BuildContext context) {
    for(int i = 0;i < widget.ii.length;i++){
      choiceIndex = i;
    }
    return GestureDetector(
      onTap: () {
        setState((){

        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: choiceIndex == widget.index ? widget.selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.name,
          style: TextStyle(
            color:  choiceIndex == widget.index? Colors.white : Colors.black,
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.04,
          ),
        ),
      ),
    );
  }
}*/
/*Container(
margin: const EdgeInsets.symmetric(horizontal: 13),
padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
color: choiceIndex == widget.index ? widget.selectedColor : Colors.white,
borderRadius: BorderRadius.circular(20),
),
child: Text(
widget.name,
style: TextStyle(
color:  choiceIndex == widget.index? Colors.white : Colors.black,
fontSize: 9,
fontWeight: FontWeight.w600,
letterSpacing: 1.04,
),
),
),*/

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
