// lib/customstyle/roomCard.dart
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String idRuang;
  final String namaRuang;
  final String status;
  final Function(String) onToggleStatus;
  final List<Widget>? children;

  const RoomCard({
    Key? key,
    required this.idRuang,
    required this.namaRuang,
    required this.status,
    required this.onToggleStatus,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOpen = status.toLowerCase() == 'open';
    print("isOpen: $isOpen");
    
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Add this
        crossAxisAlignment: CrossAxisAlignment.start, // Add this
        children: [
          ListTile(
            title: Text(idRuang),
            subtitle: Text(namaRuang),
            trailing: Switch(
              value: isOpen,
              onChanged: (bool value) {
                onToggleStatus(idRuang);
              },
              activeColor: Colors.green,
              activeTrackColor: Colors.green.withOpacity(0.5),
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.red.withOpacity(0.5),
            ),
          ),
          if (children != null) 
            ...children!,
          // if (ruangantersedia['available_slots'] != null)
          //   ...(ruangantersedia['available_slots'] as List).map((slot) =>
          //       ListTile(
          //         leading: const Icon(Icons.access_time),
          //         title: Text('${slot['start']} - ${slot['end']}'),
          //         dense: true,
          //       ),
          //   ).toList(),
        ],
      ),
    );
  }
}