// lib/customstyle/roomCard.dart
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String idRuang;
  final String namaRuang;
  final String status;
  final Function(String) onToggleStatus;

  const RoomCard({
    Key? key,
    required this.idRuang,
    required this.namaRuang,
    required this.status,
    required this.onToggleStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOpen = status.toLowerCase() == 'open';
    print("isOpen: $isOpen");
    
    return Card(
      child: ListTile(
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
    );
  }
}