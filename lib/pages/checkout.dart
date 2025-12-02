import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/pages/payment_detail_page.dart';
import 'package:intl/intl.dart';

// ===================== ASSET PATH =====================
const String _mandiriLogo = 'assets/payment/mandiri.jpg';
const String _qrisLogo = 'assets/payment/qris.jpg';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // ===================== STATE & VARIABLES =====================
  List<bool> _itemProtectionStatus = [];

  static const double _protectionPrice = 8000.0;
  double _totalProtectionCost = 0.0;

  static const double _regulerPrice = 5000.0;
  static const double _sameDayPrice = 15000.0;

  String _selectedShipping = 'Reguler';
  late double _selectedShippingCost;

  String _selectedPayment = 'Mandiri';

  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _itemProtectionStatus = List<bool>.filled(widget.cartItems.length, false);
    _selectedShippingCost = _regulerPrice;
    _totalProtectionCost = 0.0;
  }

  // ===================== UPDATE TOTAL PROTEKSI =====================
  void _updateProtectionCost() {
    double newProtectionTotal = 0.0;
    for (int i = 0; i < _itemProtectionStatus.length; i++) {
      if (_itemProtectionStatus[i]) newProtectionTotal += _protectionPrice;
    }
    _totalProtectionCost = newProtectionTotal;
  }

  @override
  Widget build(BuildContext context) {
    double currentTotal =
        widget.subtotal +
        _selectedShippingCost +
        _totalProtectionCost +
        widget.tax;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddressSection(),
              const SizedBox(height: 16),
              _buildItemSections(),
              const SizedBox(height: 16),
              _buildShippingOptions(),
              const SizedBox(height: 16),
              _buildShippingMessage(),
              const SizedBox(height: 16),
              _buildSubtotal(widget.subtotal),
              const SizedBox(height: 16),
              _buildPaymentMethods(),
              const SizedBox(height: 16),
              _buildPaymentSummary(
                subtotal: widget.subtotal,
                shipping: _selectedShippingCost,
                protection: _totalProtectionCost,
                tax: widget.tax,
                total: currentTotal,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(currentTotal),
    );
  }

  // ===================== APP BAR =====================
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: kBlackColor, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Checkout',
        style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // ===================== ADDRESS SECTION =====================
  Widget _buildAddressSection() {
    return _buildSectionCard(
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: kPrimaryColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ucup Markucup   (+62)89527819301',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: kBlackColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Jl. Sunny Ville No.5, Tangerang Selatan, Kel. Bu...',
                  style: TextStyle(color: kGreyColor, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, color: kGreyColor, size: 16),
        ],
      ),
    );
  }

  // ===================== ITEM LIST =====================
  Widget _buildItemSections() {
    return Column(
      children: widget.cartItems.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> item = entry.value;

        return _buildSingleItem(
          index: index,
          image: item['image'],
          name: item['name'],
          price: (item['price'] as num).toDouble(),
          quantity: item['quantity'],
        );
      }).toList(),
    );
  }

  // ===================== SINGLE ITEM =====================
  Widget _buildSingleItem({
    required int index,
    required String image,
    required String name,
    required double price,
    required int quantity,
  }) {
    return _buildSectionCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: kBackgroundColor,
                    child: Icon(Icons.image_not_supported, color: kGreyColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatCurrency.format(price),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'x$quantity',
                style: TextStyle(fontSize: 14, color: kGreyColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => setState(() {
              _itemProtectionStatus[index] = !_itemProtectionStatus[index];
              _updateProtectionCost();
            }),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kPrimaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _itemProtectionStatus[index],
                    onChanged: (val) {
                      setState(() {
                        _itemProtectionStatus[index] = val ?? false;
                        _updateProtectionCost();
                      });
                    },
                    activeColor: kPrimaryColor,
                    visualDensity: VisualDensity.compact,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Proteksi Barang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: kBlackColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Melindungi barang anda dari kerusakan...',
                          style: TextStyle(color: kGreyColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatCurrency.format(_protectionPrice),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===================== SHIPPING OPTIONS =====================
  Widget _buildShippingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Opsi Pengiriman'),
        const SizedBox(height: 5),
        Column(
          children: [
            _buildShippingOption(
              title: 'Reguler',
              date: 'Garansi Tiba 20 - 27 Nov 2025',
              voucher:
                  'Bonus Voucher jika pesanan belum diterima hingga 27 Nov 2025.',
              price: _regulerPrice,
              value: 'Reguler',
            ),
            const SizedBox(height: 8),
            _buildShippingOption(
              title: 'Same Day',
              date: 'Garansi tiba hari ini dengan Same Day',
              price: _sameDayPrice,
              value: 'Same Day',
            ),
          ],
        ),
      ],
    );
  }

  // ===================== SHIPPING ITEM =====================
  Widget _buildShippingOption({
    required String title,
    required String date,
    String? voucher,
    required double price,
    required String value,
  }) {
    bool isSelected = _selectedShipping == value;

    return GestureDetector(
      onTap: () => setState(() {
        _selectedShipping = value;
        _selectedShippingCost = price;
      }),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF4CAF50) : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Text(
                  formatCurrency.format(price),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(date, style: TextStyle(fontSize: 12.5)),
            if (voucher != null && isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  voucher,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ===================== MESSAGE TO SELLER =====================
  Widget _buildShippingMessage() {
    return _buildSectionCard(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Pesan untuk pengirim',
              style: TextStyle(fontSize: 14, color: kBlackColor),
            ),
          ),
          Text(
            'Kirim pesan',
            style: TextStyle(fontSize: 13, color: kGreyColor.withValues(alpha: 0.8)),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_forward_ios,
            color: kGreyColor.withValues(alpha: 0.6),
            size: 14,
          ),
        ],
      ),
    );
  }

  // ===================== SUBTOTAL =====================
  Widget _buildSubtotal(double subtotal) {
    return _buildSectionCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subtotal',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            formatCurrency.format(subtotal),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ===================== PAYMENT METHODS =====================
  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Metode Pembayaran'),
        _buildSectionCard(
          child: Column(
            children: [
              _buildPaymentOption('Mandiri m-banking', _mandiriLogo, 'Mandiri'),
              const Divider(height: 18),
              _buildPaymentOption('QRIS', _qrisLogo, 'QRIS'),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== PAYMENT OPTION =====================
  Widget _buildPaymentOption(String name, String logoAsset, String value) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = value),
      child: Row(
        children: [
          Image.asset(
            logoAsset,
            width: 40,
            height: 25,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              width: 40,
              height: 25,
              color: Colors.grey[200],
              child: Icon(Icons.image),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 14, color: kBlackColor),
            ),
          ),
          Radio<String>(
            value: value,
            groupValue: _selectedPayment,
            onChanged: (val) => setState(() => _selectedPayment = val!),
            activeColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }

  // ===================== PAYMENT SUMMARY =====================
  Widget _buildPaymentSummary({
    required double subtotal,
    required double shipping,
    required double protection,
    required double tax,
    required double total,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Rincian Pembayaran'),
        _buildSectionCard(
          child: Column(
            children: [
              _buildSummaryLine(
                'Subtotal pesanan',
                formatCurrency.format(subtotal),
              ),
              _buildSummaryLine(
                'Proteksi Barang',
                formatCurrency.format(protection),
              ),
              _buildSummaryLine(
                'Ongkos Pengiriman',
                formatCurrency.format(shipping),
              ),
              _buildSummaryLine('Pajak (15%)', formatCurrency.format(tax)),
              const Divider(height: 24),
              _buildSummaryLine(
                'Total Pembayaran',
                formatCurrency.format(total),
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== RINCIAN PAYMENT LINE =====================
  Widget _buildSummaryLine(
    String label,
    String amount, {
    bool isTotal = false,
  }) {
    final style = TextStyle(
      fontSize: isTotal ? 16 : 14,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      color: isTotal ? kPrimaryColor : kBlackColor,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount, style: style),
        ],
      ),
    );
  }

  // ===================== BOTTOM BUTTON =====================
  Widget _buildBottomButton(double currentTotal) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                formatCurrency.format(currentTotal),
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // ===== UPDATE NAVIGASI DI SINI =====
                // Arahkan ke PaymentDetailPage (Halaman Menunggu Pembayaran)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentDetailPage(
                      totalAmount: currentTotal,
                      paymentMethod:
                          _selectedPayment, // Mengambil variable state _selectedPayment
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Konfirmasi Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===================== REUSABLE CARD & HEADER =====================
  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGreyColor.withValues(alpha: 0.2), width: 0.5),
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12.0,
        top: 8.0,
        left: 4.0,
        right: 4.0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
