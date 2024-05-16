import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project1/core/widgets/custom_text_form_feild.dart';
import 'package:project1/features/home/presentation/views/details.dart';
import 'package:project1/features/home/presentation/views/widgets/custom_product_list_item.dart';

import '../../data/models/product_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    List<ProductModel> models = [];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomTextFormField(
              isPassword: false,
              maxLine: 1,
              controller: searchController,
              onChanged: (value) {
                return null;
              },
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: 'search',
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ItemsDetails(product: models[index]),
                    ),
                  );
                },
                child: CustomProductListItem(),
              ),
              separatorBuilder: (context, index) => const Gap(20),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
