import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';

class Examples extends StatefulWidget {
  const Examples({super.key, required this.examples, required this.onExampleChosen});

  final List<Group> examples;
  final ValueChanged<String> onExampleChosen;

  @override
  State<Examples> createState() => _ExamplesState();
}

class _ExamplesState extends State<Examples> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widget.examples.length, vsync: this, animationDuration: const Duration(milliseconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Align(
        alignment: Alignment.topLeft,
        child: TabBar(
            labelColor: DefaultThemeColors.white,
            unselectedLabelColor: DefaultThemeColors.darkGrey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: DefaultThemeColors.purple),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorWeight: 0,
            indicatorColor: Colors.transparent,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: DefaultThemeColors.purple),
            controller: _controller,
            tabs: widget.examples
                .map(
                  (e) => Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          border: Border.all(width: 1, color: DefaultThemeColors.darkGreyTransparent)),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(e.title),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
      Transform.translate(
        offset: const Offset(0, -1),
        child: _Border(
          child: SizedBox(
            height: 500,
            child: TabBarView(
              controller: _controller,
              children: widget.examples.asMap().entries.map((entry) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    children: entry.value.children
                        .asMap()
                        .entries
                        .map((child) => _Entry(
                              item: child.value,
                              onPressed: () => widget.onExampleChosen(child.value.title),
                            ))
                        .toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _Entry extends StatelessWidget {
  const _Entry({
    Key? key,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  final Item item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.exampleButtonPadding,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
          width: 1.0,
          color: DefaultThemeColors.darkGreyTransparent,
          style: BorderStyle.solid,
        )),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent, cardColor: Colors.transparent),
            child: item.description == null
                ? Wrap(
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )
                : ExpandableNotifier(
                    child: Wrap(children: [
                      ExpandableTheme(
                        // Duration.zero resulted in issues
                        data: const ExpandableThemeData(animationDuration: Duration(milliseconds: 1)),
                        child: Expandable(
                          collapsed: ExpandableWrapper(
                            icon: const Icon(
                              Icons.info,
                              color: DefaultThemeColors.purple,
                            ),
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          expanded: ExpandableWrapper(
                            icon: const Icon(
                              Icons.close,
                              color: DefaultThemeColors.purple,
                            ),
                            child: Text(
                              item.titleWithDescription,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
          ),
        ),
      ),
    );
  }
}

class _Border extends StatelessWidget {
  final Widget child;

  const _Border({Key? key, required this.child}) : super(key: key);

  static const _borderColor = DefaultThemeColors.darkGreyTransparent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(0, 240, 242, 245),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
          border: Border(
            left: BorderSide(width: 1, color: _borderColor),
            right: BorderSide(width: 1, color: _borderColor),
            top: BorderSide(width: 1, color: _borderColor),
            bottom: BorderSide(width: 1, color: _borderColor),
          ),
        ),
        child: child);
  }
}

class ExpandableWrapper extends StatelessWidget {
  final Widget child;
  final Icon icon;

  const ExpandableWrapper({Key? key, required this.child, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Wrap(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [child],
            ),
          ),
          ExpandableButton(child: icon),
        ],
      ),
    );
  }
}
