// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calender_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalenderViewModel on _CalenderViewModelBase, Store {
  late final _$mergedListAtom =
      Atom(name: '_CalenderViewModelBase.mergedList', context: context);

  @override
  List<FeedItem> get mergedList {
    _$mergedListAtom.reportRead();
    return super.mergedList;
  }

  @override
  set mergedList(List<FeedItem> value) {
    _$mergedListAtom.reportWrite(value, super.mergedList, () {
      super.mergedList = value;
    });
  }

  late final _$allSelectedIndexAtom =
      Atom(name: '_CalenderViewModelBase.allSelectedIndex', context: context);

  @override
  int? get allSelectedIndex {
    _$allSelectedIndexAtom.reportRead();
    return super.allSelectedIndex;
  }

  @override
  set allSelectedIndex(int? value) {
    _$allSelectedIndexAtom.reportWrite(value, super.allSelectedIndex, () {
      super.allSelectedIndex = value;
    });
  }

  late final _$_CalenderViewModelBaseActionController =
      ActionController(name: '_CalenderViewModelBase', context: context);

  @override
  void updateSelectedIndex(int index) {
    final _$actionInfo = _$_CalenderViewModelBaseActionController.startAction(
        name: '_CalenderViewModelBase.updateSelectedIndex');
    try {
      return super.updateSelectedIndex(index);
    } finally {
      _$_CalenderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String capitalizeWithSuffix(String text, String suffix) {
    final _$actionInfo = _$_CalenderViewModelBaseActionController.startAction(
        name: '_CalenderViewModelBase.capitalizeWithSuffix');
    try {
      return super.capitalizeWithSuffix(text, suffix);
    } finally {
      _$_CalenderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getFormattedDate(DateTime date) {
    final _$actionInfo = _$_CalenderViewModelBaseActionController.startAction(
        name: '_CalenderViewModelBase.getFormattedDate');
    try {
      return super.getFormattedDate(date);
    } finally {
      _$_CalenderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void mergeLists() {
    final _$actionInfo = _$_CalenderViewModelBaseActionController.startAction(
        name: '_CalenderViewModelBase.mergeLists');
    try {
      return super.mergeLists();
    } finally {
      _$_CalenderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mergedList: ${mergedList},
allSelectedIndex: ${allSelectedIndex}
    ''';
  }
}
