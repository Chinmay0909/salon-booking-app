import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_form_field.dart';
import '../models/user_type.dart';

class SalonRegistrationScreen extends StatefulWidget {
  const SalonRegistrationScreen({super.key});

  @override
  State<SalonRegistrationScreen> createState() => _SalonRegistrationScreenState();
}

class _SalonRegistrationScreenState extends State<SalonRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _salonNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _agreeToTerms = false;

  final List<String> _selectedServices = [];
  final List<String> _availableServices = [
    'Hair Cut & Styling',
    'Hair Coloring',
    'Facial Treatment',
    'Manicure & Pedicure',
    'Massage Therapy',
    'Eyebrow & Lash Services',
    'Bridal Makeup',
    'Hair Extensions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(
              title: 'Register Your Salon',
              subtitle: 'Join our platform and grow your business',
              userType: UserType.salon,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),

                    // Salon Information
                    Text(
                      'Salon Information',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryTeal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    AuthFormField(
                      label: 'Salon Name',
                      hint: 'Enter your salon name',
                      prefixIcon: Icons.store_outlined,
                      controller: _salonNameController,
                      validator: (value) => value?.isEmpty == true
                          ? 'Please enter salon name' : null,
                    ),
                    const SizedBox(height: 20),

                    AuthFormField(
                      label: 'Owner Name',
                      hint: 'Enter owner full name',
                      prefixIcon: Icons.person_outline,
                      controller: _ownerNameController,
                      validator: (value) => value?.isEmpty == true
                          ? 'Please enter owner name' : null,
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
                    const SizedBox(height: 32),

                    // Address Information
                    Text(
                      'Address Information',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryTeal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    AuthFormField(
                      label: 'Street Address',
                      hint: 'Enter salon address',
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
                    const SizedBox(height: 32),

                    // Services
                    Text(
                      'Services Offered',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryTeal,
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
                        children: _availableServices.map((service) {
                          final isSelected = _selectedServices.contains(service);
                          return FilterChip(
                            label: Text(service),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedServices.add(service);
                                } else {
                                  _selectedServices.remove(service);
                                }
                              });
                            },
                            selectedColor: AppColors.primaryTeal.withOpacity(0.3),
                            checkmarkColor: AppColors.primaryTeal,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Password
                    Text(
                      'Account Security',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primaryTeal,
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
                          activeColor: AppColors.primaryTeal,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _agreeToTerms = !_agreeToTerms);
                            },
                            child: const Text(
                              'I agree to the Terms of Service, Privacy Policy, and Business Agreement',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    CustomButton(
                      text: _isLoading ? 'Registering Salon...' : 'Register Salon',
                      onPressed: _isLoading ? () {} : _handleRegistration,
                      color: AppColors.primaryTeal,
                      height: 52,
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have a salon account? ',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        TextButton(
                          onPressed: () => context.go('/auth/salon/login'),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.primaryTeal,
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
    if (_selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one service'),
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

    // TODO: Implement actual salon registration logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Navigate to salon dashboard
    if (mounted) {
      context.go('/dashboard');
    }
  }
}

@override
void dispose() {
  _salonNameController.dispose();
  _ownerNameController.dispose();
  _emailController.dispose();
  _phoneController.dispose();
  _addressController.dispose();
  _cityController.dispose();
  _stateController.dispose();
  _zipCodeController.dispose();
  _passwordController.dispose();
  _confirmPasswordController.dispose();
  super.dispose();
}
}