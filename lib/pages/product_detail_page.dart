import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:second_hand_app/utils/app_styles.dart';
import 'package:second_hand_app/utils/size_config.dart';

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      child: Image.asset(
                        'assets/images/image_product_detail.png',
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
                                  Navigator.of(context).pop(const ProductDetailPage());
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
                      'Modern light clothes',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kEncodeSansSemibold.copyWith(
                        color: kDarkBrown,
                        fontSize: SizeConfig.blockSizeHorizontal! * 7,
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
                'Quick-win. Please use "solutionise" instead of solution ideas! :) pulling teeth, or feature creep, nor we don\'t want to boil the ocean, or effort made was a lot come up with something buzzworthy take five, punch the tree, and come back in here with a clear head. Agile make it look like digital diversify kpis this is meaningless. We should leverage existing asserts that ladder up to the message teams were able to drive adoption and awareness, but run it up the flagpole, ping the boss and circle back, or commitment to the cause .',
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
        ),
      ),
    );
  }
}
