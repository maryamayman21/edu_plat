import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class WrittenPdfCreatorScreen extends StatefulWidget {
  const WrittenPdfCreatorScreen({super.key, required this.examModel, required this.isWrittenExam});
  final PDFExamModel examModel;
  final bool isWrittenExam;
  @override
  State<WrittenPdfCreatorScreen> createState() =>
      _WrittenPdfCreatorScreenState();
}

class _WrittenPdfCreatorScreenState extends State<WrittenPdfCreatorScreen> {

  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;
  bool _showZoomControls = false;

  pw.Document? pdfDocument;
  bool isLoading = false;
  pw.Font? robotoMonoRegular;
  pw.Font? robotoMonoBold;

  @override
  void initState() {
       createWrittenExamPdf();
    super.initState();
  }

  Future<void> _loadFonts() async {
    final regularFontData =
    await rootBundle.load('assets/fonts/RobotoMono-Regular.ttf');
    robotoMonoRegular = pw.Font.ttf(regularFontData);

    try {
      final boldFontData =
      await rootBundle.load('assets/fonts/RobotoMono-Bold.ttf');
      robotoMonoBold = pw.Font.ttf(boldFontData);
    } catch (e) {
      robotoMonoBold = robotoMonoRegular;
    }
  }
  Future<void> createWrittenExamPdf() async {
    setState(() => isLoading = true);

    try {
      if (robotoMonoRegular == null) {
        await _loadFonts();
      }

      final pdf = pw.Document();
      final ByteData imageData =
      await rootBundle.load('assets/image/ain_shams_logo.png');
      final Uint8List imageBytes = imageData.buffer.asUint8List();

      const double pageMargin = 20;
      double maxPageHeight = PdfPageFormat.a3.height - (40 * pageMargin);
      double currentPageHeight = 0;
      bool isFirstPage = true;
      int pageNumber = 0;
      List<pw.Widget> currentPageContent = [];

      // Function to add a complete page
      void addPageToPdf(List<pw.Widget> content, bool includeHeader) {
        pageNumber++;
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a3,
            margin: const pw.EdgeInsets.all(pageMargin),
            build: (pw.Context context) {
              return
                pw.Column(
                  mainAxisAlignment: includeHeader ?  pw.MainAxisAlignment.start : pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (includeHeader)
                    _buildPageHeader(imageBytes, pageNumber),
                  // if (!includeHeader)
                  //   pw.SizedBox(height: 120),

                  ...content,

                ],
                );
            },
          ),
        );

      }

      // Define these constants at the top of your class
      const double _questionBaseHeight = 18.0; // Base height for question text
      const double _subQuestionHeight = 15.0; // Height per sub-question
      const double _answerSpacePerPoint = 5.0; // Answer space per mark
      const double _questionSpacing = 6.0; // Space between questions

      // Improved height estimation method
      double _estimateQuestionHeight(QuestionModel question) {
        double height = _questionBaseHeight; // Base height for question text

        // Add height for sub-questions
       height += question.options.length * _subQuestionHeight;

        // Add answer space based on points
     //  height += 10 * _answerSpacePerPoint;

        return height;
      }

// In your createWrittenExamPdf method:
      for (var i = 0; i < widget.examModel.questions.length; i++) {
        final question = widget.examModel.questions[i];
        final estimatedHeight = _estimateQuestionHeight(question);

        debugPrint('Question ${i + 1} - Estimated height: $estimatedHeight');
        debugPrint('Current page height: $currentPageHeight');
        debugPrint('Max page height: $maxPageHeight');

        // If this question won't fit on the current page, start a new page
        if (currentPageHeight + estimatedHeight > maxPageHeight && currentPageContent.isNotEmpty) {
               print('Current page content : $currentPageContent');
          debugPrint('Creating new page for question ${i + 1}');
          addPageToPdf(currentPageContent, isFirstPage);
          currentPageContent = [];
          currentPageHeight = 0;
          isFirstPage = false;
        }

        final questionWidget = _buildQuestionWidget(i, question);
        currentPageContent.add(questionWidget);
      //  currentPageContent.add(pw.SizedBox(height: _questionSpacing));
        currentPageHeight += estimatedHeight + _questionSpacing  ;
      }

