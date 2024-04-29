import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/profile_screen/change_mail.dart';
import 'package:magical_food/pages/profile_screen/change_password.dart';
import 'package:magical_food/pages/profile_screen/image_controller.dart';
import 'package:magical_food/pages/splash_screen/splash_screen.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Profile ",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Consumer<ImageControllerProvider>(
            builder: (context, ImageControllerProvider ip, chid) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder<QuerySnapshot?>(
                stream: Auth().getProfileData(),
                builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme.of(context).cardColor,
                                          width: 2),
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data!.docs[0]["imageUrl"]),
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              child: Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              ),
                                            );
                                          },
                                        )),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ip.pickeImage(context,
                                      FirebaseAuth.instance.currentUser!.uid);
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          ReusableListtile(
                            title: snapshot.data!.docs[0]["name"],
                            iconData: Icons.person_outline,
                            tra: IconButton(
                                onPressed: () {
                                  ip.changeName(context,
                                      FirebaseAuth.instance.currentUser!.uid);
                                },
                                icon: Icon(Icons.edit)),
                          ),
                          SizedBox(height: 20),
                          ReusableListtile(
                            title: snapshot.data!.docs[0]["phone"],
                            iconData: Icons.phone_outlined,
                            tra: IconButton(
                                onPressed: () {
                                  ip.changePhone(context,
                                      FirebaseAuth.instance.currentUser!.uid);
                                },
                                icon: Icon(Icons.edit)),
                          ),
                          SizedBox(height: 20),
                          ReusableListtile(
                            title: FirebaseAuth.instance.currentUser!.email
                                .toString(),
                            iconData: Icons.email,
                            tra: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ChangeMail();
                                  })).then((value) {
                                    setState(() {});
                                  });
                                },
                                icon: Icon(Icons.edit)),
                          ),
                          SizedBox(height: 20),
                          ReusableListtile(
                            title: "Change Password",
                            iconData: Icons.key_outlined,
                            tra: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ChangePassword();
                                  }));
                                },
                                icon: Icon(Icons.arrow_forward_ios)),
                          ),
                          SizedBox(height: 20),
                          Card(
                            child: ListTile(
                              title: Text("Logoout"),
                              leading: Icon(Icons.logout),
                              trailing: IconButton(
                                  onPressed: () {
                                    ThemeProvider().logout();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) {
                                      return SplashScreen();
                                    }), (route) => false);
                                  },
                                  icon: Icon(Icons.arrow_forward_ios)),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          );
        }));
  }
}

class ReusableListtile extends StatelessWidget {
  String title;
  IconData iconData;
  IconButton tra;
  ReusableListtile({
    required this.iconData,
    required this.title,
    required this.tra,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: tra,
        leading: Icon(iconData),
      ),
    );
  }
}
