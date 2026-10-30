import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 225, 225),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: const ProfileCard(
              nama: 'FaizalIsman',
              nim: '24****74',
              kelas: '5D',
              ttl: 'Tegal-1*-0*-2***',
              photo: AssetImage('assets/img/my photo2.png'),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Warna & gaya
// ---------------------------------------------------------------------------
const _paper = Color(0xFFFBF6EC);
const _ink = Color(0xFF2F3A3C);
const _line = Color(0xFF5F6B6D);
const _beige = Color(0xFFEFE3D3);
const _avatar = Color(0xFF545D63);

// Untuk font tulisan tangan seperti di desain, tambahkan paket `google_fonts`
// lalu ganti ke: GoogleFonts.patrickHand(...) atau GoogleFonts.gaegu(...)
const _fontFamily = 'cursive';

// ---------------------------------------------------------------------------
// Kartu Profile
// ---------------------------------------------------------------------------
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String kelas;
  final String ttl;
  final ImageProvider? photo;

  const ProfileCard({
    super.key,
    this.nama = 'FaizalIsman',
    this.nim = '24****74',
    this.kelas = '5D',
    this.ttl = 'Tegal-0*-0*-2***',
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 40),
      decoration: BoxDecoration(
        color: _paper,
        border: Border.all(color: _line, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: _ink,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Container(height: 2, color: _line, margin: const EdgeInsets.symmetric(horizontal: 20)),
          const SizedBox(height: 28),
          _PhotoFrame(photo: photo),
          const SizedBox(height: 32),
          _Field(label: 'Nama:', value: nama),
          _Field(label: 'NIM:', value: nim),
          _Field(label: 'Kelas:', value: kelas),
          _Field(label: 'TTL:', value: ttl),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Baris isian: label + garis bawah
// ---------------------------------------------------------------------------
class _Field extends StatelessWidget {
  final String label;
  final String value;

  const _Field({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: _fontFamily,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 2),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: _line, width: 2)),
              ),
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: 22,
                  color: _ink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bingkai foto: cincin luar + busur putus-putus + lingkaran beige
// ---------------------------------------------------------------------------
class _PhotoFrame extends StatelessWidget {
  final ImageProvider? photo;
  const _PhotoFrame({this.photo});

  @override
  Widget build(BuildContext context) {
    const size = 190.0;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(size: const Size(size, size), painter: _RingPainter()),
          Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: const BoxDecoration(color: _beige, shape: BoxShape.circle),
            child: ClipOval(
              child: photo != null
                  ? Image(image: photo!, fit: BoxFit.cover)
                  : const _Placeholder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Kepala + ikon kamera
        Positioned(
          top: 34,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(color: _avatar, shape: BoxShape.circle),
            child: const Icon(Icons.photo_camera, color: _beige, size: 22),
          ),
        ),
        // Badan + tulisan FOTO
        Positioned(
          bottom: -2,
          child: Container(
            width: 84,
            height: 62,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              color: _avatar,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: const Text(
              'FOTO',
              style: TextStyle(
                color: _beige,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final paint = Paint()
      ..color = _line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Cincin luar penuh
    canvas.drawCircle(c, size.width / 2 - 1, paint);

    // Cincin dalam putus-putus (4 busur)
    final rect = Rect.fromCircle(center: c, radius: size.width / 2 - 14);
    const sweep = math.pi / 2 - 0.2;
    for (var i = 0; i < 4; i++) {
      final start = -math.pi / 2 + 0.1 + i * math.pi / 2;
      canvas.drawArc(rect, start, sweep, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}