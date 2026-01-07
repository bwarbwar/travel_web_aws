import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DestinationFilterPopup extends StatefulWidget {
  const DestinationFilterPopup({super.key});

  @override
  State<DestinationFilterPopup> createState() => _DestinationFilterPopupState();
}

class _DestinationFilterPopupState extends State<DestinationFilterPopup> {
  final Set<String> _selectedDestinations = {};
  final Set<int> _selectedMonths = {};

  final List<Map<String, String>> destinations = [
    {'name': 'Mongolia', 'asset': 'https://framerusercontent.com/images/gsl61i2RbGcg7JQIyOCEHnT4fSg.jpg'},
    {'name': 'Indonesia', 'asset': 'https://framerusercontent.com/images/EfQR0YSHNRjgQMCKGZboApMMV1M.jpg'},
    {'name': 'China', 'asset': 'https://framerusercontent.com/images/zq9GT6wt1Rd72jT7e1qRUqpRbnQ.jpg'},
    {'name': 'Africa', 'asset': 'https://framerusercontent.com/images/0BLEJuIdPe4UQEPWnVqp4iPco.jpg'},
    {'name': 'Japan', 'asset': 'https://framerusercontent.com/images/QrxL14qIeiuAR4eFv0pWPlfi34.jpg'},
    {'name': 'Nepal', 'asset': 'https://framerusercontent.com/images/pAmHaERhy7eKdOWjgIne8PEyuuA.jpg'},
  ];

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width > 600 ? 480 : double.infinity,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Search
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Search trips, destinations, activities',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Popular Destinations
              const Text(
                'Popular destinations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final dest = destinations[index];
                  final isSelected = _selectedDestinations.contains(dest['name']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedDestinations.remove(dest['name']);
                        } else {
                          _selectedDestinations.add(dest['name']!);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: dest['asset']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        if (isSelected)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Icon(Icons.check_circle, color: Colors.white, size: 36),
                            ),
                          ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Text(
                            dest['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Dates
              const Text(
                'Dates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(months.length, (index) {
                  final isSelected = _selectedMonths.contains(index);
                  return FilterChip(
                    label: Text(months[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedMonths.add(index);
                        } else {
                          _selectedMonths.remove(index);
                        }
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    checkmarkColor: Colors.white,
                    backgroundColor: Colors.grey.shade100,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),

              // Filter Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Apply filters here
                    // You can pass back selected destinations and months
                    Navigator.of(context).pop({
                      'destinations': _selectedDestinations.toList(),
                      'months': _selectedMonths.map((i) => months[i]).toList(),
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Filter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
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
