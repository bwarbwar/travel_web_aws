import 'package:flutter/material.dart';

/// Avantour Checkout Screen
/// Replicates the Tailwind/HTML guided checkout experience.
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool privateTransfer = true;
  bool travelInsurance = false;
  int paymentMethodIndex = 0; // 0: Credit Card, 1: PayPal, 2: Klarna

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // background-light
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop
                ? MediaQuery.of(context).size.width * 0.1
                : 16.0,
            vertical: 32.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBreadcrumbs(),
              const SizedBox(height: 8),
              const Text(
                'Secure Checkout',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 32),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 8, child: _buildFormSections()),
                    const SizedBox(width: 48),
                    Expanded(flex: 4, child: _buildSummarySidebar()),
                  ],
                )
              else
                Column(
                  children: [
                    _buildFormSections(),
                    const SizedBox(height: 32),
                    _buildSummarySidebar(),
                  ],
                ),
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
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.flight_takeoff, color: Color(0xFF2196F3)),
          ),
          const SizedBox(width: 12),
          const Text(
            'Avantour',
            style: TextStyle(
              color: Color(0xFF111827),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.language, size: 20),
          label: const Text('EN / USD'),
          style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
        ),
        const VerticalDivider(indent: 15, endIndent: 15, width: 20),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.help_outline),
          label: const Text('Help'),
          style: TextButton.styleFrom(foregroundColor: Colors.black),
        ),
        const SizedBox(width: 16),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(color: Colors.grey.shade200, height: 1),
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return const Row(
      children: [
        Text('Home', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('/', style: TextStyle(color: Colors.grey)),
        ),
        Text('Sri Lanka', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('/', style: TextStyle(color: Colors.grey)),
        ),
        Text(
          'Checkout',
          style: TextStyle(
            color: Color(0xFF111827),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildFormSections() {
    return Column(
      children: [
        _buildStepCard(
          step: '1',
          title: 'Traveler Information',
          content: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'First Name',
                      initialValue: 'Alex',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Last Name',
                      initialValue: 'Morgan',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Email Address',
                initialValue: 'alex.morgan@example.com',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Phone Number',
                initialValue: '+1 (555) 012-3456',
              ),
              const SizedBox(height: 24),
              _buildInfoBox(
                'Your booking confirmation will be sent to this email address. Please ensure it is correct.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildStepCard(
          step: '2',
          title: 'Enhance your trip',
          isCompleted: false,
          content: Column(
            children: [
              _buildEnhancementTile(
                title: 'Private Airport Transfer',
                subtitle: 'Hassle-free pickup from CMB Airport to your hotel.',
                price: '+45',
                priceLabel: 'per group',
                value: privateTransfer,
                onChanged: (v) => setState(() => privateTransfer = v!),
              ),
              const SizedBox(height: 12),
              _buildEnhancementTile(
                title: 'Travel Insurance',
                subtitle: 'Comprehensive coverage for medical & cancellation.',
                price: '+62',
                priceLabel: 'per person',
                value: travelInsurance,
                onChanged: (v) => setState(() => travelInsurance = v!),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildPaymentStep(),
      ],
    );
  }

  Widget _buildStepCard({
    required String step,
    required String title,
    required Widget content,
    bool isCompleted = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isCompleted
                    ? const Color(0xFF2196F3)
                    : Colors.white,
                child: Text(
                  step,
                  style: TextStyle(
                    color: isCompleted ? Colors.white : const Color(0xFF2196F3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!isCompleted)
                // Border for incomplete step
                Transform.translate(
                  offset: const Offset(-40, 0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF2196F3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (isCompleted)
                TextButton(onPressed: () {}, child: const Text('Edit')),
            ],
          ),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2196F3).withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF2196F3),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Payment Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildPaymentTabs(),
          const SizedBox(height: 24),
          _buildTextField(
            label: 'Card Number',
            placeholder: '0000 0000 0000 0000',
            prefixIcon: Icons.credit_card,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Expiration Date',
                  placeholder: 'MM / YY',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'CVC',
                  placeholder: '123',
                  prefixIcon: Icons.lock_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Cardholder Name',
            placeholder: 'Name as on card',
          ),
          const SizedBox(height: 32),
          _buildPayButton(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.shield, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                'Secure Stripe Checkout',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTabs() {
    List<Map<String, dynamic>> methods = [
      {'icon': Icons.credit_card, 'label': 'Credit Card'},
      {'icon': Icons.account_balance_wallet, 'label': 'PayPal'},
      {'icon': Icons.payments, 'label': 'Klarna'},
    ];

    return Row(
      children: List.generate(methods.length, (index) {
        bool isSelected = paymentMethodIndex == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => paymentMethodIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? const Color(0xFF2196F3)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    methods[index]['icon'],
                    size: 18,
                    color: isSelected ? const Color(0xFF2196F3) : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    methods[index]['label'],
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? const Color(0xFF2196F3) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSummarySidebar() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
            ],
          ),

          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1546708973-b339540b5162?q=80&w=1000&auto=format&fit=crop',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 12,
                    left: 16,
                    child: Text(
                      '5 DAYS / 4 NIGHTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shopping Cart',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Sri Lankan Express: Soul Searching in Paradise',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSummaryRow(
                      Icons.calendar_month,
                      'Feb 04 - Feb 08, 2026',
                      'Wednesday to Sunday',
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow(Icons.group, '2 Travelers', '2 Adults'),
                    const Divider(height: 40, thickness: 1),
                    _buildPriceRow('Standard Package (x2)', '\$1,200.00'),
                    _buildPriceRow('Private Airport Transfer', '\$45.00'),
                    _buildPriceRow('Taxes & Fees', '\$80.00'),
                    _buildPriceRow(
                      'Early Bird Discount',
                      '-\$100.00',
                      isDiscount: true,
                    ),
                    const Divider(height: 40, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '\$1,225.00',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                            Text(
                              'Including all taxes',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSupportCard(),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildTextField({
    required String label,
    String? initialValue,
    String? placeholder,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.grey)
                : null,
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancementTile({
    required String title,
    required String subtitle,
    required String price,
    required String priceLabel,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? const Color(0xFF2196F3) : Colors.grey.shade200,
        ),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF2196F3),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        secondary: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              priceLabel,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDiscount ? Colors.green : Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: const Text('Edit', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildInfoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF2196F3), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Color(0xFF111827)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: const Color(0xFF2196F3).withOpacity(0.5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pay US\$ 1,325.00',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text.rich(
          TextSpan(
            text: 'By clicking "Pay", you agree to Avantour\'s ',
            children: [
              TextSpan(
                text: 'Terms of Service',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSupportCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.support_agent, color: Color(0xFF2196F3)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need help booking?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Text(
                  'Call our customer service team 24/7 to speak with a travel expert.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  '+1 (800) 123-4567',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.bold,
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
