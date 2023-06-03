import 'dart:async';

import 'package:fic4_flutter_auth/data/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/profile/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileState? profileState;
  StreamSubscription? _profileSubscription;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
    _profileSubscription = context.read<ProfileBloc>().stream.listen((state) {
      setState(() {
        profileState = state;
      });
    });
  }

  @override
  void dispose() {
    _profileSubscription
        ?.cancel(); // Batalkan langganan stream saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainColor,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   centerTitle: true,
        //   backgroundColor: const Color(0xffffb703),
        //   title: Text(
        //     'Profile',
        //     style: GoogleFonts.poppins(
        //       color: Colors.black,
        //       fontSize: 16,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        body: Stack(children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18))),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (profileState is ProfileLoaded) ...[
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),

                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/profile.jpg')),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        // Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         (profileState as ProfileLoaded).profile.name ??
                        //             '',
                        //         style: GoogleFonts.poppins(
                        //           color: Colors.black,
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //       Text(
                        //         (profileState as ProfileLoaded).profile.email ??
                        //             '',
                        //         style: GoogleFonts.poppins(
                        //           color: Colors.black,
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ]),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            // !Email
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email', style: greyTextStyle),
                                  const SizedBox(height: 4),
                                  Text(
                                    (profileState as ProfileLoaded)
                                            .profile
                                            .email ??
                                        '',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 20, fontWeight: bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2,
                                                color: Colors.grey
                                                    .withOpacity(0.2)))),
                                  )
                                ],
                              ),
                            ),
                            // !NAMA
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Text('Nama', style: greyTextStyle),
                                  const SizedBox(height: 4),
                                  Text(
                                    (profileState as ProfileLoaded)
                                            .profile
                                            .name ??
                                        '',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 20, fontWeight: bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2,
                                                color: Colors.grey
                                                    .withOpacity(0.2)))),
                                  )
                                ],
                              ),
                            ),
                            // ! ROLE

                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Text('Role', style: greyTextStyle),
                                  const SizedBox(height: 4),
                                  Text(
                                    (profileState as ProfileLoaded)
                                            .profile
                                            .role ??
                                        '',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 20, fontWeight: bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2,
                                                color: Colors.grey
                                                    .withOpacity(0.2)))),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 2,
                  ),
                  onPressed: () {
                    SharedPreferences.getInstance().then((value) {
                      value.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    });
                  },
                  child: Text(
                    'Logout',
                    style:
                        whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                  ),
                ),
              )
            ],
          ),
        ]));
  }
}
