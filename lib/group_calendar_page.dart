import 'package:flutter/material.dart';

class GroupCalendarPage extends StatelessWidget {
  const GroupCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Group Travel Calendar",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Confirmed departures for 2026",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Track every confirmed group tour, departure city, and available slots.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: isWide ? _buildWideTable() : _buildCardList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: const [
                _CalendarRow(
                  tour: "Sri Lankan Express",
                  date: "Feb 04 - Feb 08, 2026",
                  city: "Colombo",
                  status: "Confirmed - 4 slots left",
                ),
                _CalendarRow(
                  tour: "Mongolia Winter Adventure",
                  date: "Mar 12 - Mar 21, 2026",
                  city: "Ulaanbaatar",
                  status: "Confirmed - 6 slots left",
                ),
                _CalendarRow(
                  tour: "Turkey Grand Adventure",
                  date: "Apr 03 - Apr 12, 2026",
                  city: "Istanbul",
                  status: "Confirmed - 8 slots left",
                ),
                _CalendarRow(
                  tour: "Southern Italy: Amalfi Coast",
                  date: "Apr 26 - May 02, 2026",
                  city: "Naples",
                  status: "Confirmed - 2 slots left",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              "Tour",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Dates",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Start city",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Availability",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardList() {
    return ListView(
      children: const [
        _CalendarCard(
          tour: "Sri Lankan Express",
          date: "Feb 04 - Feb 08, 2026",
          city: "Colombo",
          status: "Confirmed - 4 slots left",
        ),
        _CalendarCard(
          tour: "Mongolia Winter Adventure",
          date: "Mar 12 - Mar 21, 2026",
          city: "Ulaanbaatar",
          status: "Confirmed - 6 slots left",
        ),
        _CalendarCard(
          tour: "Turkey Grand Adventure",
          date: "Apr 03 - Apr 12, 2026",
          city: "Istanbul",
          status: "Confirmed - 8 slots left",
        ),
        _CalendarCard(
          tour: "Southern Italy: Amalfi Coast",
          date: "Apr 26 - May 02, 2026",
          city: "Naples",
          status: "Confirmed - 2 slots left",
        ),
      ],
    );
  }
}

class _CalendarRow extends StatelessWidget {
  final String tour;
  final String date;
  final String city;
  final String status;

  const _CalendarRow({
    required this.tour,
    required this.date,
    required this.city,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(tour)),
          Expanded(flex: 2, child: Text(date)),
          Expanded(flex: 2, child: Text(city)),
          Expanded(
            flex: 2,
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  final String tour;
  final String date;
  final String city;
  final String status;

  const _CalendarCard({
    required this.tour,
    required this.date,
    required this.city,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tour,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _infoRow(Icons.calendar_month, date),
          const SizedBox(height: 6),
          _infoRow(Icons.place_outlined, "Starts from $city"),
          const SizedBox(height: 6),
          _infoRow(Icons.event_available, status, isAccent: true),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, {bool isAccent = false}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isAccent ? Colors.green : Colors.grey),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: isAccent ? Colors.green : Colors.grey.shade700,
            fontWeight: isAccent ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
