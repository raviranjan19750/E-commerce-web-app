import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final ScrollController scrollController;
  _moveUp() {
    scrollController.animateTo(0,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  const Footer({Key key, this.scrollController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(""),
            Text(""),
            FooterRowWidgets(),
            SizedBox(
              height: 30,
            ),
            Divider(),
            Row(
              children: [
                Text("2020 Living Desire"),
                Expanded(
                    child: Center(
                  child: Row(
                    children: [
                      Icon(Icons.face_retouching_natural),
                      Icon(Icons.face_retouching_natural),
                      Icon(Icons.face_retouching_natural),
                      Icon(Icons.face_retouching_natural),
                      Icon(Icons.face_retouching_natural),
                    ],
                  ),
                )),
                InkWell(
                  child: Text("Go Up"),
                  onTap: () {
                    _moveUp();
                  },
                ),
              ],
            )
          ],
        ));
  }
}

class FooterRowWidgets extends StatelessWidget {
  final List<String> rent = ["About Us", "Culture", "Investor", "Contact Us"];
  final List<String> info = ["Blog", "FAQ", "Docs"];
  final List<String> policy = [
    "Shipping Policy",
    "Cancellation & Return",
    "Privacy Policy",
    "Terms and Condition"
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FooterSiteMapColumn(
            header: "RENTMOJO",
            links: rent,
          ),
        ),
        Expanded(
          child: FooterSiteMapColumn(
            header: "INFORMATION",
            links: info,
          ),
        ),
        Expanded(
          child: FooterSiteMapColumn(
            header: "POLICIES",
            links: policy,
          ),
        ),
        Expanded(
          child: ContactUs(),
        ),
      ],
    );
  }
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("NEED HELP"), Text("1800 4234 423")],
    );
  }
}

class FooterSiteMapColumn extends StatelessWidget {
  final String header;
  final List<String> links;

  const FooterSiteMapColumn({Key key, this.header, this.links})
      : assert(header != null),
        assert(links != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(header),
        SizedBox(
          height: 10,
        ),
        ...links.map((e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(e),
            ))
      ],
    );
  }
}
