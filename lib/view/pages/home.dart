import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:second_hand_app/model/post_model.dart';
import 'package:http/http.dart' as http;

import 'package:second_hand_app/utils/app_styles.dart';
import 'package:second_hand_app/utils/size_config.dart';
import 'package:second_hand_app/view/pages/product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  Future<PostModel> getProductsApi() async {
    final response = await http
        .get(Uri.parse('https://secondhandvinhome.herokuapp.com/api/post'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return PostModel.fromJson(data);
    } else {
      return PostModel.fromJson(data);
    }
  }

  final user = FirebaseAuth.instance.currentUser;

  List<String> categories = [
    "All Items",
    "Dress",
    "Hat",
    "Watch",
  ];

  List<String> icons = [
    'all_items_icon',
    'dress_icon',
    'hat_icon',
    'watch_icon',
  ];


  int current = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, Welcome 👋',
                      style: kEncodeSansRagular.copyWith(
                        color: kDarkBrown,
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: kEncodeSansBold.copyWith(
                        color: kDarkBrown,
                        fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL!),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingHorizontal,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: kEncodeSansRagular.copyWith(
                      color: kDarkGrey,
                      fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                    ),
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13,
                      ),
                      prefixIcon: const IconTheme(
                        data: IconThemeData(
                          color: kDarkGrey,
                        ),
                        child: Icon(Icons.search),
                      ),
                      hintText: 'Search products...',
                      border: kInputBorder,
                      errorBorder: kInputBorder,
                      disabledBorder: kInputBorder,
                      focusedBorder: kInputBorder,
                      focusedErrorBorder: kInputBorder,
                      enabledBorder: kInputBorder,
                      hintStyle: kEncodeSansRagular.copyWith(
                        color: kDarkGrey,
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 49,
                  width: 49,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    color: kBlack,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/filter_icon.svg',
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? kPaddingHorizontal : 15,
                      right: index == categories.length - 1
                          ? kPaddingHorizontal
                          : 0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 36,
                    decoration: BoxDecoration(
                      color: current == index ? kBrown : kWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: current == index
                          ? null
                          : Border.all(
                              color: kLightGrey,
                              width: 1,
                            ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(current == index
                            ? 'assets/images/${icons[index]}_selected.svg'
                            : 'assets/images/${icons[index]}_unselected.svg'),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          categories[index],
                          style: kEncodeSansMedium.copyWith(
                            color: current == index ? kWhite : kDarkBrown,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          FutureBuilder<PostModel>(
            future: getProductsApi(),
            // Replace with your own function that fetches data from the API
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text(
                      'Error fetching data'); // Return an error widget if the API call fails
                }
                return MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 23,
                  itemCount: snapshot.data!.post!.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingHorizontal,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProductDetailPage(),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  child: Image.network(snapshot
                                      .data!.post![index].img![0].url
                                      .toString()),
                                ),
                              ),
                              Positioned(
                                right: 12,
                                top: 12,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    'assets/images/favorite_cloth_icon_unselected.svg',
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.post![index].product![0].productName
                                .toString(),
                            // Replace this with the title from your fetched data
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kEncodeSansSemibold.copyWith(
                              color: kDarkBrown,
                              fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                            ),
                          ),
                          Text(
                            snapshot.data!.post![index].product![0].category!
                                .categoryName
                                .toString(),
                            //Replace this with the description from your fetched data
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kEncodeSansRagular.copyWith(
                              color: kGrey,
                              fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.post![index].product![0].price
                                .toString(),
                            // Replace this with the price from your fetched data
                            style: kEncodeSansSemibold.copyWith(
                              color: kDarkBrown,
                              fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator(); // Return a loading widget while the API call is in progress
              }
            },
          ),
        ],
      ),
    );
  }
}
