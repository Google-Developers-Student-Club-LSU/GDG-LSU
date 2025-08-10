import 'dart:async';
import 'package:flutter/material.dart';

class TimeRect extends StatefulWidget {
  final DateTime targetTime;

  const TimeRect({super.key, required this.targetTime});

  @override
  State<TimeRect> createState() => _TimeRectState();
}

class _TimeRectState extends State<TimeRect> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.targetTime.difference(now);
      if (_remaining.isNegative) {
        _remaining = Duration.zero;
        _timer.cancel();
      }
    });
  }

  List<Widget> _buildTimeBox(String number, String label) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1F3D2C),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [      
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(0, 4),            
            blurRadius: 8,                         
            spreadRadius: 1,                       
          ),
          ]
        ),
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays.toString().padLeft(2, '0');
    final hours = (_remaining.inHours % 24).toString().padLeft(2, '0');
    final minutes = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    
    const spacing = 30.0;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: _buildTimeBox(days, 'day')),
          const SizedBox(width: spacing), 
          Column(children: _buildTimeBox(hours, 'hr')),
          const SizedBox(width: spacing),
          Column(children: _buildTimeBox(minutes, 'min')),
          const SizedBox(width: spacing),
          Column(children: _buildTimeBox(seconds, 'sec')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
