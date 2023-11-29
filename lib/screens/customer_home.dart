import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:new_shop/screens/category.dart';
import 'package:new_shop/screens/furniture.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode _focusNode = FocusNode();
  final List<Map<String, String>> imageList = [
    {'assetPath': 'assets/image/slider1.png'},
    {'assetPath': 'assets/image/slider1.png'},
    {'assetPath': 'assets/image/slider1.png'},
  ];

  String searchText = '';

  List<Furniture> filteredFurnitureList = [
    const Furniture(
      imagePath: "assets/kursi_hijau.jpg",
      nameProduct: "KURSI HIJAU",
      harga: "Rp 120.000,00",
    ),
    const Furniture(
      imagePath: "assets/kursi_putih.jpg",
      nameProduct: "KURSI PUTIH",
      harga: "Rp 120.000,00",
    ),
    const Furniture(
      imagePath: "assets/meja.jpg",
      nameProduct: "MEJA KAYU",
      harga: "Rp 180.000,00",
    ),
    const Furniture(
      imagePath: "assets/pintu_kayu.png",
      nameProduct: "PINTU KAYU",
      harga: "Rp 180.000,00",
    ),
  ];

  List<Furniture> getFilteredFurnitureList() {
    return filteredFurnitureList.where((furniture) {
      final name = furniture.nameProduct.toLowerCase();
      final searchLowerCase = searchText.toLowerCase();
      return name.contains(searchLowerCase);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bagian tombol bawah
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(206, 222, 189, 5),
        selectedItemColor:
            const Color.fromRGBO(67, 83, 52, 5), // Warna item yang dipilih
        unselectedItemColor: const Color.fromRGBO(
            67, 83, 52, 5), // Warna item yang tidak dipilih
        selectedIconTheme: const IconThemeData(
            color: Color.fromRGBO(67, 83, 52, 5),
            size: 32), // Warna ikon pada item yang dipilih
        unselectedIconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 241, 228, 5),
            size: 30), // Warna ikon pada item yang tidak dipilih
        selectedFontSize: 12, // Ukuran teks pada item yang dipilih
        unselectedFontSize: 10, // Ukuran teks pada item yang tidak dipilih
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
        selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "PESANAN",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "NOTIFIKASI",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: "ABOUT",
          ),
        ],
      ),

      //latar belakang
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background_homepage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      height: 78,
                      width: double.infinity,
                      color: const Color.fromRGBO(158, 179, 132, 5),
                    ),

                    //bagian search
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 34),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).requestFocus(_focusNode);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromRGBO(250, 241, 228, 5),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 40,
                                      child: Icon(Icons.search_rounded),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        focusNode: _focusNode,
                                        cursorHeight: 20,
                                        onChanged: (value) {
                                          setState(() {
                                            searchText = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          hintStyle: GoogleFonts.poppins(
                                              color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),

                          // Bagian tombol keranjang
                          SizedBox(
                            width: 50,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.local_grocery_store),
                                    iconSize: 30,
                                    color:
                                        const Color.fromRGBO(250, 241, 228, 5),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Bagian tombol profil
                          SizedBox(
                            width: 35,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.account_circle_outlined),
                                    iconSize: 30,
                                    color:
                                        const Color.fromRGBO(250, 241, 228, 5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //bagian slider
                    SizedBox(
                      height: 390,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                          ),
                          items: imageList.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(3, 3),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        color: Colors.black54,
                                      )
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      item['assetPath']!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    //bagian tombol katagori produk
                    const SizedBox(
                      height: 730,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Category(
                                  imagePath: "assets/pintu.png",
                                  title: "PINTU",
                                  showBorder: false),
                              SizedBox(width: 10),
                              Category(
                                  imagePath: "assets/kasur.png",
                                  title: "RUANG TIDUR",
                                  showBorder: false),
                              SizedBox(width: 10),
                              Category(
                                  imagePath: "assets/lemari.png",
                                  title: "LEMARI",
                                  showBorder: false),
                              SizedBox(width: 10),
                              Category(
                                  imagePath: "assets/dapur.png",
                                  title: "ALAT DAPUR",
                                  showBorder: false),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // bagian dashboard produk
                    SizedBox(
                      height: 790,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        padding: const EdgeInsets.symmetric(
                            vertical: 435, horizontal: 26),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: getFilteredFurnitureList().map((furniture) {
                          return Furniture(
                            imagePath: furniture.imagePath,
                            nameProduct: furniture.nameProduct,
                            harga: furniture.harga,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
