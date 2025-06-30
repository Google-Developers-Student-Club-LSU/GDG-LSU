import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHoverChanged(true),
      onExit: (_) => widget.onHoverChanged(false),
      child: Container(
        width: widget.isMobile ? 800 : MediaQuery.of(context).size.width * 0.40,
        height: widget.isMobile ? 700 : MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          border: Border.all(color: gGreen, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: SfPdfViewer.asset(
            'sponsorPackage/Sponsors.pdf',
            controller: widget.pdfViewerController,
            scrollDirection: PdfScrollDirection.vertical,
            pageLayoutMode: PdfPageLayoutMode.single,
            enableDoubleTapZooming: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            onDocumentLoaded: (details) {
              widget.pdfViewerController.zoomLevel = 1.0;
            },
          ),
        ),
      ),
    );
  }
}
