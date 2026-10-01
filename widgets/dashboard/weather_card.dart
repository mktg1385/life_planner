import 'package:flutter/material.dart';
import '../../services/weather_translation_service.dart';
import '../../core/enums/weather_source.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final double temperature;
  final String condition;

  final int? humidity;
  final double? windSpeed;
  final WeatherSource? source;
  final DateTime? updatedAt;
  final String? area;

  const WeatherCard({
    super.key,
    required this.city,
    this.area,
    required this.temperature,
    required this.condition,
    this.humidity,
    this.windSpeed,
    this.source,
    this.updatedAt,
  });

  IconData _weatherIcon() {
    final text = condition.toLowerCase();

    if (text.contains('sun') ||
        text.contains('clear') ||
        text.contains('آفتابی')) {
      return Icons.wb_sunny_rounded;
    }

    if (text.contains('cloud') || text.contains('ابری')) {
      return Icons.cloud_rounded;
    }

    if (text.contains('rain') || text.contains('باران')) {
      return Icons.water_drop_rounded;
    }

    if (text.contains('storm') || text.contains('طوفان')) {
      return Icons.thunderstorm_rounded;
    }

    if (text.contains('snow') || text.contains('برف')) {
      return Icons.ac_unit_rounded;
    }

    return Icons.wb_cloudy_rounded;
  }

  Color _statusColor() {
    return source == WeatherSource.online
        ? Colors.green
        : Colors.orange;
  }

  String _statusText() {
    return source == WeatherSource.online
        ? 'داده زنده'
        : 'داده ذخیره شده';
  }

  String _updateTime() {
    if (updatedAt == null) return '--:--';

    return '${updatedAt!.hour.toString().padLeft(2, '0')}:'
        '${updatedAt!.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: isDark
            ? []
            : const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5)
                        .withOpacity(.10),
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.wb_sunny_rounded,
                    size: 34,
                    color: Color(0xFF4F46E5),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        WeatherTranslationService.city(city),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),

                      if (area != null &&
                          area!.isNotEmpty)
                        Text(
                          area!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),

                      const SizedBox(height: 6),

                      Text(
                        WeatherTranslationService.condition(
                            condition),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor()
                              .withOpacity(.12),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          _statusText(),
                          style: TextStyle(
                            color: _statusColor(),
                            fontSize: 12,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  '${temperature.toStringAsFixed(0)}°',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue
                          .withOpacity(.08),
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.opacity,
                          color: Colors.blue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${humidity ?? 0}%',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w500,
                            color: isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey
                          .withOpacity(.08),
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.air,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${windSpeed?.toStringAsFixed(0) ?? '0'} km/h',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w500,
                            color: isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'آخرین بروزرسانی: ${_updateTime()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? Colors.white60
                        : Colors.grey,
                  ),
                ),
                if (source != null)
                  Text(
                    source == WeatherSource.online
                        ? 'آنلاین'
                        : 'آفلاین',
                    style: TextStyle(
                      color: _statusColor(),
                      fontWeight:
                          FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}