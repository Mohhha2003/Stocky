import 'package:flutter/material.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/repos/fav_repo.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import 'package:project1/features/home/data/models/favourites/favourites.dart';
import 'package:project1/features/home/presentation/views/widgets/custom_product_list_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project1/features/home/presentation/views/widgets/empty_widget.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Favourites>>(
      future: Fav().getUserFavourites(ownerId: AuthApi.currentUser.id ?? ''),
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
          List<Favourites> products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const EmptyWidget(
                svgImagePath: 'assets/images/fav.svg',
                text: 'No Favourites was found');
          }
          return AuthApi.currentUser.id == null
              ? const Center(
                  child: Text('Please Login To Add Favourites'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) => Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.transparent,
                      child: const Icon(Icons.delete),
                    ),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        try {
                          await Fav().deleteFavourite(product: products[index]);
                          AuthApi.favourites.removeAt(index);
                        } on Exception catch (e) {
                          showSnackBar(
                              text: 'Failed To delete Product From Fav',
                              context: context);
                        }
                      }
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
