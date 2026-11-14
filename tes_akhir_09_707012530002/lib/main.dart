import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiLayananWarga());
}

// ================= MODEL DATA =================

class Layanan {
  final String nama;
  final String deskripsi;
  final IconData ikon;

  const Layanan({
    required this.nama,
    required this.deskripsi,
    required this.ikon,
  });
}

class Pengajuan {
  final String layanan;
  final String nama;
  final String keperluan;
  final String tanggal;

  Pengajuan({
    required this.layanan,
    required this.nama,
    required this.keperluan,
    required this.tanggal,
  });
}

// ================= APLIKASI =================

class AplikasiLayananWarga extends StatelessWidget {
  const AplikasiLayananWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layanan Warga Kota Bandung',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanUtama(),
    );
  }
}

// ================= HALAMAN UTAMA (BottomNavigationBar) =================

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int indexAktif = 0;
  final List<Pengajuan> daftarPengajuan = [];

  final List<Layanan> daftarLayanan = const [
    Layanan(
      nama: 'Surat Pengantar Domisili',
      deskripsi: 'Keterangan tempat tinggal warga di kelurahan.',
      ikon: Icons.home_work,
    ),
    Layanan(
      nama: 'Surat Keterangan Usaha UMKM',
      deskripsi: 'Bukti legalitas usaha mikro, kecil, dan menengah.',
      ikon: Icons.storefront,
    ),
    Layanan(
      nama: 'Rekomendasi Jamkesda',
      deskripsi: 'Jaminan kesehatan daerah untuk warga Kota Bandung.',
      ikon: Icons.health_and_safety,
    ),
    Layanan(
      nama: 'Surat Keterangan Tidak Mampu',
      deskripsi: 'Keterangan kondisi ekonomi untuk keperluan bantuan.',
      ikon: Icons.volunteer_activism,
    ),
  ];

  // Navigator.push + kirim data lewat constructor + terima data balikan (await)
  Future<void> bukaFormulir(Layanan layanan) async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HalamanFormulir(layanan: layanan);
        },
      ),
    );

    if (!mounted) return;

    if (hasil != null && hasil is Pengajuan) {
      setState(() {
        daftarPengajuan.insert(0, hasil);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${hasil.layanan} berhasil diajukan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> halaman = [
      TabBeranda(
        daftarLayanan: daftarLayanan,
        onPilihLayanan: bukaFormulir,
      ),
      TabRiwayat(daftarPengajuan: daftarPengajuan),
      TabProfil(totalPengajuan: daftarPengajuan.length),
    ];

    const List<String> judul = ['Beranda', 'Riwayat Pengajuan', 'Profil'];

    return Scaffold(
      appBar: AppBar(
        title: Text(judul[indexAktif]),
        centerTitle: true,
      ),
      body: halaman[indexAktif],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexAktif,
        onTap: (index) {
          setState(() {
            indexAktif = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// ================= TAB BERANDA =================

class TabBeranda extends StatelessWidget {
  final List<Layanan> daftarLayanan;
  final void Function(Layanan) onPilihLayanan;

  const TabBeranda({
    super.key,
    required this.daftarLayanan,
    required this.onPilihLayanan,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Layanan Administrasi Warga',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Ajukan dokumen tanpa antre di kantor kelurahan.',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 16),
        ...daftarLayanan.map((layanan) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade50,
                child: Icon(layanan.ikon, color: Colors.indigo),
              ),
              title: Text(
                layanan.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(layanan.deskripsi),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                onPilihLayanan(layanan);
              },
            ),
          );
        }),
      ],
    );
  }
}

// ================= TAB RIWAYAT =================

class TabRiwayat extends StatelessWidget {
  final List<Pengajuan> daftarPengajuan;

  const TabRiwayat({super.key, required this.daftarPengajuan});

  @override
  Widget build(BuildContext context) {
    if (daftarPengajuan.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 72,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              const Text(
                'Belum Ada Pengajuan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Pilih layanan di tab Beranda untuk mengajukan dokumen.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: daftarPengajuan.length,
      itemBuilder: (context, index) {
        final p = daftarPengajuan[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade100,
              foregroundColor: Colors.green.shade800,
              child: const Icon(Icons.check),
            ),
            title: Text(p.layanan),
            subtitle: Text(
              'Atas nama ${p.nama}\nKeperluan: ${p.keperluan}\n${p.tanggal}',
            ),
            isThreeLine: true,
            trailing: Text('#${daftarPengajuan.length - index}'),
          ),
        );
      },
    );
  }
}

// ================= TAB PROFIL =================

class TabProfil extends StatelessWidget {
  final int totalPengajuan;

  const TabProfil({super.key, required this.totalPengajuan});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.indigo.shade100,
              child: const Icon(Icons.person, size: 50, color: Colors.indigo),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Muhammad Khairul Ihdhar',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Warga Kota Bandung',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('NIM'),
                      Text(
                        '707012530002',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Pengajuan'),
                      Text(
                        '$totalPengajuan Dokumen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= HALAMAN FORMULIR (menerima data + mengirim balik) =================

class HalamanFormulir extends StatefulWidget {
  final Layanan layanan;

  const HalamanFormulir({super.key, required this.layanan});

  @override
  State<HalamanFormulir> createState() => _HalamanFormulirState();
}

class _HalamanFormulirState extends State<HalamanFormulir> {
  final _kunciForm = GlobalKey<FormState>();
  final _namaController = TextEditingController(text: 'Muhammad Khairul Ihdhar');
  final _keperluanController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _keperluanController.dispose();
    super.dispose();
  }

  void ajukan() {
    if (!_kunciForm.currentState!.validate()) return;

    final sekarang = DateTime.now();
    final pengajuan = Pengajuan(
      layanan: widget.layanan.nama,
      nama: _namaController.text.trim(),
      keperluan: _keperluanController.text.trim(),
      tanggal: '${sekarang.day}/${sekarang.month}/${sekarang.year}',
    );

    // Tutup halaman dan kirim data balik ke halaman sebelumnya
    Navigator.pop(context, pengajuan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pengajuan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _kunciForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.indigo.shade50,
                child: ListTile(
                  leading: Icon(widget.layanan.ikon, color: Colors.indigo),
                  title: Text(
                    widget.layanan.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(widget.layanan.deskripsi),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _keperluanController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Keperluan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit_note),
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Keperluan wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: ajukan,
                icon: const Icon(Icons.send),
                label: const Text('Ajukan'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}