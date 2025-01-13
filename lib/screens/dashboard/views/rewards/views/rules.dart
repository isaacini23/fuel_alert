import 'package:flutter/material.dart';

class RulesView extends StatelessWidget {
  RulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.15),
        centerTitle: true,
        title: Text(
          "Rules",
          style: TextStyle(
              fontFamily: "PoppinsSemiBold",
              fontSize: 24,
              color: Theme.of(context).textTheme.titleLarge?.color),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Selection Process",
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 20,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              """
When you contribute by adding fuel prices, submitting pump accuracy scale, updating station info, posting reviews, and more, you earn points.

Check the leaderboard to see the top contributors.

Every Sunday at 12:00am UTC, contributors with the highest points are chosen. In case of a tie, the user who earned the points first is selected.

The top 3 contributors receive cash prizes, awarded for 1st, 2nd, and 3rd positions.
""",
              style: TextStyle(fontSize: 13, color: Color(0xff999999)),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xffF3F3F3),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Cash Prizes for Top Contributors",
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 20,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
                text: const TextSpan(
                    text: "• First place wins ",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 13,
                        color: Color(0xff999999)),
                    children: [
                  TextSpan(
                    text: "₦",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        color: Color(0xff999999)),
                  ),
                  TextSpan(
                    text: "10,000",
                    style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 13,
                        color: Color(0xff999999)),
                  ),
                ])),
            RichText(
                text: const TextSpan(
                    text: "• Second place wins ",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 13,
                        color: Color(0xff999999)),
                    children: [
                  TextSpan(
                    text: "₦",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        color: Color(0xff999999)),
                  ),
                  TextSpan(
                    text: "6,000",
                    style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 13,
                        color: Color(0xff999999)),
                  ),
                ])),
            RichText(
                text: const TextSpan(
                    text: "• Third place wins ",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 13,
                        color: Color(0xff999999)),
                    children: [
                  TextSpan(
                    text: "₦",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        color: Color(0xff999999)),
                  ),
                  TextSpan(
                    text: "4,000",
                    style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 13,
                        color: Color(0xff999999)),
                  ),
                ])),
            const SizedBox(
              height: 25,
            ),
            Text(
              "How to participate",
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 20,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              """
To participate in the weekly raffle, begin by accumulating points through contributions. Once you've reached the minimum point threshold, access the raffle entry button on the leaderboard page.

To boost your winning odds, you can enter the raffle multiple times based on your earned points.
""",
              style: TextStyle(fontSize: 13, color: Color(0xff999999)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Claiming your reward",
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 20,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              """
After winning a challenge, your victory notification will appear in the app's rewards section.

To claim your cash prize, you must accept the award and provide your bank account details for payment. It's essential that the name on the bank account matches the user's name associated with the FuelAlert account.

Winners have until the following Friday to claim their prizes. Unclaimed prizes after this period will be forfeited automatically.

Winners have the option to either claim or forfeit their prize.
""",
              style: TextStyle(fontSize: 13, color: Color(0xff999999)),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        )),
      ),
    );
  }
}
