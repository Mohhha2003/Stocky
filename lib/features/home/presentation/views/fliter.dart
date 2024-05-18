import 'package:flutter/material.dart';
import 'package:project1/core/widgets/app_colors.dart';

class FliterPart extends StatefulWidget {
  const FliterPart({super.key, this.categories, this.onTap});
  final List<String>? categories;
  final void Function(String)? onTap;

  @override
  State<FliterPart> createState() => _FliterPartState();
}

class _FliterPartState extends State<FliterPart> {
  int _selectedCategory = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () async {
            setState(() {
              if (_selectedCategory == index) {
                _selectedCategory = -1;
                widget.onTap!('');
              } else {
                _selectedCategory = index;
                widget.onTap!(widget.categories![index]);
              }
            });
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _selectedCategory == index
                  ? const Color(AppColors.kPrimaryColor)
                  : Colors.white,
            ),
            child: Text(
              widget.categories![index],
              style: TextStyle(
                color: _selectedCategory == index
                    ? Colors.white
                    : const Color(AppColors.kPrimaryColor),
              ),
            ),
          ),
        ),
        itemCount: widget.categories!.length,
      ),
    );
  }
}
