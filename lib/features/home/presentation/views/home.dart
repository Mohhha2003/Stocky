import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/repos/fav_repo.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import 'package:project1/features/home/data/models/favourites/favourites.dart';
import 'package:project1/features/home/data/models/product_model.dart';
import 'package:project1/features/home/presentation/manager/cubit/store_cubit.dart';
import '../../../../Services/store_repo.dart';
import 'details.dart';
import 'fliter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductRepo apiCon;
  @override
  void initState() {
    context.read<StoreCubit>().getProducts();
    apiCon = ProductRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            FliterPart(
              onTap: (p0) {
                context.read<StoreCubit>().categorie = p0;
                context.read<StoreCubit>().getPorductCategorie();
                print(p0);
              },
              categories: const [
                "Bags",
                "T-shirts",
                "Shoes",
                "SweatShirt",
                "Other"
              ],
            ),
            const SizedBox(height: 30),
            Container(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Gender",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            FliterPart(
              onTap: (p0) {
                context.read<StoreCubit>().gender = p0;
                context.read<StoreCubit>().getPorductCategorie();
                print(p0);
              },
              categories: const ['men', 'woman'],
            ),
            Container(height: 20),
            BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                if (state is StoreLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StoreEmpty) {
                  return const Center(
                    child: Text('The Store is Empty No Data Found'),
                  );
                } else {
                  return GridView.builder(
                    itemCount: context.read<StoreCubit>().prodcuts.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 359,
                    ),
                    itemBuilder: (context, index) {
                      ProductModel product =
                          context.read<StoreCubit>().prodcuts[index];
                      bool isProduct = isProductFav(productId: product.id);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemsDetails(product: product),
                            ),
                          );
                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 150,
                                    width: double.infinity,
                                    child: Image.network(
                                      product.image,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.error,
                                                  color: Colors.red),
                                              Text('Failed to load image',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            ],
                                          ),
                                        );
                                      },
                                      height: 90,
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(height: 10),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.description,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                CustomPriceRow(
                                  isFav: isProduct,
                                  product: product,
                                  price: product.price,
                                  productId: product.id,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomPriceRow extends StatefulWidget {
  CustomPriceRow({
    Key? key,
    required this.price,
    required this.productId,
    required this.product,
    required this.isFav,
  }) : super(key: key);
  final String productId;
  final ProductModel product;
  final int price;

  bool isFav;

  @override
  State<CustomPriceRow> createState() => _CustomPriceRowState();
}

class _CustomPriceRowState extends State<CustomPriceRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.price.toString(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () async {
            if (widget.isFav) {
              try {
                await Fav().deleteFavourite(
                    product: Favourites().fromProductModelToFavouritesModel(
                        productModel: widget.product));
                showSnackBar(text: 'Removed From Fav', context: context);
                AuthApi.favourites
                    .removeWhere((fav) => fav.id == widget.product.id);
                widget.isFav = false;
              } on Exception catch (e) {
                showSnackBar(text: 'Error Removing to Fav', context: context);
              }
            } else {
              try {
                await Fav().addToFavorite(product: widget.product);
                showSnackBar(
                    text: 'Added To Fav',
                    context: context,
                    backgroundColor: Colors.green);
                AuthApi.favourites.add(Favourites()
                    .fromProductModelToFavouritesModel(
                        productModel: widget.product));
                widget.isFav = true;
              } on Exception catch (e) {
                showSnackBar(text: 'Error Adding to Fav', context: context);
              }
            }
            setState(() {});
          },
          icon: widget.isFav
              ? const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                )
              : const Icon(IconlyBroken.heart),
        ),
      ],
    );
  }
}

bool isProductFav({required String productId}) {
  for (var fav in AuthApi.favourites) {
    if (fav.productId == productId) {
      return true;
    }
  }
  return false;
}
