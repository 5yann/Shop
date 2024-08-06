// ignore_for_file: library_private_types_in_public_api, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Providers/global_sells_graph_provider.dart';
import 'package:provider/provider.dart';

class LineChartSample extends StatelessWidget {

   const LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GraphAllSells>(
      builder: (context, GraphAllSells, child) {
        return LineChart(
          LineChartData(
            gridData:const  FlGridData(show: true),
             titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    // Affichez la valeur numérique sur l'axe X
                    return Text(value.toInt().toString());
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    // Affichez la valeur numérique sur l'axe Y
                    return Text(value.toInt().toString());
                  },
                ),
              ),),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots:GraphAllSells.spots,
                isCurved: true,
                color:const  Color.fromARGB(6, 30, 6, 44),
                barWidth: 4,
                isStrokeCapRound: true,
                dotData:const  FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        );
      },
    );
  }
}