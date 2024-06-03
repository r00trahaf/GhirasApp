import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../../Firebase.dart';
import '../../Model/ReviewsModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/Usertype.dart';
import '../../enum/status.dart';
import '../../widgets/Appointments.dart';
import '../../widgets/assets.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool info = true;
  CarouselController buttonCarouselController = CarouselController();
  UserModel user = UserModel(
      image: '',
      name: '',
      last: '',
      uid: '',
      email: '',
      phone: '',
      city: '',
      password: '',
      experience: '',
      cv: '',
      address: '',
      certificate: '',
      years: '',
      id: '',
      accountStatus: Status.active,
      section: '',
      userType: Usertype.specialist);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.SpeciaListHome,
                  width: MediaQuery.of(context).size.width,
                ),
                Visibility(
                    visible: info,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 190),
                      child: Text(
                        "اخصائيين النباتات",
                        style:
                            TextStyle(color: "#6e6e6e".toHexa(), fontSize: 30),
                      ),
                    )),
                Visibility(
                    visible: info == false,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 190),
                      child: Text(
                        "معلومات الاخصائي",
                        style:
                            TextStyle(color: "#6e6e6e".toHexa(), fontSize: 30),
                      ),
                    )),
                Visibility(
                    visible: info == false,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 225),
                      child: Text(
                        "${user.name} ${user.last}",
                        style:
                            TextStyle(color: "#000000".toHexa(), fontSize: 20),
                      ),
                    )),
                Visibility(
                    visible: info == false,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 245),
                      child: Text(
                        user.city,
                        style:
                            TextStyle(color: "#a9a9a9".toHexa(), fontSize: 20),
                      ),
                    ))
              ],
            ),
            info == true
                ? FutureBuilder<List<UserModel>>(
                    future: Firebase.shared.users(
                        status: Status.active, type: Usertype.specialist),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<UserModel>? items = snapshot.data;
                        return Wrap(
                            children: List.generate(
                          items!.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                elevation: 4,
                                surfaceTintColor: Colors.white,
                                color: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  side: BorderSide(color: Colors.white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                  child:
                                                      items[index].image != ""
                                                          ? Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          items[index]
                                                                              .image),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            )
                                                          : const Icon(
                                                              Icons.person,
                                                              size: 52,
                                                              color: CupertinoColors
                                                                  .opaqueSeparator,
                                                            ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(items[index].name),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    info = false;
                                                    user = items[index];
                                                  });
                                                },
                                                child: Image.asset(
                                                  Assets.shared.writeCalendar,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Appointments(
                                                        user: items[index],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Image.asset(
                                                  Assets.shared.calendar,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "التقييم:",
                                            style: TextStyle(
                                                color: "#c2c2c2".toHexa(),
                                                fontSize: 13),
                                          ),
                                          RatingBarIndicator(
                                            itemSize: 15,
                                            rating: 4,
                                            itemCount: 5,
                                            itemBuilder: (context, _) =>
                                                Image.asset(
                                              Assets.shared.flowerImg,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "الوصف:",
                                            style: TextStyle(
                                                color: "#c2c2c2".toHexa(),
                                                fontSize: 13),
                                          ),
                                          Text(
                                            items[index].certificate,
                                            style: TextStyle(
                                                color: "#c2c2c2".toHexa(),
                                                fontSize: 13),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ));
                      } else {
                        return const SizedBox();
                      }
                    })
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Card(
                          elevation: 4,
                          surfaceTintColor: Colors.white,
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "التقييم:",
                                      style: TextStyle(
                                          color: "#9DBA89".toHexa(),
                                          fontSize: 15),
                                    ),
                                    RatingBarIndicator(
                                      itemSize: 15,
                                      rating: 4,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => Image.asset(
                                        Assets.shared.rose,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "الوصف:",
                                      style: TextStyle(
                                          color: "#9DBA89".toHexa(),
                                          fontSize: 15),
                                    ),
                                    Text(
                                      user.certificate,
                                      style: TextStyle(
                                          color: "#c2c2c2".toHexa(),
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "الشهادة:",
                                      style: TextStyle(
                                          color: "#9DBA89".toHexa(),
                                          fontSize: 15),
                                    ),
                                    Text(
                                      user.certificate,
                                      style: TextStyle(
                                          color: "#c2c2c2".toHexa(),
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "سنوات الخبرة:",
                                      style: TextStyle(
                                          color: "#9DBA89".toHexa(),
                                          fontSize: 15),
                                    ),
                                    Text(
                                      user.years,
                                      style: TextStyle(
                                          color: "#c2c2c2".toHexa(),
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'تقيمات اصحاب النبات',
                        style:
                            TextStyle(color: "#688665".toHexa(), fontSize: 20),
                      ),
                      Stack(
                        children: [
                          FutureBuilder<List<ReviewsModel>>(
                              future: Firebase.shared.reviews(uid: user.uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<ReviewsModel>? reviews = snapshot.data;
                                  return CarouselSlider(
                                    carouselController: buttonCarouselController,
                                    options: CarouselOptions(
                                        height: 150,
                                        autoPlayInterval: const Duration(seconds: 15),
                                        autoPlayAnimationDuration:
                                        const Duration(milliseconds: 600),
                                        enableInfiniteScroll: false,
                                        autoPlay: false,
                                        viewportFraction: 1),
                                    items: slider(reviews!),
                                  );
                                } else {
                                  return SizedBox();
                                }

                              }
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 70),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        buttonCarouselController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.linear),
                                    child: Image.asset(
                                      Assets.shared.right,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        buttonCarouselController.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.linear),
                                    child: Image.asset(
                                      Assets.shared.left,
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            info = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 123,
                          height: 36,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                                blurRadius: 0.10,
                                spreadRadius: 0.10,
                              ),
                            ],
                            color: "#D1DFC8".toHexa(),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Text(
                            'العودة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: "#FFFFFF".toHexa(),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ])),
    ));
  }

  List<Widget> slider(List<ReviewsModel> reviews) {
    List<Widget> items = [];
    var itemsCount = reviews.length - 1;
    for (var i = 0; i <= itemsCount; i++) {
      items.add(Builder(
        builder: (BuildContext context) {
          return Card(
            elevation: 4,
            surfaceTintColor: Colors.white,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              side: BorderSide(color: Colors.white),
            ),
            child: SizedBox(
              width: 238,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: user.image != ""
                        ? Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(user.image),
                                    fit: BoxFit.cover)),
                          )
                        : Icon(
                            Icons.person,
                            size: 52,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(reviews[i].name),
                        RatingBarIndicator(
                          itemSize: 15,
                          rating: reviews[i].review,
                          itemCount: 5,
                          itemBuilder: (context, _) => Image.asset(
                            Assets.shared.rose,
                          ),
                        ),
                        Text(reviews[i].note),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ));
    }
    return items;
  }
}
