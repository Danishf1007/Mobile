import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _investedAmountController = TextEditingController();
  final _annualRateController = TextEditingController();
  final _monthsController = TextEditingController();

  // State variables for detailed results
  String _monthlyDividendResult = "";
  String _totalDividendResult = "";
  String _totalReturnResult = "";
  String _calculationErrorMessage = "";
  int _currentMonthsForProgress = 0;
  int _calculatedMonths = 0;

  @override
  void dispose() {
    _investedAmountController.dispose();
    _annualRateController.dispose();
    _monthsController.dispose();
    super.dispose();
  }

  void _calculateDividend() {

    if (_formKey.currentState!.validate()) {
      final double investedAmount =
          double.tryParse(_investedAmountController.text) ?? 0.0;
      final double annualRate =
          double.tryParse(_annualRateController.text) ?? 0.0;
      final int months = int.tryParse(_monthsController.text) ?? 0;

      if (investedAmount <= 0 || annualRate <= 0 || months <= 0) {
        setState(() {
          _calculationErrorMessage = "Please enter valid positive values for all fields.";
          _monthlyDividendResult = "";
          _totalDividendResult = "";
          _totalReturnResult = "";
          _calculatedMonths = 0;
        });
        return;
      }

      final double monthlyRateDecimal = (annualRate / 100) / 12;
      final double monthlyDividend = monthlyRateDecimal * investedAmount;
      final double totalDividend = monthlyDividend * months;
      final double totalReturn = investedAmount + totalDividend;

      setState(() {
        _calculationErrorMessage = "";
        _monthlyDividendResult = monthlyDividend.toStringAsFixed(2);
        _totalDividendResult = totalDividend.toStringAsFixed(2);
        _totalReturnResult = totalReturn.toStringAsFixed(2);
        _calculatedMonths = months;
      });
    } else {
      setState(() {
        _calculationErrorMessage = "Please correct the errors above.";
        _monthlyDividendResult = "";
        _totalDividendResult = "";
        _totalReturnResult = "";
        _calculatedMonths = 0;
      });
    }
  }

  void _clearFields() {

    _formKey.currentState?.reset();
    _investedAmountController.clear();
    _annualRateController.clear();
    _monthsController.clear();
    setState(() {
      _monthlyDividendResult = "";
      _totalDividendResult = "";
      _totalReturnResult = "";
      _calculationErrorMessage = "";
      _currentMonthsForProgress = 0;
      _calculatedMonths = 0;
    });
  }


  Widget _buildResultRow(String label, String value, BuildContext context, {bool isCurrency = true}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.75),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isCurrency ? 'RM${value}' : value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text('Dividend Calculator'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0), 
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.insights_rounded,
                  size: 50,
                  color: theme.colorScheme.primary.withOpacity(0.8),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dividend Calculator',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _investedAmountController,
                  decoration: InputDecoration(
                    labelText: 'Invested Fund Amount',
                    // UPDATED: Using Text for RM prefix
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      child: Text(
                        'RM',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.inputDecorationTheme.prefixIconColor ?? theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
                    hintText: '1000.00',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter invested amount';
                    }
                    if (double.tryParse(value) == null || double.parse(value) <= 0) {
                      return 'Please enter a valid positive amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _annualRateController,
                  decoration: const InputDecoration(
                    labelText: 'Annual Dividend Rate (%)',
                    prefixIcon: Icon(Icons.percent_outlined),
                    hintText: '5.5',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter annual rate';
                    }
                    if (double.tryParse(value) == null || double.parse(value) <= 0) {
                      return 'Please enter a valid positive rate';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _monthsController,
                  decoration: const InputDecoration(
                    labelText: 'Number of Months Invested (Max 12)',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    hintText: ' 4',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    final int? months = int.tryParse(value);
                    setState(() {
                      _currentMonthsForProgress = (months != null && months >= 0 && months <= 12) ? months : 0;
                      if (months != null && (months < 0 || months > 12)) {
                        _currentMonthsForProgress = _monthsController.text.length == 1 ? months : (months > 12 ? 12 : 0) ;
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() => _currentMonthsForProgress = 0);
                      return 'Please enter number of months';
                    }
                    final int? months = int.tryParse(value);
                    if (months == null || months <= 0 || months > 12) {
                      return 'Months must be between 1 and 12';
                    }
                    return null;
                  },
                ),
                if (_currentMonthsForProgress > 0 || _monthsController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
                    child: LinearProgressIndicator(
                      value: _monthsController.text.isEmpty ? 0 : (_currentMonthsForProgress / 12.0).clamp(0.0, 1.0),
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.clear_all_rounded),
                        onPressed: _clearFields,
                        label: const Text('Clear'),
                        // UPDATED: Specific style for Clear button
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8F00),
                          foregroundColor: Colors.white,
                          // Shape and padding will be inherited from elevatedButtonTheme in main.dart
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Increased spacing between buttons
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.calculate_rounded),
                        onPressed: _calculateDividend,
                        label: const Text('Calculate'),
                        // This button will use the default elevatedButtonTheme from main.dart
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                if (_calculationErrorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _calculationErrorMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                // Result Card will use cardTheme from main.dart
                if (_totalDividendResult.isNotEmpty && _calculationErrorMessage.isEmpty)
                  Card(
                    // elevation will be from cardTheme
                    // shape will be from cardTheme
                    // margin will be from cardTheme
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Calculation Results',
                            style: theme.textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Divider(color: theme.dividerTheme.color, thickness: theme.dividerTheme.thickness),
                          const SizedBox(height: 4),
                          _buildResultRow("📅 Monthly Dividend:", _monthlyDividendResult, context),
                          _buildResultRow("💰 Total Dividend (for $_calculatedMonths months):", _totalDividendResult, context),
                          Divider(height: 24, thickness: theme.dividerTheme.thickness, color: theme.dividerTheme.color),
                          _buildResultRow("📈 Total Return (Principal + Dividend):", _totalReturnResult, context),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                Text(
                  'Note: This is a simple dividend calculation and does not account for dividend reinvestment, taxes, brokerage fees, or potential changes in dividend rates.',
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}