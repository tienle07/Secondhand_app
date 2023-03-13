import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:second_hand_app/model/post_model.dart';
import 'package:second_hand_app/utils/app_styles.dart';
import 'package:second_hand_app/utils/size_config.dart';
import 'package:http/http.dart' as http;
import '../utils/counter.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final Counter _counter = Counter();

  void _incrementCounter() {
    setState(() {
      _counter.increment();
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter.decrement();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: FutureBuilder<PostModel>(
        future: getProductsApi(),
        builder: (BuildContext context, AsyncSnapshot<PostModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: kPaddingHorizontal,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 50,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            snapshot.data!.post![0].img![0].url.toString(),
                            height: SizeConfig.blockSizeVertical! * 50,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: SizeConfig.blockSizeVertical! * 4,
                                  width: SizeConfig.blockSizeVertical! * 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kWhite,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kBrown.withOpacity(0.11),
                                        spreadRadius: 0.0,
                                        blurRadius: 12,
                                        offset: const Offset(0, 5),
                                      )
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pop(const ProductDetailPage());
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/arrow_back_icon.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  height: SizeConfig.blockSizeVertical! * 4,
                                  width: SizeConfig.blockSizeVertical! * 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kWhite,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kBrown.withOpacity(0.11),
                                        spreadRadius: 0.0,
                                        blurRadius: 12,
                                        offset: const Offset(0, 5),
                                      )
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    'assets/images/favorite_black_icon.svg',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          snapshot.data!.post![0].product![0].productName.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kEncodeSansSemibold.copyWith(
                            color: kDarkBrown,
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _decrementCounter,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kBorderColor,
                                  width: 1,
                                ),
                                shape: BoxShape.circle,
                                color: kWhite,
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: kGrey,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 3,
                          ),
                          Text(
                            _counter.value.toString(),
                            style: kEncodeSansBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 5,
                              color: kDarkBrown,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 3,
                          ),
                          GestureDetector(
                            onTap: _incrementCounter,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kBorderColor,
                                  width: 1,
                                ),
                                shape: BoxShape.circle,
                                color: kWhite,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: kDarkGrey,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ReadMoreText(
                    snapshot.data!.post![0].description.toString(),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    delimiter: ' ',
                    trimCollapsedText: 'Read More...',
                    trimExpandedText: 'Show Less',
                    style: kEncodeSansRagular.copyWith(
                      fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                      color: kDarkGrey,
                    ),
                    moreStyle: kEncodeSansBold.copyWith(
                      fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      color: kDarkBrown,
                    ),
                    lessStyle: kEncodeSansBold.copyWith(
                      fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      color: kDarkBrown,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 1,
                    color: kLightGrey,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
