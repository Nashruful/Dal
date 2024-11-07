import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class searchAdsCard extends StatelessWidget {
  const searchAdsCard(
      {super.key,
      required this.companyLogo,
      required this.companyName,
      required this.offerType,
      required this.viewLocation,
      this.locationOnPressed,
      required this.description});
  final String companyLogo;
  final String companyName;
  final String offerType;
  final String description;
  final String viewLocation;
  final void Function()? locationOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: Theme.of(context).canvasColor,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  companyLogo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                companyName,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            TextButton(
                                onPressed: locationOnPressed,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/discover.svg',
                                      colorFilter: ColorFilter.mode(
                                          Theme.of(context).primaryColor,
                                          BlendMode.srcIn),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      viewLocation,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          offerType,
                          style: Theme.of(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
