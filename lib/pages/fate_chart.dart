import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

import '../model/fate_model.dart';

class FateChart extends StatefulWidget {
  const FateChart({Key? key}) : super(key: key);

  @override
  _FateChartState createState() => _FateChartState();
}

class _FateChartState extends State<FateChart> {
  int? result;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final odds = _Spiner(
      value: oddsFactor,
      labels: _oddLabels,
      onChanged: (value) => setState(() => oddsFactor = value),
    );
    final chaos = _Spiner(
      value: chaosFactor,
      labels: _chaosLabels,
      onChanged: (value) => setState(() => chaosFactor = value),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  '几率因子',
                  style: themeData.textTheme.headline6,
                ),
                Divider(),
                odds
              ]),
            ),
            Expanded(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  '混乱因子',
                  style: themeData.textTheme.headline6,
                ),
                Divider(),
                chaos
              ]),
            )
          ],
        ),
        ElevatedButton(onPressed: _generateResult, child: Text('询问')),
        if (result != null) _Result(result: result!),
      ]),
    );
  }

  void _generateResult() {
    int predict = Random(DateTime.now().millisecondsSinceEpoch).nextInt(100);
    final benchMark = _fateTable[oddsFactor][chaosFactor];
    if (predict < benchMark) {
      if (predict < benchMark / 5) {
        result = 3;
      } else {
        result = 1;
      }
    } else {
      if (predict < (80 + benchMark / 5)) {
        result = 0;
      } else {
        result = 2;
      }
    }
    predict += 1;
    if (predict ~/ 10 == predict % 10 && predict % 10 <= chaosFactor + 1) {
      result = result! | 4;
    }
    setState(() {});
  }

  static const _oddLabels = [
    '完全不可能',
    '决不可能',
    '不可能',
    '不大可能',
    '50/50',
    '有时可能',
    '可能',
    '非常可能',
    '几乎肯定',
    '肯定',
    '必须是',
  ];

  static const _chaosLabels = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  static const _fateTable = [
    [-20, 0, 0, 5, 5, 10, 15, 25, 50],
    [0, 5, 5, 10, 15, 25, 35, 50, 75],
    [5, 5, 10, 15, 25, 45, 59, 65, 85],
    [5, 10, 15, 20, 35, 50, 55, 75, 90],
    [10, 15, 25, 35, 50, 65, 75, 85, 95],
    [20, 25, 45, 50, 65, 80, 85, 90, 95],
    [25, 35, 50, 55, 75, 85, 90, 95, 100],
    [45, 50, 65, 75, 85, 90, 95, 95, 105],
    [50, 55, 75, 80, 90, 95, 95, 100, 115],
    [55, 65, 80, 85, 90, 95, 95, 110, 125],
    [80, 85, 90, 95, 95, 100, 100, 130, 145],
  ];
}

class _Spiner extends StatelessWidget {
  _Spiner(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.labels})
      : _scrollController = InfiniteScrollController(
            initialScrollOffset: (value - 1) * itemHeight),
        super(key: key) {
    _scrollController.addListener(_scrollListener);
  }

  static const itemHeight = 50.0;
  static const itemCount = 3;
  final int value;
  final void Function(int) onChanged;
  final InfiniteScrollController _scrollController;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: NotificationListener<ScrollEndNotification>(
        child: InfiniteListView.builder(
          controller: _scrollController,
          itemExtent: itemHeight,
          itemBuilder: (_, index) {
            final themeData = Theme.of(context);
            final itemValue = _valueFromIndex(index);
            return Center(
                child: Text(labels[itemValue],
                    style: itemValue == value
                        ? themeData.textTheme.headline5
                            ?.copyWith(color: themeData.accentColor)
                        : themeData.textTheme.bodyText2));
          },
        ),
        onNotification: (not) {
          if (not.dragDetails?.primaryVelocity == 0) {
            Future.microtask(() => centerize());
          }
          return true;
        },
      ),
      height: itemCount * itemHeight,
    );
  }

  void _scrollListener() {
    final newValue =
        _valueFromIndex((_scrollController.offset / itemHeight).round() + 1);
    if (newValue != value) {
      onChanged(newValue);
    }
    Future.delayed(
      Duration(milliseconds: 100),
      () => centerize(),
    );
  }

  void centerize() {
    if (_scrollController.hasClients && !_isScrolling) {
      _scrollController
          .animateTo(
              (_scrollController.offset / itemHeight).round() * itemHeight,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease)
          .then((_) => _scrollController.jumpTo((value - 1) * itemHeight));
    }
  }

  bool get _isScrolling => _scrollController.position.isScrollingNotifier.value;

  int _valueFromIndex(int value) => value % labels.length;
}

class _Result extends StatelessWidget {
  const _Result({Key? key, required this.result}) : super(key: key);

  final int result;

  @override
  Widget build(BuildContext context) {
    return Text((result & 2 != 0 ? '特殊的' : '') +
        (result & 1 != 0 ? '是' : '否') +
        (result & 4 != 0 ? '，且发生了随机事件' : ''));
  }
}
