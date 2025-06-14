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

  Future<void> _loadPdf() async {
    try {
      // Attempt to load the PDF document

      final pdfData = await InternetFile.get(widget.pdfUrl);

      // Open the PDF document
      final pdfDocument = PdfDocument.openData(pdfData);
      if (!mounted) return;
      setState(() {
        _pdfController = PdfControllerPinch(document: pdfDocument);
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors and update the state
      print(' ERRROOORRRR ${e.toString()}');

      setState(() {
        _errorMessage =  getUserFriendlyErrorMessage(e);
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