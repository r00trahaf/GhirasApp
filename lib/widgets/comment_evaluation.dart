import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'AppDetails.dart';
import 'assets.dart';
import 'commonColor.dart';
import 'commonWidget.dart';

comment_evaluation(context, {action}) {
  String Evaluation = "";
  double ratingValue = 0;

  AlertDialog alert = AlertDialog(
    title: Center(child:
    textWidget(
      color: CommonColor.calendarColor,
      text: "قيم تجربتك",
      fontFamily: AppDetails.cairoRegular,
      fontSize: 25,
    ),),
    content: SizedBox(
      height: MediaQuery.of(context).size.height * (200 / 812),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Center(
              child: RatingBar.builder(
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                itemBuilder: (context, _) => Image.asset(
                  Assets.shared.trillium,
                ),
                onRatingUpdate: (rating) {
                  ratingValue = rating;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CommonTextFormField(
            label: "اضف تعليق",
            textInputAction: TextInputAction.next,
            validator: (msg) {
              return null;
            },
            controller: TextEditingController(),
            onChanged: (value) => Evaluation = value.trim(),
            hintText: 'قيم الجلسه',
            keyboardType: TextInputType.text,
          ),
          const Expanded(child: SizedBox()),
          Image.asset(
            Assets.shared.star,
          ),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => action(Evaluation, ratingValue),
            child: Container(
              width: 123,
              height: 36,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        0.0,
                        5.0,
                      ),
                      blurRadius: 0.10,
                      spreadRadius: 0.10,
                    ),
                  ],
                  borderRadius:
                  const BorderRadius.all(
                      Radius.circular(20)),
                  color: "#D1DFC8".toHexa(),
                  border: Border.all(
                    color: "#D1DFC8".toHexa(),
                  )),
              child: const Center(child: Text(
                'ارسال',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white),
              ),),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 123,
              height: 36,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        0.0,
                        5.0,
                      ),
                      blurRadius: 0.10,
                      spreadRadius: 0.10,
                    ),
                  ],
                  borderRadius:
                  const BorderRadius.all(
                      Radius.circular(20)),
                  color: "#D1DFC8".toHexa(),
                  border: Border.all(
                    color: "#D1DFC8".toHexa(),
                  )),
              child: const Center(child: Text(
                'الغاء',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white),
              ),),
            ),
          )
        ],
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
