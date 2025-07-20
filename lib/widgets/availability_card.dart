import 'package:flutter/material.dart';
import '../models/salon_model.dart';

class AvailabilityCard extends StatelessWidget {
  final String day;
  final ScheduleModel schedule;

  const AvailabilityCard({
    Key? key,
    required this.day,
    required this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day
          Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Schedule or Day Off
          if (!schedule.isOpen)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'DAY OFF',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Row(
              children: [
                // Start Time
                Text(
                  schedule.startTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),

                // Arrow
                Container(
                  width: 20,
                  height: 1,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 16),

                // End Time
                Text(
                  schedule.endTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}