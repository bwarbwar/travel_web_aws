import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// --- Sri Lankan Express Detail Page ---
class TravelDetailPage extends StatelessWidget {
  const TravelDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop
                ? MediaQuery.of(context).size.width * 0.1
                : 20,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleSection(),
              const SizedBox(height: 24),
              _buildImageGrid(context),
              const SizedBox(height: 48),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildMainContent()),
                  if (isDesktop) ...[
                    const SizedBox(width: 48),
                    const Expanded(flex: 1, child: BookingSidebar()),
                  ],
                ],
              ),
              if (!isDesktop) ...[
                const SizedBox(height: 48),
                const BookingSidebar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: SizedBox(
        height: 32,
        child: CachedNetworkImage(
          imageUrl:
              'https://framerusercontent.com/images/pPfPb5iDwQ0gmmLmQSsfNtPcudA.png',
          fit: BoxFit.contain,
          placeholder: (context, url) => const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (context, url, error) => const Text(
            'Avantour',
            style: TextStyle(
              color: Color(0xFF2196F3),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.menu, color: Colors.grey, size: 20),
                SizedBox(width: 8),
                Icon(Icons.account_circle, color: Colors.grey, size: 32),
              ],
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(color: Colors.grey.shade200, height: 1),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sri Lankan Express: Soul Searching in Paradise",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.place_outlined, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            const Text(
              "Colombo, Sri Lanka",
              style: TextStyle(color: Colors.grey),
            ),
            _dot(),
            const Text("5D4N", style: TextStyle(color: Colors.grey)),
            _dot(),
            const Text(
              "Beginner-friendly",
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border, size: 18),
              label: const Text("Save"),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dot() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    width: 4,
    height: 4,
    decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
  );

  Widget _buildImageGrid(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 500,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                "https://images.unsplash.com/photo-1546708973-b339540b5162?w=800",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      "https://framerusercontent.com/images/tAfL9UYQTolOtRVwFsv0i2pLTto.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Image.network(
                      "https://storage.googleapis.com/stateless-www-justwravel-com/2024/10/58174284-reasons-to-visit-sri-lanka.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Image.network(
                    "https://framerusercontent.com/images/gsl61i2RbGcg7JQIyOCEHnT4fSg.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.grid_view, size: 16),
                      label: const Text("Show all photos"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 5,
                      ),
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

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Highlights", subtitle: "#CoreMemories"),
        const SizedBox(height: 16),
        _buildHighlightCards(),
        const Divider(height: 64),
        const Text(
          "About this experience",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 32,
          runSpacing: 24,
          children: [
            CircularStat(label: "Nature", percent: 0.90, color: Colors.green),
            CircularStat(
              label: "Relax",
              percent: 0.45,
              color: Colors.blueAccent,
            ),
            CircularStat(label: "Culture", percent: 0.70, color: Colors.orange),
            CircularStat(label: "City", percent: 0.40, color: Colors.red),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          "Embark on a compact yet thrilling 5-day adventure through the heart of Sri Lanka! This itinerary blends culture, nature, and wildlife into one unforgettable experience.",
          style: TextStyle(color: Colors.grey, height: 1.6, fontSize: 16),
        ),
        const Divider(height: 64),
        _buildIncludedSection(),
        const Divider(height: 64),
        _buildItineraryTimeline(),
      ],
    );
  }

  Widget _sectionHeader(String title, {String? subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
          ],
        ),
        Row(
          children: [
            _circleNav(Icons.chevron_left),
            const SizedBox(width: 8),
            _circleNav(Icons.chevron_right),
          ],
        ),
      ],
    );
  }

  Widget _circleNav(IconData icon) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Icon(icon, size: 20),
  );

  Widget _buildHighlightCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _highlightCard(
            "Day 1",
            "Pidurangala Rock Sunset",
            "https://images.travelandleisureasia.com/wp-content/uploads/sites/6/2024/03/18182544/venice.jpeg",
          ),
          _highlightCard(
            "Day 1",
            "Begin your adventure",
            "https://cdn-gaecj.nitrocdn.com/JMwuRIbFKRytZpZBQQGkRvqmTfGyKhHA/assets/images/optimized/rev-3745045/turkeytravelplanner.com/wp-content/uploads/2023/12/konya-mevlana.jpg",
          ),
          _highlightCard(
            "Day 2",
            "Spice Gardens & Kandy",
            "https://res.klook.com/image/upload/fl_lossy.progressive,q_85/c_fill,w_680/v1663225108/blog/arh6isb8hkos0nmvlnnz.jpg",
          ),
        ],
      ),
    );
  }

  Widget _highlightCard(String day, String title, String url) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  url,
                  height: 180,
                  width: 240,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildIncludedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's included",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3,
          children: [
            _includeItem(Icons.restaurant, "food", "Day 2-5: Breakfast"),
            _includeItem(
              Icons.directions_bus,
              "transport",
              "Air-conditioned vehicle",
            ),
            _includeItem(Icons.hotel, "lodging", "4 nights in 3/4 star hotels"),
            _includeItem(
              Icons.person_pin,
              "instructor",
              "English-Speaking guide",
            ),
          ],
        ),
      ],
    );
  }

  Widget _includeItem(IconData icon, String title, String desc) {
    return Row(
      children: [
        Icon(icon, size: 32, color: Colors.grey),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              desc,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItineraryTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Itinerary",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _itineraryStep("Day 1", "Arrival and Sunset Hike to Pidurangala Rock"),
        _itineraryStep(
          "Day 2",
          "Sigiriya Fortress Climb, Spice Gardens & Kandy",
        ),
        _itineraryStep("Day 3", "Tea Country & Scenic Highland Train to Ella"),
        _itineraryStep("Day 4", "Ella Trekking Adventures"),
        _itineraryStep(
          "Day 5",
          "Safari Thrills at Yala & Journey's End",
          isLast: true,
        ),
      ],
    );
  }

  Widget _itineraryStep(String day, String desc, {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomPaint(painter: DottedLinePainter()),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// --- Booking Sidebar Card ---
class BookingSidebar extends StatelessWidget {
  const BookingSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "From THB 20,266 / pax",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _bookingOption("4 - 8 Feb 26", "THB 20,266", true),
          const SizedBox(height: 12),
          _bookingOption("4 - 8 Mar 26", "THB 20,266", true),
          const SizedBox(height: 12),
          _bookingOption(
            "19 - 23 Mar 26",
            "THB 21,458",
            false,
            isConfirmed: true,
          ),
        ],
      ),
    );
  }

  Widget _bookingOption(
    String date,
    String price,
    bool isNew, {
    bool isConfirmed = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isConfirmed ? Icons.check_circle : Icons.auto_awesome,
                    size: 14,
                    color: isConfirmed ? Colors.green : Colors.blue,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isConfirmed ? "CONFIRMED" : "NEW DATE",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isConfirmed ? Colors.green : Colors.blue,
                    ),
                  ),
                ],
              ),
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              date,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "61 interested",
                style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  color: Colors.grey,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Choose"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// --- Custom Painters & Helpers ---

class CircularStat extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;
  const CircularStat({
    super.key,
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CustomPaint(
            painter: CircleProgressPainter(percent: percent, color: color),
            child: Center(
              child: Icon(
                label == "Nature" ? Icons.landscape : Icons.beach_access,
                size: 20,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "${(percent * 100).toInt()}%",
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double percent;
  final Color color;
  CircleProgressPainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    Paint activePaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, bgPaint);
    double angle = 2 * math.pi * percent;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -math.pi / 2,
      angle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 2;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
