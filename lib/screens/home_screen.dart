import 'package:cours_flutter/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/option.dart';
import '../models/transaction.dart';
import '../utils/constante.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;
  List<Option> optionList=[
    Option(text: "Transfert", color: Colors.deepPurpleAccent, icon: Icons.person),
    Option(text: "Paiement", color: Colors.orange, icon: Icons.shopping_basket_sharp),
    Option(text: "Credit", color: Colors.blue, icon: Icons.phone_android),
    Option(text: "Banque", color: Colors.redAccent, icon: Icons.account_balance),
    Option(text: "Cadeaux", color: Colors.green, icon: Icons.card_giftcard),
  ];

  List<Transaction> transactionList = [
    Transaction("Modou", "771234567", 10000, DateTime.now(), true),
    Transaction("Mbaye", "771235457", 50000, DateTime.now(), false),
    Transaction("Laye", "78253624", 23000, DateTime.now(), false),
    Transaction("Mbaye", "77466676", 345000, DateTime.now(), false),
    Transaction("Abdou", "76946667", 345000, DateTime.now(), true),
    Transaction("Diallo", "7546667", 345000, DateTime.now(), true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: primaryColor,
            pinned: true,
            floating: true,
            expandedHeight: 90,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: IconButton(
                onPressed: () {
                  print("object");
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isVisible
                      ? RichText(
                          text: const TextSpan(
                              text: "5.000",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w600),
                              children: [
                              TextSpan(
                                  text: "F", style: TextStyle(fontSize: 18)),
                            ]))
                      : const Text(
                          "••••••••",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: isVisible
                        ? const Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.visibility_rounded,
                            color: Colors.white,
                          ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: 1000,
                child: Stack(
                  children: [
                    Container(
                      color: primaryColor,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                    ),
                    Column(
                      children: [
                        cardWidget(),
                        GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: optionList.length,
                        itemBuilder: (context, index){
                          return optionWidget(
                              icon: optionList[index].icon,
                              color: optionList[index].color,
                              txt: optionList[index].text);
                        }
                        ),
                        Divider(
                          thickness: 7,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index){
                              Transaction transact = transactionList[index];
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${transact.isRetrait?"A ":"De "}${transact.name} ${transact.phoneNumber}", style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16, fontWeight: FontWeight.w600),),
                                        Text("${transact.isRetrait?"-":""}${transact.price}F", style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16, fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    Text(transact.dateTime.toString(), style: TextStyle(color: Colors.grey),)
                                  ],
                                ),
                              );
                            }, separatorBuilder: (context, index){
                              return SizedBox(height: 5,);
                        }, itemCount: transactionList.length)
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
  optionWidget({required IconData icon, required Color color, required String txt}){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(45),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 50, color: color),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(txt, style: const TextStyle(fontSize: 16),),
      ],
    );
  }
  cardWidget(){
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
            image: const AssetImage("assets/images/bg_card.png"),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.grey.shade300.withOpacity(0.3), BlendMode.srcIn)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 85),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            children: [
              Image.asset("assets/images/qr_img.png",
                width: 120,

              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_camera),
                  SizedBox(width: 5,),
                  Text("Scanner")
                ],
              )

            ],
          )
      ),
    );
  }
}


