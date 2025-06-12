import 'dart:typed_data';

import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/student_degree_entity.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class StudentPdfViewerScreen extends StatelessWidget {
  final List<StudentDegreeEntity> students;

  const StudentPdfViewerScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Report PDF'),
        centerTitle: true,
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, students),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, List<StudentDegreeEntity> students) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (context) => [
          pw.Center(
            child: pw.Text(
              'Student Degrees Report',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Table.fromTextArray(
            headers: ['Name', 'Score', 'Percentage', 'Attendance'],
            data: students.map((student) {
              return [
                student.userName,
               // student.email,
                student.score.toString(),
                '${student.scorePercentage.toStringAsFixed(2)}%',
                student.attendance ?   'Absent' : 'Present',
              ];
            }).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.centerLeft,
            border: pw.TableBorder.all(),
            cellPadding: const pw.EdgeInsets.all(4),
          ),
        ],
      ),
    );

    return pdf.save();
  }
}
