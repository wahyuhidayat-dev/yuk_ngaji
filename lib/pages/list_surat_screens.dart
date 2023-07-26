// ignore_for_file: must_be_immutable

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yuk_ngaji/state_management/getHome.dart';
import 'package:yuk_ngaji/utils/const.dart';

class ListSuratScreens extends StatefulWidget {
  List dataSurat;
  ListSuratScreens({super.key, this.reloadContacts, required this.dataSurat});
  Function()? reloadContacts;
  @override
  State<ListSuratScreens> createState() => _ListSuratScreensState();
}

class _ListSuratScreensState extends State<ListSuratScreens> {
  List suratSearch = [];
  List listSurat = [];
  bool isLoading = false;
  GetXHome getXHome = Get.put(GetXHome());
  @override
  void initState() {
    super.initState();
    // getXHome.init(context);
    // setState(() {
    //   listSurat = widget.dataSurat;
    // });
  }

  @override
  Widget build(BuildContext context) {
    listSurat = widget.dataSurat;
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: ListView.builder(
        itemCount: listSurat.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTileCard(
                baseColor: tileColor,
                expandedColor: yellowColor,
                elevation: 0,
                colorCurve: Curves.bounceInOut,
                leading: CircleAvatar(
                  backgroundColor: pinkColor,
                  child: Text(
                    listSurat[index]['nomor'].toString(),
                    style:
                        fontBold.copyWith(fontSize: 14.sp, color: whiteColor),
                  ),
                ),
                title: Text(
                  listSurat[index]['nama'] ?? '',
                  style: fontBold.copyWith(fontSize: 14.sp, color: grayColor),
                ),
                subtitle: Text(
                  listSurat[index]['namaLatin'] ?? '',
                  style: fontBold.copyWith(fontSize: 14.sp, color: grayColor),
                ),
                children: [
                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${listSurat[index]['arti'] ?? ''} - ${listSurat[index]['tempatTurun'] ?? ''}',
                      style:
                          fontBold.copyWith(fontSize: 14.sp, color: grayColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getXHome.removeAllHtmlTags(
                          listSurat[index]['deskripsi'] ?? ''),
                      textAlign: TextAlign.justify,
                      style: fontMedium.copyWith(
                          fontSize: 14.sp, color: grayColor),
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(backgroundColor: pinkColor),
                      onPressed: () {
                        getXHome.getDetailSurat(
                            listSurat[index]['nomor'].toString());
                      },
                      child: Text(
                        'Baca Surat',
                        style: fontMedium.copyWith(
                            fontSize: 14.sp, color: whiteColor),
                      ))
                ],
              ));
        },
      ),
    );
  }
}
