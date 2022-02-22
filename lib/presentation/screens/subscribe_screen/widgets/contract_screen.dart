import 'package:ad_drive/contants/app_colors.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({Key? key}) : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  bool isLoading = true;
  late PdfDocument _doc;
  final storage = <int, PdfPageImage>{};
  final controller = PageController(initialPage: 0);

  int selectedIndex = 0;

  Future<void> loadDocument() async {
    _doc = await PdfDocument.openAsset('assets/agreement_document.pdf');
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Контракт"),
      body: isLoading
          ? const Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.PRIMARY_BLUE,
                ),
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  Flexible(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (int page) {
                        setState(() {
                          selectedIndex = page;
                        });
                      },
                      physics: const BouncingScrollPhysics(),
                      children: pages(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> pages() {
    List<Widget> pages = [];
    for (int i = 1; i <= _doc.pagesCount; i++) {
      pages.add(
        ImageLoader(
          storage: storage,
          document: _doc,
          pageNumber: i,
        ),
      );
    }
    return pages;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? const BoxShadow(
                    color: AppColors.PRIMARY_BLUE,
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? AppColors.PRIMARY_BLUE : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];

    for (int i = 0; i < _doc.pagesCount; i++) {
      list.add(i == selectedIndex ? _indicator(true) : _indicator(false));
    }

    return list;
  }
}

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    required this.storage,
    required this.document,
    required this.pageNumber,
    Key? key,
  }) : super(key: key);

  final Map<int, PdfPageImage?> storage;
  final PdfDocument? document;
  final int pageNumber;

  @override
  Widget build(BuildContext context) => Center(
        child: FutureBuilder(
          future: _renderPage(),
          builder: (context, AsyncSnapshot<PdfPageImage?> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Смахните вправо или влево',
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.PRIMARY_BLUE,
                  ),
                ),
              );
            }

            return Column(
              children: [
                Image(
                  fit: BoxFit.fitWidth,
                  image: MemoryImage(snapshot.data!.bytes),
                ),
              ],
            );
          },
        ),
      );

  Future<PdfPageImage?> _renderPage() async {
    if (storage.containsKey(pageNumber)) {
      return storage[pageNumber];
    }
    final page = await document!.getPage(pageNumber);
    final pageImage = await page.render(
      width: page.width * 2,
      height: page.height * 2,
      format: PdfPageImageFormat.png,
    );
    await page.close();
    storage[pageNumber] = pageImage;
    return pageImage;
  }
}
