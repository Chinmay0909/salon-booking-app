import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_form_field.dart';
import '../models/user_type.dart';

class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});

  @override
  State<SellerRegistrationScreen> createState() => _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _taxIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _agreeToTerms = false;

  String _selectedBusinessType = 'Retailer';
  final List<String> _businessTypes = [
    'Retailer',
    'Wholesaler',
    'Manufacturer',
    'Distributor',
    'Online Store',
    'Marketplace Seller',
  ];

  final List<String> _selectedCategories = [];
  final List<String> _productCategories = [
    'Electronics',
    'Clothing & Fashion',
    'Home & Garden',
    'Beauty & Personal Care',
    'Sports & Outdoors',
    'Books & Media',
    'Toys & Games',
    'Automotive',
    'Health & Wellness',
    'Food & Beverages',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(
              title: 'Register Your Business',
              subtitle: 'Start selling on our platform today',
              userType: UserType.seller,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),

                    // Business Information
                    Text(
                      'Business Information',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryYellow.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    AuthFormField(
                      label: 'Business Name',
                      hint: 'Enter your business name',
                      prefixIcon: Icons.business_outlined,
                      controller: _businessNameController,
                      validator: (value) => value?.isEmpty == true
                          ? 'Please enter business name' : null,
                    ),
                    const SizedBox(height: 20),

                    AuthFormField(
                      label: 'Contact Person Name',
                      hint: 'Enter contact person name',
                      prefixIcon: Icons.person_outline,
                      controller: _contactPersonController,
                      validator: (value) => value?.isEmpty == true
                          ? 'Please enter contact person name' : null,
                    ),
                    const SizedBox(height: 20),

                    AuthFormField(
                      label: 'Business Email',
                      hint: 'Enter business email',
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 20),

                    AuthFormField(
                      label: 'Phone Number',
                      hint: 'Enter business phone',
                      prefixIcon: Icons.phone_outlined,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    const SizedBox(height: 20),

                    // Business Type Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Type',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedBusinessType,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.category_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: AppColors.surface,
                          ),
                          items: _businessTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedBusinessType = value!);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Address Information
                    Text(
                      'Business Address',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryYellow.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    AuthFormField(
                      label: 'Street Address',
                      hint: 'Enter business address',
                      prefixIcon: Icons.location_on_outlined,
                      controller: _addressController,
                      validator: (value) => value?.isEmpty == true
                          ? 'Please enter address' : null,
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AuthFormField(
                            label: 'City',
                            hint: 'Enter city',
                            controller: _cityController,
                            validator: (value) => value?.isEmpty == true
                                ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AuthFormField(
                            label: 'State',
                            hint: 'State',
                            controller: _stateController,
                            validator: (value) => value?.isEmpty == true
                                ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AuthFormField(
                            label: 'ZIP Code',
                            hint: 'ZIP',
                            controller: _zipCodeController,
                            keyboardType: TextInputType.number,
                            validator: (value) => value?.isEmpty == true
                                ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    AuthFormField(
                      label: 'Tax ID (Optional)',
                      hint: 'Enter tax identification number',
                      prefixIcon: Icons.receipt_outlined,
                      controller: _taxIdController,
                    ),
                    const SizedBox(height: 32),

                    // Product Categories
                    Text(
                      'Product Categories',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryYellow.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.textLight),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _productCategories.map((category) {
                          final isSelected = _selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedCategories.add(category);
                                } else {
                                  _selectedCategories.remove(category);
                                }
                              });
                            },
                            selectedColor: AppColors.primaryYellow.withOpacity(0.3),
                            checkmarkColor: AppColors.textPrimary,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Password
                    Text(
                      'Account Security',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryYellow.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    AuthFormField(
                      label: 'Password',
                      hint: 'Create a strong password',
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 20),

                    AuthFormField(
                      label: 'Confirm Password',
                      hint: 'Confirm your password',
                      prefixIcon: Icons.lock_outline,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() => _agreeToTerms = value ?? false);
                          },
                          activeColor: AppColors.primaryYellow.withOpacity(0.8),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _agreeToTerms = !_agreeToTerms);
                            },
                            child: const Text(
                              'I agree to the Terms of Service, Privacy Policy, and Seller Agreement',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    CustomButton(
                      text: _isLoading ? 'Registering Business...' : 'Register Business',
                      onPressed: _isLoading ? () {} : _handleRegistration,
                      color: AppColors.primaryYellow,
                      textColor: AppColors.textPrimary,
                      height: 52,
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have a seller account? ',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        TextButton(
                          onPressed: () => context.go('/auth/seller/login'),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.primaryYellow.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                            ),
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
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter business email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
    }
  return null;
}

String? _validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter phone number';
  }
  if (value.length < 10) {
    return 'Please enter a valid phone number';
  }
  return null;
}

String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
    return 'Password must contain uppercase, lowercase and number';
  }
  return null;
}

String? _validateConfirmPassword(String? value) {
  if (value != _passwordController.text) {
    return 'Passwords do not match';
  }
  return null;
}

void _handleRegistration() async {
  if (_formKey.currentState!.validate()) {
    if (_selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one product category'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // TODO: Implement actual seller registration logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Navigate to seller dashboard
    if (mounted) {
      context.go('/dashboard');
    }
  }
}

@override
void dispose() {
  _businessNameController.dispose();
  _contactPersonController.dispose();
  _emailController.dispose();
  _phoneController.dispose();
  _addressController.dispose();
  _cityController.dispose();
  _stateController.dispose();
  _zipCodeController.dispose();
  _taxIdController.dispose();
  _passwordController.dispose();
  _confirmPasswordController.dispose();
  super.dispose();
}
}