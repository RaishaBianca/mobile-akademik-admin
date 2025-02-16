// lib/customstyle/roomCard.dart
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String idRuang;
  final String namaRuang;
  final List<Map<String, dynamic>> timeSlots;
  final Function(String, Map<String, dynamic>) onToggleStatus;

  const RoomCard({
    Key? key,
    required this.idRuang,
    required this.namaRuang,
    required this.timeSlots,
    required this.onToggleStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(namaRuang),
            subtitle: Text(idRuang),
          ),
          ...timeSlots.map((slot) => 
            ListTile(
              leading: Icon(
                slot['status'] == 'open' ? Icons.lock_open : Icons.lock,
                color: slot['status'] == 'open' ? Colors.green : Colors.red,
              ),
              title: Text('${slot['start']} - ${slot['end']}'),
              subtitle: Text(slot['reason'] ?? 'No reason provided'),
              trailing: Switch(
                value: slot['status'] == 'open',
                onChanged: (_) => onToggleStatus(idRuang, slot),
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }
}