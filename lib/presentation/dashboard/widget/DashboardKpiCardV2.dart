import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class DashboardKpiCardV2 extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final bool showCurrency;

  const DashboardKpiCardV2({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.showCurrency = true,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < 700;

    final dark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: dark
                ? [
              color.withOpacity(.70),
              color.withOpacity(.45),
            ]
                : [
              color,
              color.withOpacity(.75),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            isMobile ? 16 : 20,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius:
                    isMobile ? 20 : 24,
                    backgroundColor:
                    Colors.white
                        .withOpacity(.20),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size:
                      isMobile ? 22 : 26,
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.trending_up,
                    color: Colors.white,
                  ),
                ],
              ),

              const Spacer(),

              FittedBox(
                fit: BoxFit.scaleDown,
                alignment:
                Alignment.centerLeft,
                child: AnimatedFlipCounter(
                  value: value,
                  duration:
                  const Duration(
                    milliseconds: 700,
                  ),
                  fractionDigits: 0,
                  prefix:
                  showCurrency
                      ? '₹'
                      : '',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,
                    fontSize:
                    isMobile
                        ? 24
                        : 34,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                title,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                  isMobile ? 14 : 15,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              if (subtitle != null)
                Padding(
                  padding:
                  const EdgeInsets.only(
                    top: 4,
                  ),
                  child: Text(
                    subtitle!,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style:
                    const TextStyle(
                      color:
                      Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}