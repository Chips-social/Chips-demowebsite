import 'package:chips_demowebsite/services/rest.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/color_constants.dart';
import 'package:flutter/material.dart';

class NestedChip extends StatefulWidget {
  final String url;

  const NestedChip({
    super.key,
    required this.url,
  });

  @override
  State<NestedChip> createState() => _NestedChipState();
}

class _NestedChipState extends State<NestedChip> {
  late Future<Map<String, dynamic>> metadataFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future
    metadataFuture = fetchMetadata(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate the user
      },
      child: FutureBuilder<Map<String, dynamic>>(
        future: metadataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If we run into an error, display it to the user
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // When the Future is complete and we have data, extract and display the card
            final data = snapshot.data!;
            final title = data['ogTitle'] ?? 'Title not available';
            final description =
                data['ogDescription'] ?? 'Description not available';
            final imageUrl =
                data['ogImage'] != null ? data['ogImage'][0]['url'] : "";
            final siteName = data['ogSiteName'] ?? 'Website not available';

            return InkWell(
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(widget.url))) {
                  await launchUrl(Uri.parse(widget.url));
                } else {
                  print('Could not launch ${widget.url}');
                }
              },
              child: Card(
                margin: EdgeInsets.only(top: 10),
                color: Colors
                    .grey[850], // Adjust according to your ColorConst.dark
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Color(
                              0xFF02a6f7), // Adjust according to your color constants
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                          height:
                              5), // Added space between title and description
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors
                              .white, // Adjust according to your ColorConst.primaryText
                        ),
                      ),
                      SizedBox(height: 10),
                      if (imageUrl != "") // Check if an image URL is available
                        Container(
                          height: 140,
                          width: double
                              .infinity, // Use double.infinity to stretch to the full width
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (siteName
                          .isNotEmpty) // Optionally display the site name
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Source: $siteName',
                            style: TextStyle(
                              color: Colors
                                  .white70, // Adjust according to your color constants
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // If the Future is complete but no data, display a message to the user
            return Center(child: Text('No data found for this URL'));
          }
        },
      ),
    );
  }
}
