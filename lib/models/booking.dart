enum BookingStatus {
  upcoming,
  completed,
  cancelled,
  noShow,
  rescheduled,
}

class Booking {
  final String id;
  final String userId;
  final String shopId;
  final String shopName;
  final String? specialistId;
  final String? specialistName;
  final String serviceName;
  final String serviceDescription;
  final DateTime scheduledDateTime;
  final Duration estimatedDuration;
  final double price;
  final BookingStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? cancellationReason;
  final String? rescheduleReason;
  final DateTime? originalDateTime;
  final Map<String, dynamic>? additionalData;

  const Booking({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.shopName,
    this.specialistId,
    this.specialistName,
    required this.serviceName,
    required this.serviceDescription,
    required this.scheduledDateTime,
    required this.estimatedDuration,
    required this.price,
    required this.status,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.cancellationReason,
    this.rescheduleReason,
    this.originalDateTime,
    this.additionalData,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      userId: json['userId'] as String,
      shopId: json['shopId'] as String,
      shopName: json['shopName'] as String,
      specialistId: json['specialistId'] as String?,
      specialistName: json['specialistName'] as String?,
      serviceName: json['serviceName'] as String,
      serviceDescription: json['serviceDescription'] as String,
      scheduledDateTime: DateTime.parse(json['scheduledDateTime']),
      estimatedDuration: Duration(minutes: json['estimatedDurationMinutes'] as int),
      price: (json['price'] as num).toDouble(),
      status: BookingStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
        orElse: () => BookingStatus.upcoming,
      ),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      cancellationReason: json['cancellationReason'] as String?,
      rescheduleReason: json['rescheduleReason'] as String?,
      originalDateTime: json['originalDateTime'] != null
          ? DateTime.parse(json['originalDateTime'])
          : null,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'shopId': shopId,
      'shopName': shopName,
      'specialistId': specialistId,
      'specialistName': specialistName,
      'serviceName': serviceName,
      'serviceDescription': serviceDescription,
      'scheduledDateTime': scheduledDateTime.toIso8601String(),
      'estimatedDurationMinutes': estimatedDuration.inMinutes,
      'price': price,
      'status': status.toString().split('.').last,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'rescheduleReason': rescheduleReason,
      'originalDateTime': originalDateTime?.toIso8601String(),
      'additionalData': additionalData,
    };
  }

  Booking copyWith({
    String? id,
    String? userId,
    String? shopId,
    String? shopName,
    String? specialistId,
    String? specialistName,
    String? serviceName,
    String? serviceDescription,
    DateTime? scheduledDateTime,
    Duration? estimatedDuration,
    double? price,
    BookingStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? cancellationReason,
    String? rescheduleReason,
    DateTime? originalDateTime,
    Map<String, dynamic>? additionalData,
  }) {
    return Booking(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      specialistId: specialistId ?? this.specialistId,
      specialistName: specialistName ?? this.specialistName,
      serviceName: serviceName ?? this.serviceName,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      price: price ?? this.price,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      rescheduleReason: rescheduleReason ?? this.rescheduleReason,
      originalDateTime: originalDateTime ?? this.originalDateTime,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  // Helper methods
  bool get isUpcoming => status == BookingStatus.upcoming;
  bool get isCompleted => status == BookingStatus.completed;
  bool get isCancelled => status == BookingStatus.cancelled;
  bool get isRescheduled => status == BookingStatus.rescheduled;

  String get statusDisplayName {
    switch (status) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.noShow:
        return 'No Show';
      case BookingStatus.rescheduled:
        return 'Rescheduled';
    }
  }

  DateTime get endDateTime => scheduledDateTime.add(estimatedDuration);

  bool get canCancel {
    return status == BookingStatus.upcoming &&
        scheduledDateTime.isAfter(DateTime.now().add(const Duration(hours: 2)));
  }

  bool get canReschedule {
    return status == BookingStatus.upcoming &&
        scheduledDateTime.isAfter(DateTime.now().add(const Duration(hours: 4)));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Booking && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Booking(id: $id, service: $serviceName, status: $status)';
  }
}