import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        onTap: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          );
          FocusManager.instance.primaryFocus?.unfocus();
        },
        cursorHeight: 16,
        autofocus: false,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.04,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 2, left: 10),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: Color(0xFFFE793D)),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: CircleAvatar(
                radius: 10,
                backgroundColor: const Color(0xFFFE793D),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {},
                )),
          ),
          hintStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.46),
            letterSpacing: 1.04,
          ),
          hintText: "Живой поиск",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.remove))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          FocusManager.instance.primaryFocus?.unfocus();
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: const [],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
