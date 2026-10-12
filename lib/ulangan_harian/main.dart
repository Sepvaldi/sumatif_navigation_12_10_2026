import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asep App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. HALAMAN LOGIN
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: const Icon(Icons.phone_android, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'TechBuy',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pusat Belanja Gadget & Elektronik Terlengkap',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    String inputUsername = _usernameController.text.trim();
                    if (inputUsername.isEmpty) {
                      inputUsername = 'Tamu';
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(username: inputUsername),
                      ),
                    );
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. MAIN PAGE DENGAN BOTTOM NAVIGATION BAR
class MainPage extends StatefulWidget {
  final String username;
  const MainPage({super.key, required this.username});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    if (_currentIndex == 3) {
      activePage = ProfilePage(username: widget.username);
    } else {
      activePage = const CatalogPage();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          if (index == 0 || index == 3) {
            setState(() {
              _currentIndex = index;
            });
          } else {
            String menuName = index == 1 ? 'Riwayat' : 'Pembayaran';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Menu $menuName (Hanya diklik saja)'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Catalog'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Pembayaran'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Model Data Gadget
class GadgetModel {
  final String nama;
  final double harga;
  final String imageUrl;
  final String deskripsi;

  GadgetModel({
    required this.nama,
    required this.harga,
    required this.imageUrl,
    required this.deskripsi,
  });
}

// 3. HALAMAN CATALOG
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GadgetModel> listGadget = [
      GadgetModel(
        nama: 'Smartphone Pro X',
        harga: 5000000,
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',
        deskripsi: 'Smartphone flagship berperforma tinggi dengan kamera jernih, layar AMOLED 120Hz, dan baterai tahan seharian.',
      ),
      GadgetModel(
        nama: 'Laptop Gaming Z',
        harga: 12000000,
        imageUrl: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500',
        deskripsi: 'Laptop gaming bertenaga dengan prosesor generasi terbaru, kartu grafis kelas atas, dan sistem pendingin optimal.',
      ),
      GadgetModel(
        nama: 'Smartwatch Alpha',
        harga: 1500000,
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
        deskripsi: 'Jam tangan pintar stylish dengan pemantau detak jantung, pelacak kebugaran, dan notifikasi real-time.',
      ),
      GadgetModel(
        nama: 'Wireless Earbuds',
        harga: 750000,
        imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500',
        deskripsi: 'Earbuds nirkabel dengan teknologi Active Noise Cancellation (ANC) dan kualitas suara bass yang mendalam.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog TechBuy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: listGadget.length,
        itemBuilder: (context, index) {
          final gadget = listGadget[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailCardPage(gadget: gadget),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      gadget.imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 120,
                        color: Colors.blue[100],
                        child: const Icon(Icons.phone_android, size: 40, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gadget.nama,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'RP ${gadget.harga.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 4. HALAMAN DETAIL CARD PAGE
class DetailCardPage extends StatefulWidget {
  final GadgetModel gadget;

  const DetailCardPage({super.key, required this.gadget});

  @override
  State<DetailCardPage> createState() => _DetailCardPageState();
}

class _DetailCardPageState extends State<DetailCardPage> {
  late double hargaAkhir;
  bool isDiscountApplied = false;
  String infoDiskon = '';

  @override
  void initState() {
    super.initState();
    hargaAkhir = widget.gadget.harga;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: Colors.blue,
                iconTheme: const IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.gadget.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.blue[200], child: const Icon(Icons.phone_android, size: 80)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.gadget.nama,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.star, color: Colors.amber, size: 18),
                                SizedBox(width: 4),
                                Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.verified, size: 16, color: Colors.blue[600]),
                          const SizedBox(width: 4),
                          Text('Garansi Resmi TechBuy', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          const SizedBox(width: 12),
                          Icon(Icons.local_shipping, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text('Free Ongkir', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Harga', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                              const SizedBox(height: 4),
                              if (isDiscountApplied) ...[
                                Text(
                                  'RP ${widget.gadget.harga.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'RP ${hargaAkhir.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                              ] else ...[
                                Text(
                                  'RP ${widget.gadget.harga.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                              ]
                            ],
                          ),
                          const Spacer(),
                          if (isDiscountApplied)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                infoDiskon,
                                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Deskripsi Produk',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.gadget.deskripsi,
                        style: TextStyle(color: Colors.grey[700], height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blue, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.local_offer, color: Colors.blue),
                          label: const Text(
                            'Klaim Voucher Discount',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            final double? diskonPersen = await Navigator.push<double>(
                              context,
                              MaterialPageRoute(builder: (context) => const DiscountPage()),
                            );

                            if (diskonPersen != null) {
                              setState(() {
                                double potongan = widget.gadget.harga * (diskonPersen / 100);
                                hargaAkhir = widget.gadget.harga - potongan;
                                isDiscountApplied = true;
                                infoDiskon = 'Diskon ${diskonPersen.toInt()}% Berhasil';
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -4)),
                ],
              ),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Disesuaikan dengan tema utama app
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pesanan Gadget Berhasil Disimpan!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text(
                    'Beli Sekarang',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 5. HALAMAN DISCOUNT PAGE
class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Voucher Diskon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.discount, color: Colors.white),
              ),
              title: const Text('Discount 10%', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Potongan harga gadget 10%'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pop(context, 10.0),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.discount, color: Colors.white),
              ),
              title: const Text('Discount 20%', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Potongan harga gadget 20%'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pop(context, 20.0),
            ),
          ),
        ],
      ),
    );
  }
}

// 6. HALAMAN PROFILE ACCOUNT
class ProfilePage extends StatelessWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, size: 55, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text('Kode Member: TECH-2026-123', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileSection(
              title: 'Detail Profil',
              items: [
                _buildListTile(Icons.person_outline, 'Nama Pengguna', username),
                _buildListTile(Icons.badge_outlined, 'Kode Member', 'TECH-2026-123'),
                _buildListTile(Icons.phone_outlined, 'Nomor WhatsApp', '081234567890'),
              ],
            ),
            const SizedBox(height: 16),
            _buildProfileSection(
              title: 'Transaksi',
              items: [
                _buildListTile(Icons.receipt_long_outlined, 'Riwayat Pembelian', 'Lihat semua transaksi'),
                _buildListTile(Icons.account_balance_wallet_outlined, 'Metode Pembayaran', 'Transfer Bank, E-Wallet'),
                _buildListTile(Icons.local_offer_outlined, 'Voucher Saya', '2 Voucher Aktif'),
              ],
            ),
            const SizedBox(height: 16),
            _buildProfileSection(
              title: 'Keamanan',
              items: [
                _buildListTile(Icons.lock_outline, 'Ubah Kata Sandi', 'Terakhir diubah 30 hari lalu'),
                _buildListTile(Icons.security_outlined, 'Verifikasi 2 Langkah', 'Aktif'),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        Card(
          elevation: 1.5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: () {},
    );
  }
}