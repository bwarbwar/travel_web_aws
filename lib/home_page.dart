import 'package:avantour/widget/filter_popup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      drawer: isMobile ? const Sidebar() : null,
      body: Row(
        children: [
          if (!isMobile) const Sidebar(),
          Expanded(child: MainContent(showMenuButton: isMobile)),
        ],
      ),
    );
  }
}

/// --- Sidebar Navigation ---
class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
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
          ),

          // Navigation
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _navItem(Icons.explore, "Explore", isActive: true),
                _navItem(
                  Icons.business_center_outlined,
                  "Private & Corporate",
                  onTap: () {
                    Navigator.of(context).pushNamed('/private-corporate');
                  },
                ),
                _navItem(
                  Icons.group_add_outlined,
                  "Group Calendar",
                  onTap: () {
                    Navigator.of(context).pushNamed('/group-calendar');
                  },
                ),


              ],
            ),
          ),

          // User Profile
          const Divider(),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://framerusercontent.com/images/GA6RDdI7XSzpVUFLXsQaHuBS0Qo.jpg',
              ),
            ),
            title: const Text(
              "Tom Cook",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              "View Profile",
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label, {
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF0EA5E9).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? const Color(0xFF0EA5E9) : Colors.grey.shade600,
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF0EA5E9) : Colors.grey.shade700,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        dense: true,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: onTap,
      ),
    );
  }
}

