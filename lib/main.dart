import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  static const Color kkuNavy = Color(0xFF0B2D6B);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kkuNavy),
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // ===== ข้อมูลนักศึกษา =====
  static const String fullName = 'นางสาวภวพิชญา คำวงษา';
  static const String studentId = '663450042-8';
  static const String year = 'ชั้นปีที่ 3';
  static const String program = 'วิทยาการคอมพิวเตอร์และสารสนเทศ';
  static const String faculty = 'คณะสหวิทยาการ';
  static const String university = 'มหาวิทยาลัยขอนแก่น';
  static const String campus = 'วิทยาเขตหนองคาย';
  static const String email = 'curvepawapitchaya@gmail.com';
  static const String phone = '098-201-6388';

  // ===== Assets =====
  static const String profileImage = 'assets/images/profile.jpg';
  static const String kkuLogo = 'assets/images/kku_logo.png';
  static const String facultyLogo = 'assets/images/faculty_logo.png';

  static const String githubIcon = 'assets/icons/github.png';
  static const String facebookIcon = 'assets/icons/facebook.png';
  static const String instagramIcon = 'assets/icons/instagram.png';

  static const Map<String, String> links = {
    'GitHub': 'https://github.com/pwpitchaya',
    'Facebook': 'https://www.facebook.com/pawapitchaya.kamwongsa?locale=th_TH',
    'Instagram':
        'https://www.instagram.com/210947cp?igsh=cXJydnBndjdrdHQ%3D&utm_source=qr',
  };

  static const Color kkuGold = Color(0xFFC9A227);
  static const Color kkuNavy = Color(0xFF0B2D6B);
  static const Color kkuBlue = Color(0xFF1565C0);

  String _iconFor(String key) {
    switch (key) {
      case 'GitHub':
        return githubIcon;
      case 'Facebook':
        return facebookIcon;
      case 'Instagram':
        return instagramIcon;
      default:
        return '';
    }
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _GlassHeader(
              leftLogo: kkuLogo,
              rightLogo: facultyLogo,
              title: university,
              subtitle: '$faculty • $campus',
            ),
            const SizedBox(height: 16),

            _ProfileCard(
              image: profileImage,
              name: fullName,
              studentId: studentId,
              year: year,
              program: program,
            ),
            const SizedBox(height: 16),

            _Section(
              title: 'Student Information',
              icon: Icons.badge_outlined,
              child: Column(
                children: const [
                  _Info('ชื่อ - นามสกุล', fullName),
                  _Info('รหัสนักศึกษา', studentId),
                  _Info('ชั้นปี', year),
                  _Info('หลักสูตร', program),
                  _Info('คณะ / มหาวิทยาลัย', '$faculty $university'),
                  _Info('วิทยาเขต', campus),
                  _Info('อีเมล', email),
                  _Info('เบอร์โทรศัพท์', phone),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _Section(
              title: 'Social Links & QR',
              icon: Icons.link,
              child: Column(
                children: [
                  ...links.entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _SocialTile(
                          icon: _iconFor(e.key),
                          title: e.key,
                          subtitle: Uri.parse(e.value).host,
                          onTap: () => _open(e.value),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: links.entries
                        .map(
                          (e) => Expanded(
                            child: Column(
                              children: [
                                Text(
                                  e.key,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 6),
                                QrImageView(
                                  data: e.value,
                                  size: 100,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
              ),
              child: Row(
                children: const [
                  Icon(Icons.location_city),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'KKU Nong Khai Campus',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- Widgets ---------------- */

class _GlassHeader extends StatelessWidget {
  final String leftLogo;
  final String rightLogo;
  final String title;
  final String subtitle;

  const _GlassHeader({
    required this.leftLogo,
    required this.rightLogo,
    required this.title,
    required this.subtitle,
  });

  static const Color gold = Color(0xFFC9A227);
  static const Color navy = Color(0xFF0B2D6B);
  static const Color blue = Color(0xFF1565C0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          Container(
            height: 96,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [navy, blue, gold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              height: 96,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Image.asset(leftLogo, width: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                      Text(subtitle,
                          style: TextStyle(
                              color:
                                  Colors.white.withValues(alpha: 0.9))),
                    ],
                  ),
                ),
                Image.asset(rightLogo, width: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String image;
  final String name;
  final String studentId;
  final String year;
  final String program;

  const _ProfileCard({
    required this.image,
    required this.name,
    required this.studentId,
    required this.year,
    required this.program,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 44,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text('Student ID: $studentId'),
                  Text(year),
                  Text(program),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _Section({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w900)),
            ]),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String label;
  final String value;

  const _Info(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
              width: 140,
              child: Text(label,
                  style:
                      const TextStyle(fontWeight: FontWeight.w700))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _SocialTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SocialTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800)),
                  Text(subtitle,
                      style:
                          const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.open_in_new),
          ],
        ),
      ),
    );
  }
}
