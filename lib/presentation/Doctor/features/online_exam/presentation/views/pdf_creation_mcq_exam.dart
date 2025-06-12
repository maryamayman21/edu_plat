//
// import 'package:edu_platt/core/utils/Color/color.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/pdf_written_exam.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/question_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'dart:io';
//
// class MCQPdfCreatorScreen extends StatefulWidget {
//   const MCQPdfCreatorScreen({super.key, required this.examModel});
//   final PDFExamModel examModel;
//   @override
//   State<MCQPdfCreatorScreen> createState() =>
//       _MCQPdfCreatorScreenState();
// }
//
// class _MCQPdfCreatorScreenState extends State<MCQPdfCreatorScreen> {
//
//   final TransformationController _transformationController = TransformationController();
//   double _currentScale = 1.0;
//   bool _showZoomControls = false;
//
//   pw.Document? pdfDocument;
//   bool isLoading = false;
//   pw.Font? robotoMonoRegular;
//   pw.Font? robotoMonoBold;
//
//   @override
//   void initState() {
//     createMcqExamPdf();
//     super.initState();
//   }
//
//   Future<void> _loadFonts() async {
//     final regularFontData =
//     await rootBundle.load('assets/fonts/RobotoMono-Regular.ttf');
//     robotoMonoRegular = pw.Font.ttf(regularFontData);
//
//     try {
//       final boldFontData =
//       await rootBundle.load('assets/fonts/RobotoMono-Bold.ttf');
//       robotoMonoBold = pw.Font.ttf(boldFontData);
//     } catch (e) {
//       robotoMonoBold = robotoMonoRegular;
//     }
//   }
//
//
//
//   Future<void> createMcqExamPdf() async {
//     setState(() => isLoading = true);
//
//     try {
//       if (robotoMonoRegular == null) {
//         await _loadFonts();
//       }
//
//       final pdf = pw.Document();
//       final ByteData imageData =
//       await rootBundle.load('assets/image/ain_shams_logo.png');
//       final Uint8List imageBytes = imageData.buffer.asUint8List();
//
//       const double pageMargin = 20;
//       double maxPageHeight = PdfPageFormat.a3.height - (40 * pageMargin);
//       double currentPageHeight = 0;
//       bool isFirstPage = true;
//       int pageNumber = 0;
//       List<pw.Widget> currentPageContent = [];
//
//       // Function to add a complete page
//       void addPageToPdf(List<pw.Widget> content, bool includeHeader) {
//         pageNumber++;
//         pdf.addPage(
//           pw.Page(
//             pageFormat: PdfPageFormat.a3,
//             margin: const pw.EdgeInsets.all(pageMargin),
//             build: (pw.Context context) {
//               return
//                 pw.Column(
//                   mainAxisAlignment: includeHeader ?  pw.MainAxisAlignment.start : pw.MainAxisAlignment.center,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     if (includeHeader)
//                       _buildPageHeader(imageBytes, pageNumber),
//                     // if (!includeHeader)
//                     //   pw.SizedBox(height: 120),
//
//                     ...content,
//
//                   ],
//                 );
//             },
//           ),
//         );
//
//       }
//
//       // Define these constants at the top of your class
//       const double _questionBaseHeight = 18.0; // Base height for question text
//       const double _subQuestionHeight = 15.0; // Height per sub-question
//       const double _answerSpacePerPoint = 5.0; // Answer space per mark
//       const double _questionSpacing = 6.0; // Space between questions
//
//       // Improved height estimation method
//       double _estimateQuestionHeight(QuestionModel question) {
//         double height = _questionBaseHeight; // Base height for question text
//
//         // Add height for sub-questions
//         height += question.options.length * _subQuestionHeight;
//
//         // Add answer space based on points
//         //  height += 10 * _answerSpacePerPoint;
//
//         return height;
//       }
//
//       for (var i = 0; i < widget.examModel.questions.length; i++) {
//         final question = widget.examModel.questions[i];
//         final estimatedHeight = _estimateQuestionHeight(question);
//
//         debugPrint('Question ${i + 1} - Estimated height: $estimatedHeight');
//         debugPrint('Current page height: $currentPageHeight');
//         debugPrint('Max page height: $maxPageHeight');
//
//         // If this question won't fit on the current page, start a new page
//         if (currentPageHeight + estimatedHeight > maxPageHeight && currentPageContent.isNotEmpty) {
//           print('Current page content : $currentPageContent');
//           debugPrint('Creating new page for question ${i + 1}');
//           addPageToPdf(currentPageContent, isFirstPage);
//           currentPageContent = [];
//           currentPageHeight = 0;
//           isFirstPage = false;
//         }
//
//         final questionWidget = _buildQuestionWidget(i, question);
//         currentPageContent.add(questionWidget);
//         //  currentPageContent.add(pw.SizedBox(height: _questionSpacing));
//         currentPageHeight += estimatedHeight + _questionSpacing  ;
//       }
//
// // Add the last page if there's remaining content
//       if (currentPageContent.isNotEmpty) {
//         addPageToPdf(currentPageContent, isFirstPage);
//       }
//
//
//
//       setState(() {
//         pdfDocument = pdf;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error creating PDF: ${e.toString()}')),
//       );
//     }
//   }
//
//   pw.Widget _buildQuestionWidget(int index, QuestionModel question) {
//     return pw.Padding(
//       padding:const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 5),
//       child:
//       pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           // Main question with points
//           pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.start,
//             children: [
//               pw.Expanded(
//                 child:
//                 pw.Text(
//                   softWrap: true,
//                   '${index + 1}. ${question.question}' ,
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 25,
//                   ),
//                 ),
//               ),
//               pw.Text(
//                 softWrap: true,
//                 '[${question.degree} Marks]',
//                 style: pw.TextStyle(
//                   font: robotoMonoBold,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//
//           // Sub-questions if they exist
//           if (question.options.isNotEmpty) ...[
//             pw.SizedBox(height: 2),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: question.options.asMap().entries.map((entry) {
//                 final subIndex = entry.key;
//                 final subQuestion = entry.value;
//                 return pw.Padding(
//                   padding: const pw.EdgeInsets.only(left: 20, bottom: 8),
//                   child: pw.Text(
//                     '${index + 1}.${subIndex + 1} ${subQuestion.text}',
//                     style: pw.TextStyle(
//                       font: robotoMonoBold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   // double _estimateQuestionHeight(String questionText) {
//   //   // Base height for question and points
//   //   double baseHeight = 15;
//   //
//   //   // Estimate lines needed (assuming ~100 characters per line)
//   //   int lines = (questionText.length / 100).ceil();
//   //
//   //   // Add height for each line
//   //   baseHeight += lines * 10;
//   //
//   //   return baseHeight;
//   // }
//
//   pw.Widget _buildPageHeader(Uint8List imageBytes, int pageNum) {
//     final pw.MemoryImage pdfImage = pw.MemoryImage(imageBytes);
//     return pw.Column(children: [
//       // Header with border
//       pw.Container(
//         decoration: pw.BoxDecoration(
//           border: pw.Border.all(width: 1, color: PdfColors.black),
//         ),
//         padding: const pw.EdgeInsets.all(10),
//         child: pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: pw.CrossAxisAlignment.center,
//           children: [
//             // Left column data
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   'Faculty of Science',
//                   softWrap: true,
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ), pw.Text(
//                   'Mathematics Department',
//                   softWrap: true,
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 pw.Text(
//                   'Date : ${widget.examModel.examDate!.year}/${widget.examModel.examDate!.month}/${widget.examModel.examDate!.day}',
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 pw.Text(
//                   'Number of pages : ${pageNum}',
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//
//             // Center image (constrained to reasonable size)
//             pw.Container(
//               width: 80,
//               height: 80,
//               child: pw.Image(pdfImage, fit: pw.BoxFit.contain),
//             ),
//
//             // Right column data
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.end,
//               children: [
//                 pw.Text(
//                   ' Course :${widget.examModel.courseCode}',
//                   softWrap: true,
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 pw.Text(
//                   'Level ${widget.examModel.level} - Semester : ${widget.examModel.semester}',
//                   softWrap: true,
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 pw.Text(
//                   'Program: ${widget.examModel.program}',
//                   softWrap: true,
//                   maxLines: 2,
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 pw.Text(
//                   'Time: ${widget.examModel.timeInHour} hours',
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 pw.Text(
//                   'Total Marks: ${widget.examModel.totalMark} Marks',
//                   style: pw.TextStyle(
//                     font: robotoMonoBold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//
//       // Document title
//       pw.Padding(
//         padding: const pw.EdgeInsets.only(top: 60),
//         child: pw.Text(
//           widget.examModel.examTitle,
//           style: pw.TextStyle(
//             fontSize: 28,
//             fontWeight: pw.FontWeight.bold,
//           ),
//           textAlign: pw.TextAlign.center,
//         ),
//       ), pw.Padding(
//         padding: const pw.EdgeInsets.symmetric(vertical: 10),
//         child: pw.Text(
//           'Answer all the following questions',
//           style: pw.TextStyle(
//             fontSize: 14,
//             fontWeight: pw.FontWeight.bold,
//           ),
//           textAlign: pw.TextAlign.center,
//         ),
//       ),
//     ]);
//   }
//
//   pw.Widget _buildWrittenQuestionWidget(
//       int index, String question, String point, double answerBoxHeight) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Row(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text(
//               '${index + 1}.',
//               style: pw.TextStyle(
//                 font: robotoMonoBold,
//                 fontSize: 16,
//               ),
//             ),
//             pw.SizedBox(width: 5),
//             pw.Expanded(
//               child: pw.Text(
//                 question,
//                 style: pw.TextStyle(
//                   font: robotoMonoBold,
//                   fontSize: 18,
//                 ),
//                 softWrap: true,
//               ),
//             ),
//             pw.Text(
//               '[${point} Marks]',
//               style: pw.TextStyle(
//                 font: robotoMonoBold,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 15),
//         pw.Container(
//           width: double.infinity,
//           height: answerBoxHeight,
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(
//               color: PdfColors.black,
//               width: 1,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Future<void> _printPdf() async {
//     if (pdfDocument == null) return;
//     await Printing.layoutPdf(
//       onLayout: (format) => pdfDocument!.save(),
//     );
//   }
//   @override
//   void dispose() {
//     _transformationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//             if (pdfDocument != null) ...[
//               isLoading
//                   ? const CircularProgressIndicator(
//                 color: Colors.white,
//               )
//                   : Expanded(
//                 child: Stack(
//                   children: [
//                     InteractiveViewer(
//                       transformationController: _transformationController,
//                       minScale: 0.5,
//                       maxScale: 4.0,
//                       onInteractionUpdate: (details) {
//                         setState(() {
//                           _currentScale = _transformationController.value.getMaxScaleOnAxis();
//                           _showZoomControls = _currentScale != 1.0;
//                         });
//                       },
//                       child: PdfPreview(
//                         //scrollViewDecoration: const BoxDecoration(color: color.primaryColor),
//                         build: (format) => pdfDocument!.save(),
//                       ),
//                     ),
//                     // Zoom controls
//                     Positioned(
//                       right: 16,
//                       bottom: 80,
//                       child: Column(
//                         children: [
//                           FloatingActionButton(
//                             heroTag: 'zoomIn',
//                             mini: true,
//                             onPressed:   _zoomIn,
//                             child: const Icon(Icons.add),
//                           ),
//                           const SizedBox(height: 8),
//                           FloatingActionButton(
//                             heroTag: 'zoomOut',
//                             mini: true,
//                             onPressed:_zoomOut,
//                             child: const Icon(Icons.remove),
//                           ),
//                           const SizedBox(height: 8),
//                           FloatingActionButton(
//                             heroTag: 'resetZoom',
//                             mini: true,
//                             onPressed: _resetZoom,
//                             child: const Icon(Icons.refresh),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Zoom indicator
//                   ],
//                 ),
//               ),
//
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _handleDoubleTap() {
//     if (_currentScale != 1.0) {
//       _resetZoom();
//     } else {
//       _zoomIn();
//     }
//   }
//
//   void _zoomIn() {
//     final newScale = (_currentScale + 0.25).clamp(0.5, 4.0);
//     _updateZoom(newScale);
//   }
//
//   void _zoomOut() {
//     final newScale = (_currentScale - 0.25).clamp(0.5, 4.0);
//     _updateZoom(newScale);
//   }
//
//   void _resetZoom() {
//     _updateZoom(1.0);
//   }
//
//   void _updateZoom(double scale) {
//     _transformationController.value = Matrix4.identity()..scale(scale);
//     setState(() {
//       _currentScale = scale;
//       _showZoomControls = scale != 1.0;
//     });
//   }
// }
