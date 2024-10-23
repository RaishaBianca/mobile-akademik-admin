import 'package:flutter/material.dart';

class StatusDropdown extends StatefulWidget {
  final Function(String) onSave;

  const StatusDropdown({Key? key, required this.onSave}) : super(key: key);

  @override
  _StatusDropdownState createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  String? _selectedStatus;
  final List<String> _statusOptions = [
    'Belum Dikerjakan',
    'Sedang Dikerjakan',
    'Selesai'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: _selectedStatus,
          hint: Text('Pilih Status'),
          items: _statusOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedStatus = newValue;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_selectedStatus != null) {
              widget.onSave(_selectedStatus!);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Reduced padding
            backgroundColor: Color(0xFFFF5833), // Background color fallback to primary
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Simpan',
            textAlign: TextAlign.center,
            style: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ??
                const TextStyle( // Fallback text style jika tidak ada di tema
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
        ),
      ],
    );
  }
}