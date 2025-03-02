// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inapp_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InAppViewModel on _InAppViewModelBase, Store {
  late final _$selectedButtonIndexAtom =
      Atom(name: '_InAppViewModelBase.selectedButtonIndex', context: context);

  @override
  int get selectedButtonIndex {
    _$selectedButtonIndexAtom.reportRead();
    return super.selectedButtonIndex;
  }

  @override
  set selectedButtonIndex(int value) {
    _$selectedButtonIndexAtom.reportWrite(value, super.selectedButtonIndex, () {
      super.selectedButtonIndex = value;
    });
  }

  late final _$isInAppCompletedAtom =
      Atom(name: '_InAppViewModelBase.isInAppCompleted', context: context);

  @override
  bool get isInAppCompleted {
    _$isInAppCompletedAtom.reportRead();
    return super.isInAppCompleted;
  }

  @override
  set isInAppCompleted(bool value) {
    _$isInAppCompletedAtom.reportWrite(value, super.isInAppCompleted, () {
      super.isInAppCompleted = value;
    });
  }

  late final _$inAppButtonTappedAsyncAction =
      AsyncAction('_InAppViewModelBase.inAppButtonTapped', context: context);

  @override
  Future<void> inAppButtonTapped(BuildContext context) {
    return _$inAppButtonTappedAsyncAction
        .run(() => super.inAppButtonTapped(context));
  }

  late final _$inAppCompletedSetAsyncAction =
      AsyncAction('_InAppViewModelBase.inAppCompletedSet', context: context);

  @override
  Future<void> inAppCompletedSet() {
    return _$inAppCompletedSetAsyncAction.run(() => super.inAppCompletedSet());
  }

  late final _$inAppCompletedGetAsyncAction =
      AsyncAction('_InAppViewModelBase.inAppCompletedGet', context: context);

  @override
  Future<void> inAppCompletedGet() {
    return _$inAppCompletedGetAsyncAction.run(() => super.inAppCompletedGet());
  }

  late final _$_InAppViewModelBaseActionController =
      ActionController(name: '_InAppViewModelBase', context: context);

  @override
  void selectPlan(int index) {
    final _$actionInfo = _$_InAppViewModelBaseActionController.startAction(
        name: '_InAppViewModelBase.selectPlan');
    try {
      return super.selectPlan(index);
    } finally {
      _$_InAppViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedButtonIndex: ${selectedButtonIndex},
isInAppCompleted: ${isInAppCompleted}
    ''';
  }
}