/// --- Main Content Area ---
class MainContent extends StatelessWidget {
  final bool showMenuButton;
  const MainContent({super.key, required this.showMenuButton});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.8),
          surfaceTintColor: Colors.transparent,
          leading: showMenuButton
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )
              : null,
          title: Row(
            children: [
              if (!showMenuButton)
                const Text(
                  "Discover",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              const Spacer(),
              // Search Bar (Simplified for mobile)
              if (MediaQuery.of(context).size.width > 600)
                GestureDetector(
                  onTap: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => const DestinationFilterPopup(),
                    );

                    if (result != null) {
                      debugPrint('Selected destinations: ${result['destinations']}');
                      debugPrint('Selected months: ${result['months']}');
                      // Apply your filters here
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Anywhere", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                        const VerticalDivider(),
                        const Text("Any week", style: TextStyle(fontSize: 13, color: Colors.grey)),
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(Icons.search, size: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Badge(child: Icon(Icons.notifications_none)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ChoiceChip(label: Text("EN"), selected: true),
            ),
          ],
        ),

        // Body Content
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionHeader("Recommended for You", hasSparkle: true),
              const SizedBox(height: 16),
              _buildRecommendedGrid(context),
              const SizedBox(height: 40),
              _buildSectionHeader("Group Travel Calendar", showViewAll: true),
              const SizedBox(height: 16),
              _buildGroupCalendarPreview(context),
              const SizedBox(height: 48),
              _buildSectionHeader("Explore by Theme", showViewAll: true),
              const SizedBox(height: 16),
              _buildThemeGrid(context),
              const SizedBox(height: 48),
              _buildSectionHeader("Trending Today", hasFire: true),
              const SizedBox(height: 16),
              _buildTrendingRow(context),
              const SizedBox(height: 40),
              _buildSectionHeader(
                "Private & Corporate Travel",
                showViewAll: true,
              ),
              const SizedBox(height: 16),
              _buildPrivateCorporateBanner(context),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    String title, {
    bool hasSparkle = false,
    bool hasFire = false,
    bool showViewAll = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        if (hasSparkle)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.auto_awesome, color: Color(0xFF0EA5E9)),
          ),
        if (hasFire)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.local_fire_department, color: Colors.red),
          ),
        const Spacer(),
        if (showViewAll)
          TextButton(onPressed: () {}, child: const Text("View all themes")),
      ],
    );
  }

  Widget _buildRecommendedGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 1000
            ? 4
            : (constraints.maxWidth > 600 ? 2 : 1);
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 0.75,
          children: const [
            TravelCard(
              location: "Sri Lanka",
              title: "Sri Lankan Express: Soul Searching",
              date: "4 - 8 Feb 26",
              price: "THB 20,266",
              oldPrice: "THB 28,373",
              imageUrl:
                  "https://storage.googleapis.com/stateless-www-justwravel-com/2024/10/58174284-reasons-to-visit-sri-lanka.png",
              tag: "Beginner friendly",
            ),
            TravelCard(
              location: "Mongolia",
              title: "Mongolia Winter Adventure",
              date: "3 - 12 Mar 26",
              price: "THB 109,237",
              oldPrice: "THB 152,932",
              imageUrl:
                  "https://framerusercontent.com/images/tAfL9UYQTolOtRVwFsv0i2pLTto.jpg",
            ),
            TravelCard(
              location: "Turkey",
              title: "Turkey Grand Adventure",
              date: "3 - 12 Apr 26",
              price: "THB 74,392",
              oldPrice: "THB 104,149",
              imageUrl:
                  "https://cdn-gaecj.nitrocdn.com/JMwuRIbFKRytZpZBQQGkRvqmTfGyKhHA/assets/images/optimized/rev-3745045/turkeytravelplanner.com/wp-content/uploads/2023/12/konya-mevlana.jpg",
            ),
            TravelCard(
              location: "Italy",
              title: "Southern Italy: Amalfi Coast",
              date: "26 Apr - 2 May 26",
              price: "THB 54,653",
              oldPrice: "THB 76,515",
              imageUrl:
                  "https://images.travelandleisureasia.com/wp-content/uploads/sites/6/2024/03/18182544/venice.jpeg",
              isWaitlist: true,
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      childAspectRatio: 2.2,
      children: const [
        ThemeCard(
          title: "Tropical Getaways",
          subtitle:
              "Discover the pristine beaches of Maldives, Bali, and more.",
          imageUrl:
              "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80",
          isTrending: true,
        ),
        ThemeCard(
          title: "Mountain Expeditions",
          subtitle: "Conquer the peaks. From the Alps to the Himalayas.",
          imageUrl:
              "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80",
        ),
      ],
    );
  }

  Widget _buildTrendingRow(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = constraints.maxWidth > 900
            ? 3
            : (constraints.maxWidth > 600 ? 2 : 1);
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: count,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 1.2,
          children: const [
            DealCard(
              title: "Japan: Sakura Season",
              status: "Last 2 spots",
              date: "Ends in 2 days",
              imageUrl:
                  "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=400&q=80",
            ),
            DealCard(
              title: "Morocco: Desert Nights",
              status: "\$180 OFF",
              date: "Ends 18 Jan",
              imageUrl:
                  "https://images.unsplash.com/photo-1489749798305-4fea3ae63d43?auto=format&fit=crop&w=400&q=80",
            ),
            DealCard(
              title: "Swiss Alps: Peak Hiking",
              status: "\$199 OFF",
              date: "Ends 8 Jan",
              imageUrl:
                  "https://res.klook.com/image/upload/fl_lossy.progressive,q_85/c_fill,w_680/v1663225108/blog/arh6isb8hkos0nmvlnnz.jpg",
            ),
          ],
        );
      },
    );
  }

  Widget _buildGroupCalendarPreview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Confirmed 2026 departures",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Browse every confirmed group tour in one calendar.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _CalendarChip(label: "Sri Lanka • Feb 04"),
              _CalendarChip(label: "Turkey • Apr 03"),
              _CalendarChip(label: "Mongolia • Mar 12"),
              _CalendarChip(label: "Italy • Apr 26"),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/group-calendar');
              },
              icon: const Icon(Icons.calendar_month),
              label: const Text("Open Group Travel Calendar"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivateCorporateBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [const Color(0xFF0EA5E9), const Color(0xFF38BDF8)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Luxury, Incentives & MICE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Plan private journeys, executive retreats, and corporate incentives with a dedicated concierge.",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/private-corporate');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0EA5E9),
            ),
            child: const Text("Start a Private & Corporate Request"),
          ),
        ],
      ),
    );
  }
}

class _CalendarChip extends StatelessWidget {
  final String label;
  const _CalendarChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0EA5E9).withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// --- Reusable Components ---

class TravelCard extends StatelessWidget {
  final String location, title, date, price, oldPrice, imageUrl;
  final String? tag;
  final bool isWaitlist;

  const TravelCard({
    super.key,
    required this.location,
    required this.title,
    required this.date,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
    this.tag,
    this.isWaitlist = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  radius: 16,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                    size: 16,
                  ),
                ),
              ),
              if (tag != null)
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (isWaitlist)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "WAITLIST",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "$location • $date",
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              oldPrice,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              price,
              style: const TextStyle(
                color: Color(0xFF0EA5E9),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              " / pax",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

class ThemeCard extends StatelessWidget {
  final String title, subtitle, imageUrl;
  final bool isTrending;
  const ThemeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isTrending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isTrending)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0EA5E9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "TRENDING",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class DealCard extends StatelessWidget {
  final String title, status, date, imageUrl;
  const DealCard({
    super.key,
    required this.title,
    required this.status,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: status.contains('\$') ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFF0EA5E9).withOpacity(0.1),
                      side: BorderSide.none,
                    ),
                    child: const Text("View Deal"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
