import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:project1/core/widgets/custom_text_form_feild.dart';
import 'package:project1/features/home/presentation/manager/cubit/search_cubit.dart';
import 'package:project1/features/home/presentation/views/details.dart';
import 'package:project1/features/home/presentation/views/widgets/custom_product_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
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
              onChanged: (value) async {
                context.read<SearchCubit>().searchProducts(keyword: value);
              },
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: 'search',
            ),
          ),
          BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
            if (state is SearchFailed) {
              return const Center(
                child: Text('Error Fetching the Data'),
              );
            } else if (state is SearchEmpty) {
              return const Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No Products Found'),
                    ]),
              );
            } else {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemsDetails(
                              product:
                                  context.read<SearchCubit>().search[index]),
                        ),
                      );
                    },
                    child: CustomProductListItem(),
                  ),
                  separatorBuilder: (context, index) => const Gap(20),
                  itemCount: context.read<SearchCubit>().search.length,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
