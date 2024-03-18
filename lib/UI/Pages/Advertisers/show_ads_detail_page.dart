import 'package:ad_brokers/Services/pdf_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowAdsDetailsPage extends StatefulWidget {
  final String brandName;
  final String brandURL;
  final String adTitle;
  final String adCategory;
  final String adType;
  final num noOfPlatforms;
  final num noOfDaysLeft;
  final num remainViews;
  final String imagePath;
  final String adsStatus;
  final String price;
  final String animationTag;

  const ShowAdsDetailsPage({
    super.key,
    required this.brandName,
    required this.brandURL,
    required this.adTitle,
    required this.adCategory,
    required this.adType,
    required this.noOfPlatforms,
    required this.noOfDaysLeft,
    required this.remainViews,
    required this.imagePath,
    required this.adsStatus,
    required this.price,
    required this.animationTag,
  });

  @override
  State<ShowAdsDetailsPage> createState() => _ShowAdsDetailsPageState();
}

class _ShowAdsDetailsPageState extends State<ShowAdsDetailsPage> {
  final pdfService = PDFService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        title: Text(
          widget.brandName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              pdfService.createAdAnalysisPDF(
                context,
                widget.brandName,
                widget.brandURL,
                widget.adTitle,
                widget.adCategory,
                widget.imagePath,
                widget.adType,
                widget.remainViews,
                widget.noOfPlatforms,
                widget.price,
                widget.noOfDaysLeft,
                widget.adsStatus,
              );
            },
            icon: Icon(
              Icons.download_rounded,
              color: Theme.of(context).shadowColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.animationTag,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.50,
                child: SizedBox(
                  width: 275,
                  height: 210,
                  child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.50,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).shadowColor,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.adTitle,
              style: Theme.of(context).textTheme.displayMedium,
            ).centered(),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.brandURL,
              style: Theme.of(context).textTheme.displaySmall,
            ).centered(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                border: TableBorder.all(
                  width: 1,
                  color: Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      "Fields",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Analysis",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Category",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.adCategory,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Type",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.adType,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Remain views",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.remainViews.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Running platform",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.noOfPlatforms.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Status",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.adsStatus,
                          style: widget.adsStatus == "pending"
                              ? Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.redAccent)
                              : widget.adsStatus == "ongoing"
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.green)
                                  : Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Price plan",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          "${widget.price}₹",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Days left",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.noOfDaysLeft.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CupertinoButton(
              onPressed: () {
                pdfService.createAdAnalysisPDF(
                  context,
                  widget.brandName,
                  widget.brandURL,
                  widget.adTitle,
                  widget.adCategory,
                  widget.imagePath,
                  widget.adType,
                  widget.remainViews,
                  widget.noOfPlatforms,
                  widget.price,
                  widget.noOfDaysLeft,
                  widget.adsStatus,
                );
              },
              color: Colors.purple,
              child: const Text(
                "Download as pdf",
                textAlign: TextAlign.center,
              ),
            ).centered(),
            const SizedBox(
              height: 10,
            ),
          ],
        ).p16(),
      ),
    );
  }
}
