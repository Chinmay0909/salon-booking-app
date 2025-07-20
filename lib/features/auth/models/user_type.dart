enum UserType {
  user('User', 'Beauty Enthusiast'),
  salon('Salon', 'Beauty Salon Partner'),
  seller('Seller', 'Beauty Product Vendor');

  const UserType(this.title, this.description);
  final String title;
  final String description;
}