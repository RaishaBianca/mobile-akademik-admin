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
    return Card(
      child: ListTile(
        title: Text(idRuang),
        subtitle: Text(namaRuang),
        trailing: Switch(
          value: status == 'open',
          onChanged: (value) {
            onToggleStatus(idRuang);
          },
          activeColor: Colors.green,
          inactiveThumbColor: Colors.red,
        ),
      ),
    );
  }
}