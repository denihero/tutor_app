import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        cursorHeight: 20,
        style: const TextStyle(
          fontSize: 20
        ),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 2,left: 10),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: Colors.transparent)
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(color: Colors.transparent)
          ),
          filled: true,

          fillColor: Colors.grey.withOpacity(0.5),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,onPressed: () {}
                  ,)
            ),
          ),
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black
          ),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