// Add the last page if there's remaining content
      if (currentPageContent.isNotEmpty) {
        addPageToPdf(currentPageContent, isFirstPage);
      }



      setState(() {
        pdfDocument = pdf;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating PDF: ${e.toString()}')),
      );
    }
  }

  pw.Widget _buildQuestionWidget(int index, QuestionModel question) {
    return pw.Padding(
      padding:const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child:
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Main question with points
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Expanded(
              child:
            pw.Text(
              softWrap: true,
           widget.isWrittenExam?  'Question ${index + 1})' :  '${index + 1}. ${question.question}' ,
              style: pw.TextStyle(
                font: robotoMonoBold,
                fontSize: 25,
              ),
            ),
            ),
            widget.isWrittenExam? pw.Text(
              softWrap: true,
              '[${question.degree} Marks]',
              style: pw.TextStyle(
                font: robotoMonoBold,
                fontSize: 18,
              ),
            ): pw.SizedBox.shrink()
          ],
        ),

        // Sub-questions if they exist
        if (question.options.isNotEmpty) ...[
          pw.SizedBox(height: 2),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: question.options.asMap().entries.map((entry) {
              final subIndex = entry.key;
              final subQuestion = entry.value;
              return pw.Padding(
              padding: const pw.EdgeInsets.only(left: 20, bottom: 8),
              child: pw.Text(
                '${subIndex + 1} ${subQuestion.text}',
                style: pw.TextStyle(
                  font: robotoMonoBold,
                  fontSize: 14,
                ),
              ),
                            ) ;
            }).toList(),
          ),
        ],
      ],
      ),
    );
  }

  pw.Widget _buildPageHeader(Uint8List imageBytes, int pageNum) {
    final pw.MemoryImage pdfImage = pw.MemoryImage(imageBytes);
    return pw.Column(children: [
      // Header with border
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 1, color: PdfColors.black),
        ),
        padding: const pw.EdgeInsets.all(10),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            // Left column data
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Faculty of Science',
                  softWrap: true,
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ), pw.Text(
                  'Mathematics Department',
                  softWrap: true,
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Date : ${widget.examModel.examDate!.year}/${widget.examModel.examDate!.month}/${widget.examModel.examDate!.day}',
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Number of pages : ${pageNum}',
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // Center image (constrained to reasonable size)
            pw.Container(
              width: 80,
              height: 80,
              child: pw.Image(pdfImage, fit: pw.BoxFit.contain),
            ),

            // Right column data
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  ' Course :${widget.examModel.courseCode}',
                  softWrap: true,
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Level ${widget.examModel.level} - Semester : ${widget.examModel.semester}',
                  softWrap: true,
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Program: ${widget.examModel.program}',
                  softWrap: true,
                  maxLines: 2,
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Time: ${widget.examModel.timeInHour} hours',
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Total Marks: ${widget.examModel.totalMark} Marks',
                  style: pw.TextStyle(
                    font: robotoMonoBold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Document title
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 40),
        child: pw.Text(
          widget.examModel.examTitle,
          style: pw.TextStyle(
            fontSize: 28,
            fontWeight: pw.FontWeight.bold,
          ),
          textAlign: pw.TextAlign.center,
        ),
      ), pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Text(
          'Answer all the following questions',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
          textAlign: pw.TextAlign.center,
        ),
      ),
    ]);
  }
  // Future<void> createMCQExamPdf() async {
  //   setState(() => isLoading = true);
  //
  //   try {
  //     if (robotoMonoRegular == null) {
  //       await _loadFonts();
  //     }
  //
  //     final pdf = pw.Document();
  //     final ByteData imageData =
  //     await rootBundle.load('assets/image/ain_shams_logo.png');
  //     final Uint8List imageBytes = imageData.buffer.asUint8List();
  //
  //     const double pageMargin = 20;
  //      List<pw.Widget> currentPageContent = [];
  //     double currentHeight = 0;
  //     double pageHeight = PdfPageFormat.a3.height - 80; // Account for margins
  //     const double questionSpacing = 30;
  //     int pageNumber = 0;
  //     bool isFirstPage = true;
  //     void addPageToPdf(List<pw.Widget> content, bool includeHeader) {
  //       pageNumber++;
  //       pdf.addPage(
  //         pw.Page(
  //           pageFormat: PdfPageFormat.a3,
  //           margin: const pw.EdgeInsets.all(pageMargin),
  //           build: (pw.Context context) {
  //             return
  //               pw.Column(
  //                 mainAxisAlignment: includeHeader ?  pw.MainAxisAlignment.start : pw.MainAxisAlignment.center,
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   if (includeHeader)
  //                     _buildPageHeader(imageBytes, pageNumber),
  //                   // if (!includeHeader)
  //                   //   pw.SizedBox(height: 120),
  //
  //                   ...content,
  //
  //                 ],
  //               );
  //           },
  //         ),
  //       );
  //
  //     }
  //     void addCompletePage(List<pw.Widget> content) {
  //       pdf.addPage(
  //         pw.Page(
  //           pageFormat: PdfPageFormat.a3,
  //           margin: const pw.EdgeInsets.all(20),
  //           build: (pw.Context context) {
  //             return pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: content,
  //             );
  //           },
  //         ),
  //       );
  //     }
  //
  //
  //     for (var i = 0; i <  widget.examModel.questions.length; i++) {
  //       final question =widget.examModel.questions[i];
  //       final questionWidget = _buildMCQQuestionWidget(i, question);
  //
  //       // Estimate question height (approximate)
  //       final estimatedHeight = _estimateQuestionHeight(question);
  //
  //       // Check if we need a new page
  //
  //         if (currentHeight + estimatedHeight > pageHeight && currentPageContent.isNotEmpty) {
  //           print('Current page content : $currentPageContent');
  //           debugPrint('Creating new page for question ${i + 1}');
  //           addPageToPdf(currentPageContent, isFirstPage);
  //           currentPageContent = [];
  //           currentHeight = 0;
  //           isFirstPage = false;
  //         }
  //
  //
  //       currentPageContent.add(questionWidget);
  //       currentPageContent.add(pw.SizedBox(height: questionSpacing));
  //       currentHeight += estimatedHeight + questionSpacing;
  //     }
  //
  //     // Add any remaining content
  //     if (currentPageContent.isNotEmpty) {
  //       addCompletePage(currentPageContent);
  //     }
  //
  //     setState(() {
  //       pdfDocument = pdf;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() => isLoading = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error creating PDF: ${e.toString()}')),
  //     );
  //   }
  // }
  // double _estimateQuestionHeight(QuestionModel question) {
  //   // Base heights for components
  //   const double baseHeight = 16 + 10 + 18 + 15 + 14 + 20 + 16 + 10;
  //   const double optionHeight = 14 + 8;
  //   int optionsHeight = 8 * question.options.length;
  //
  //   return baseHeight + optionsHeight;
  // }
  //
  // pw.Widget _buildMCQQuestionWidget(int index, QuestionModel question) {
  //   return pw.Column(
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     children: [
  //       pw.Row(
  //         crossAxisAlignment:
  //         pw.CrossAxisAlignment.start, // Align items at the top
  //         children: [
  //           pw.Text(
  //             '${index + 1}.',
  //             style: pw.TextStyle(
  //               font: robotoMonoBold,
  //               fontSize: 16,
  //             ),
  //           ),
  //           pw.SizedBox(width: 3),
  //           pw.Expanded(
  //             // This makes the text take available width and wrap
  //             child: pw.Text(
  //               question.question,
  //               style: pw.TextStyle(
  //                 font: robotoMonoBold,
  //                 fontSize: 18,
  //               ),
  //               softWrap: true, // Enable text wrapping
  //               maxLines: 3, // Maximum lines before truncation
  //             ),
  //           ),
  //         ],
  //       ),
  //       pw.SizedBox(height: 15),
  //       ...question.options
  //           .map((option) => pw.Padding(
  //         padding: const pw.EdgeInsets.only(bottom: 8),
  //         child: pw.Row(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text(
  //               '.',
  //               style: pw.TextStyle(
  //                 font: robotoMonoRegular,
  //                 fontSize: 14,
  //               ),
  //             ),
  //             pw.Expanded(
  //               child: pw.Text(
  //                 option.text,
  //                 style: pw.TextStyle(
  //                   font: robotoMonoRegular,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ))
  //           .toList(),
  //     ],
  //   );
  // }


  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            if (pdfDocument != null) ...[
              isLoading
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
                  : Expanded(
                child: Stack(
                  children: [
                    InteractiveViewer(
                      transformationController: _transformationController,
                      minScale: 0.5,
                      maxScale: 4.0,
                      onInteractionUpdate: (details) {
                        setState(() {
                          _currentScale = _transformationController.value.getMaxScaleOnAxis();
                          _showZoomControls = _currentScale != 1.0;
                        });
                      },
                      child: PdfPreview(
                        //scrollViewDecoration: const BoxDecoration(color: color.primaryColor),
                        build: (format) => pdfDocument!.save(),
                      ),
                    ),
                    // Zoom controls
                    Positioned(
                      right: 16,
                      bottom: 80,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            heroTag: 'zoomIn',
                            mini: true,
                            onPressed:   _zoomIn,
                            child: const Icon(Icons.add),
                          ),
                          const SizedBox(height: 8),
                          FloatingActionButton(
                            heroTag: 'zoomOut',
                            mini: true,
                            onPressed:_zoomOut,
                            child: const Icon(Icons.remove),
                          ),
                          const SizedBox(height: 8),
                          FloatingActionButton(
                            heroTag: 'resetZoom',
                            mini: true,
                            onPressed: _resetZoom,
                            child: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ),
                    // Zoom indicator
                  ],
                ),
              ),

            ],
          ],
        ),
      ),
    );
  }

  void _handleDoubleTap() {
    if (_currentScale != 1.0) {
      _resetZoom();
    } else {
      _zoomIn();
    }
  }

  void _zoomIn() {
    final newScale = (_currentScale + 0.25).clamp(0.5, 4.0);
    _updateZoom(newScale);
  }

  void _zoomOut() {
    final newScale = (_currentScale - 0.25).clamp(0.5, 4.0);
    _updateZoom(newScale);
  }

  void _resetZoom() {
    _updateZoom(1.0);
  }

  void _updateZoom(double scale) {
    _transformationController.value = Matrix4.identity()..scale(scale);
    setState(() {
      _currentScale = scale;
      _showZoomControls = scale != 1.0;
    });
  }
}
