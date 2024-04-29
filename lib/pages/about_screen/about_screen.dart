import 'package:flutter/material.dart';
import 'package:magical_food/pages/shop_location/shop_location.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                "    ကျွုန်ုပ်တိုprojectသည် customerနှင့်business ownerကြားတွင် ပိုမိုအဆင်ပြေစေရန် ချိတ်ဆက်ပေးမည့် Application ဖြစ်သည်။Customerနှင့် ချောမွေ့စွာ ချိတ်ဆက်ပေးခြင်းဖြင့် ကျွန်ုပ်တို့Applicationသည် စားသောက်ဆိုင်လုပ်ငန်းများအတွက် ပိုမိုကောင်းသောဝန်ဆောင်မှုများကို ဖန်တီးပေးနိုင်မည်ဖြစ်ပါသည်။customer များအတွက်လဲ မိမိနေရမှာတင်မီနူးအမျိုးမျိုးကို လွယ်ကူစွာ ရွေးချယ်မှာယူကာ အိမ်တံခါးဝသို့ပို့ဆောင်ပေးမှုကို ရရှိနိုင်ပါသည်။ကျွန်ုပ်တို့၏ ခေတ်မီသောFood Delivery Applicationဖြင့်သင့်ရဲ့ စားသောက်ဆိုင်လုပ်ငန်းကို အောင်မြင်မှုကိုချဲ့ထွင်နိုင်ပါသည်။",
                style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    wordSpacing: 1,
                    height: 2),
              ),
              SizedBox(height: 20),
              Text(
                "Yummy Treats Application ဖန်တီးရခြင်း ရည်ရွယ်ချက်များ",
                style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    wordSpacing: 1,
                    height: 1.5,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "    အဓိကရည်ရွယ်ချက်မှာcustomerများလူကိုယ်တိုင်လာရောက်ရန်မလိုအပ်ဘဲအိမ်အရောက်မှာယူခြင်း ၊ ကြိုတင်Bookingလုပ်ခြင်းများလွယ်ကူစွာပြုလုပ်နိုင်သောserviceမျိုးပေးနိုင်ရန်ယနေ့ခေတ်တွင်အွန်လိုင်းမှအစားအသောက်များမှာယူခြင်းသည်ပိုမိုတွင်ကျယ်လာသောကြောင့်ဤApplicationကိုအသုံးပြု၍ပိုမိုမြန်ဆန်တိကျ၍အချိန်ကုန်သက်သာစေရန်စားသုံးသူများစိတ်ကျေနပ်မှုကိုပိုမိုရရှိစေပြီးမိမိလုပ်ငန်း၏ရောင်းအားကိုမြှင့်တင်နိုင်စေရန်",
                style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    wordSpacing: 1,
                    height: 2),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ShopLocation(
                            lat: 20.140163181781006, log: 94.9408583343029);
                      }));
                    },
                    icon: Icon(Icons.location_on),
                    label: Text("Shop Location")),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Any Problem,contact me "),
                    InkWell(
                      child: Text(
                        "hhtz12450@gmail.com",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onTap: () {
                        String? encodeQueryParameters(
                            Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }

                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'hhtz12450@gmail.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject':
                                'Help me and explain  about this problem.',
                          }),
                        );

                        launchUrl(emailLaunchUri);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
