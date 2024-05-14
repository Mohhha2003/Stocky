import 'package:flutter/material.dart';
import 'package:project1/Services/repos/fav_repo.dart';
import 'package:project1/features/home/data/models/product_model.dart';
import 'package:project1/features/home/presentation/views/widgets/custom_product_list_item.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Fav().getUserFavourites(ownerId: '66436148997939ee89ee912f'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error is ${snapshot.error}'),
          );
        } else {
          List<ProductModel> products = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) => Dismissible(
              direction: DismissDirection.startToEnd,
              background: Container(
                color: Colors.transparent,
                child: const Icon(Icons.delete),
              ),
              onDismissed: (direction) {
                if (direction == AxisDirection.right) {}
              },
              key: GlobalKey(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomProductListItem(),
              ),
            ),
            itemCount: products.length,
          );
        }
      },
    );
  }
}
