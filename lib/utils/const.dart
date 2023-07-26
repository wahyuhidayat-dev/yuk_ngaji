import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//! API
int timeout = 35000;
String apiURL = "https://equran.id/";
String apiHadistURL = "https://hadits-api.superxdev.repl.co/";
String searchHadist = "search?q=";
String endpointdaftarSurat = "api/v2/surat";
String endpointdetailSurat = "api/v2/surat/";
String endpointdetailTafsir = "api/v2/tafsir/";

String banner = "ca-app-pub-2608291856908961/5793299144";
String interstisial = "ca-app-pub-2608291856908961/1221884349";
String idAplikasi = "ca-app-pub-2608291856908961~5268940564";

//! Fonts style
TextStyle fontLight = GoogleFonts.quicksand(fontWeight: FontWeight.w400);
TextStyle fontRegular = GoogleFonts.quicksand(fontWeight: FontWeight.w400);
TextStyle fontMedium = GoogleFonts.quicksand(fontWeight: FontWeight.w500);
TextStyle fontSemiBold = GoogleFonts.quicksand(fontWeight: FontWeight.w600);
TextStyle fontBold = GoogleFonts.quicksand(fontWeight: FontWeight.w700);

//! COLOR

const pinkColor = Color(0xFFF38181);
const yellowColor = Color(0xFFFCE38A);
const sageColor = Color(0xFFEAFFD0);
const blueColor = Color(0xFF42A5F5);

const blue100 = Color(0xFFBBDEFB);
const blue200 = Color(0xFF90CAF9);
const blue300 = Color(0xFF64B5F6);

//Color(0xFF95E1D3);
const whiteColor = Color(0xFFFFFFFF);
const grayColor = Color(0xFF393E46);
const grayFont = Color(0xFF7997A8);
const tileColor = Color(0xFFF5F5F5);

const newColorFont = Color(0xFF21497E);
const colorDarkBlue = Color(0xFF21497E);
const colorSoftBlue = Color(0xFF2A7FAA);
const colorOceanBlue = Color(0xFF47B9C6);
const colorGreen = Color(0xFFACE9DF);
const colorSage = Color(0xFFD5F8E2);

//! FAQ

Map<String, dynamic> dataFaq = {
  "faq": [
    {
      "id": "1",
      "pertanyaan": "Pertanyaan: Apa itu aplikasi Quran?",
      "jawaban":
          "Jawaban: Aplikasi Quran adalah sebuah aplikasi berbasis mobile yang memungkinkan pengguna untuk membaca, mencari, dan mendengarkan ayat-ayat suci Al-Quran dalam berbagai bahasa dan terjemahan."
    },
    {
      "id": "2",
      "pertanyaan":
          "Pertanyaan: Apakah aplikasi ini tersedia untuk platform seluler tertentu?",
      "jawaban":
          "Jawaban: Ya, aplikasi Quran kami tersedia untuk platform seluler Android dan iOS. Anda dapat mengunduhnya dari Google Play Store atau App Store."
    },
    {
      "id": "3",
      "pertanyaan":
          "Pertanyaan: Apakah aplikasi ini menyediakan terjemahan dalam berbagai bahasa?",
      "jawaban":
          "Jawaban: tidak, aplikasi kami menyediakan terjemahan Al-Quran dalam Bahasa Indonesia saja"
    },
    {
      "id": "4",
      "pertanyaan":
          "Pertanyaan: Bisakah saya mengakses aplikasi ini secara offline?",
      "jawaban":
          "Jawaban: Tidak bisa. Kedepan aplikasi ini memungkinkan Anda membaca Quran tanpa koneksi internet."
    },
    {
      "id": "5",
      "pertanyaan":
          "Pertanyaan: Apakah ada fitur pencarian dalam aplikasi ini?",
      "jawaban":
          "Jawaban: Tentu saja, aplikasi kami dilengkapi dengan fitur pencarian yang memungkinkan Anda mencari nama surat dalam seluruh Al-Quran atau terjemahan hadist."
    },
    {
      "id": "6",
      "pertanyaan":
          "Pertanyaan: Apakah aplikasi ini menyediakan fitur pembacaan suara (audio)?",
      "jawaban":
          "Jawaban: Ya, aplikasi kami menyediakan fitur pembacaan suara oleh qari terkenal. Anda dapat mendengarkan bacaan Al-Quran dengan berbagai gaya dan tartil."
    },
    {
      "id": "7",
      "pertanyaan":
          "Pertanyaan: Bisakah saya berbagi ayat-ayat dengan teman saya?",
      "jawaban":
          "Jawaban: Tentu saja! Aplikasi kami memungkinkan Anda untuk berbagi ayat-ayat Al-Quran melalui pesan teks, media sosial, atau melalui email."
    },
    {
      "id": "8",
      "pertanyaan":
          "Pertanyaan: Apakah ada fitur pengingat untuk membantu saya membaca Quran secara teratur?",
      "jawaban":
          "Jawaban: Ya, aplikasi kami menyediakan fitur pengingat yang dapat Anda atur untuk membantu Anda menjaga kebiasaan membaca Quran secara teratur."
    },
    {
      "id": "9",
      "pertanyaan":
          "Pertanyaan: Bagaimana cara mendapatkan pembaruan dan fitur terbaru dari aplikasi Quran?",
      "jawaban":
          "Jawaban: Untuk mendapatkan pembaruan dan fitur terbaru, pastikan Anda mengaktifkan pembaruan otomatis di Google Play Store. Kami juga akan mengirimkan pemberitahuan melalui aplikasi tentang pembaruan yang tersedia."
    }
  ]
};

//! time notification

const int kWorkDuration = 5; // production: 25 minutes
const int kRestDuration = 2; // production: 300 (5 minutes)
const int kLongRestDuration = 3; // production: 900 (15 minutes)
