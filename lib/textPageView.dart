import 'package:flutter/material.dart';
import 'package:page_split/logic/widget_size.dart';
import 'package:provider/provider.dart';
import 'blocs/pageControlProvider.dart';
import 'constant.dart';

class TextPageView extends StatelessWidget {
  TextPageView({Key key}) : super(key: key);

  final PageController _pageController = PageController();
  final TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 25);

  @override
  Widget build(BuildContext context) {
    final controlProvider = Provider.of<PageControlProvider>(context);

    return Column(
      children: [
        WidgetSize(
            onChange: (Size size) {
              controlProvider.updateSize(size);
              controlProvider.getSplittedTextFromBloc(_textStyle);
            },
            child: Expanded(
              child: Container(
                color: Colors.yellowAccent.withOpacity(0.2),
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (val) {
                      controlProvider.currentIndex = val;
                    },
                    itemCount: controlProvider.splittedTextList.length,
                    itemBuilder: (context, index) {
                      return Text(
                        controlProvider.splittedTextList[index],
                        style: _textStyle,
                      );
                    }),
              ),
            )),
        _pageControll(context)
      ],
    );
  }

  Widget _pageControll(BuildContext context) {
    final int _length =
        Provider.of<PageControlProvider>(context).splittedTextList.length;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(Icons.first_page),
              onPressed: () {
                _pageController.animateToPage(0,
                    duration: kDuration, curve: kCurve);
              }),
          IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              _pageController.previousPage(duration: kDuration, curve: kCurve);
            },
          ),
          Text(
            '${Provider.of<PageControlProvider>(context).currentIndex + 1}/$_length',
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              _pageController.nextPage(duration: kDuration, curve: kCurve);
            },
          ),
          IconButton(
            icon: Icon(Icons.last_page),
            onPressed: () {
              _pageController.animateToPage(_length,
                  duration: kDuration, curve: kCurve);
            },
          ),
        ],
      ),
    );
  }
}
