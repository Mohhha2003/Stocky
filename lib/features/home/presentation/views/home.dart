import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/repos/cart_repo.dart';
import 'package:project1/Services/repos/fav_repo.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import 'package:project1/features/home/data/models/favourites/favourites.dart';
import 'package:project1/features/home/data/models/product_model.dart';
import '../../../../Services/api_con.dart';
import 'details.dart';
import 'fliter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiCon apiCon = ApiCon();
  @override
  void initState() {
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
            const FliterPart(
              categories: ["Bags", "T-Shirts", "Shoes", "SweatShirt", "Other"],
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
            const FliterPart(
              categories: ['Male', 'Female'],
            ),
            Container(height: 20),
            FutureBuilder<List<ProductModel>>(
              future: apiCon.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<ProductModel>? products = snapshot.data;
                  return GridView.builder(
                    itemCount: products?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 359,
                    ),
                    itemBuilder: (context, index) {
                      ProductModel product = products![index];
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
                                      '',
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
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPriceRow extends StatefulWidget {
  final int price;

  CustomPriceRow({
    Key? key,
    required this.price,
    required this.productId,
    required this.product,
    required this.isFav,
  }) : super(key: key);
  bool isFav;
  final String productId;
  final ProductModel product;

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
                AuthApi.favourites.remove(Favourites()
                    .fromProductModelToFavouritesModel(
                        productModel: widget.product));
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
                widget.isFav = true;
                AuthApi.favourites.add(Favourites()
                    .fromProductModelToFavouritesModel(
                        productModel: widget.product));
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
