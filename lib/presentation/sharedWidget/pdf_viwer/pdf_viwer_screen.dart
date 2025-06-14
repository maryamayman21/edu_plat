import 'package:edu_platt/core/constant/constant.dart';

import 'package:edu_platt/core/utils/helper_methds/get_friendly_messages.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:pdfx/pdfx.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;

  const PdfViewerScreen({Key? key, required this.pdfUrl, required this.pdfName}) : super(key: key);

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late PdfControllerPinch _pdfController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf1() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 1. Download PDF data
      final pdfData = await InternetFile.get(widget.pdfUrl);

      // 2. Open PDF document (with proper await)
      final pdfDocument =  PdfDocument.openData(pdfData).catchError((e) {
        print('ASYNC ERROR: $e');
        throw e; // Re-throw to be caught by the catch block
      });

      if (!mounted) return;

      setState(() {
        _pdfController = PdfControllerPinch(document: pdfDocument);
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      print('PDF LOAD ERROR: $e');
      print('STACK TRACE: $stackTrace');

      if (!mounted) return;

      setState(() {
       _errorMessage = getUserFriendlyErrorMessage(e);
        _isLoading = false;
      });
    }
  }

  Future<void> _loadPdf() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 1. Download PDF data
      final pdfData = await InternetFile.get(widget.pdfUrl);

      // Verify PDF data is not empty
      if (pdfData.isEmpty) {
        throw Exception('Downloaded PDF is empty');
      }

      // 2. Open PDF document with error handling
      Future<PdfDocument> pdfDocument;
      try {
         pdfDocument =   PdfDocument.openData(pdfData);
      } catch (e) {
        // Special handling for PDF rendering errors
        print('PDF RENDER ERROR: $e');
        throw Exception('The PDF file is corrupted or invalid');
      }

      if (!mounted) return;

      setState(() {
        _pdfController = PdfControllerPinch(document: pdfDocument);
        _isLoading = false;
      });

    } catch (e) {

      if (!mounted) return;

      setState(() {
        _errorMessage = getUserFriendlyErrorMessage(e);
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    if (!_isLoading && _errorMessage == null) {
      _pdfController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfName),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader while loading
          : _errorMessage != null
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: TextError( onPressed:(){
                    _loadPdf();

                  } , errorMessage:   _errorMessage!)),
          ) // // Show error message if PDF fails to load
          : PdfViewPinch(
        controller: _pdfController,
      ),
    );
  }
}