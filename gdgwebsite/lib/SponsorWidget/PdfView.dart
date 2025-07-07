import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFView extends StatefulWidget {
  final bool isMobile;
  final PdfViewerController pdfViewerController;
  final ValueChanged<bool> onHoverChanged;

  const PDFView({
    super.key,
    this.isMobile = false,
    required this.pdfViewerController,
    required this.onHoverChanged,
  });

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final double width = widget.isMobile ? 800 : MediaQuery.of(context).size.width * 0.40;
    final double height = widget.isMobile ? 700 : MediaQuery.of(context).size.height * 0.85;
    final mobile = MediaQuery.of(context).size.width < 400;

    return MouseRegion(
      onEnter: (_) => widget.onHoverChanged(true),
      onExit: (_) => widget.onHoverChanged(false),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: gGreen, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Stack(
            children: [
              SfPdfViewer.asset(
                pdfBooklet,
                controller: widget.pdfViewerController,
                scrollDirection: mobile? PdfScrollDirection.horizontal:  PdfScrollDirection.vertical,

                pageLayoutMode: PdfPageLayoutMode.single,
                enableDoubleTapZooming: true,
                canShowScrollHead: true,
                canShowScrollStatus: true,
              
                onDocumentLoaded: (details) {
                  widget.pdfViewerController.zoomLevel = 1.0;
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
              if (_isLoading)
                Container(
                  width: width,
                  height: height,
                  color: Colors.black.withValues(alpha: .7),
                  child: Center(
                    child: Image.asset(
                      gifLoading , 
                      width: 150,
                      height: 150,
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
