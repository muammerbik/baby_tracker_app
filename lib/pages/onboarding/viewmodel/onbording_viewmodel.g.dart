// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onbording_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingViewModel on _OnboardingViewModelBase, Store {
  late final _$isOnboardingCompletedAtom = Atom(
      name: '_OnboardingViewModelBase.isOnboardingCompleted', context: context);

  @override
  bool get isOnboardingCompleted {
    _$isOnboardingCompletedAtom.reportRead();
    return super.isOnboardingCompleted;
  }

  @override
  set isOnboardingCompleted(bool value) {
    _$isOnboardingCompletedAtom.reportWrite(value, super.isOnboardingCompleted,
        () {
      super.isOnboardingCompleted = value;
    });
  }

  late final _$pageControllerAtom =
      Atom(name: '_OnboardingViewModelBase.pageController', context: context);

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: '_OnboardingViewModelBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$notGoBackAtom =
      Atom(name: '_OnboardingViewModelBase.notGoBack', context: context);

  @override
  bool get notGoBack {
    _$notGoBackAtom.reportRead();
    return super.notGoBack;
  }

  @override
  set notGoBack(bool value) {
    _$notGoBackAtom.reportWrite(value, super.notGoBack, () {
      super.notGoBack = value;
    });
  }

  late final _$onboardingListAtom =
      Atom(name: '_OnboardingViewModelBase.onboardingList', context: context);

  @override
  List<OnboardingModel> get onboardingList {
    _$onboardingListAtom.reportRead();
    return super.onboardingList;
  }

  @override
  set onboardingList(List<OnboardingModel> value) {
    _$onboardingListAtom.reportWrite(value, super.onboardingList, () {
      super.onboardingList = value;
    });
  }

  late final _$onboardingCompletedSetAsyncAction = AsyncAction(
      '_OnboardingViewModelBase.onboardingCompletedSet',
      context: context);

  @override
  Future<void> onboardingCompletedSet() {
    return _$onboardingCompletedSetAsyncAction
        .run(() => super.onboardingCompletedSet());
  }

  late final _$onboardingCompletedGetAsyncAction = AsyncAction(
      '_OnboardingViewModelBase.onboardingCompletedGet',
      context: context);

  @override
  Future<void> onboardingCompletedGet() {
    return _$onboardingCompletedGetAsyncAction
        .run(() => super.onboardingCompletedGet());
  }

  late final _$_OnboardingViewModelBaseActionController =
      ActionController(name: '_OnboardingViewModelBase', context: context);

  @override
  void onPageChanged(int value) {
    final _$actionInfo = _$_OnboardingViewModelBaseActionController.startAction(
        name: '_OnboardingViewModelBase.onPageChanged');
    try {
      return super.onPageChanged(value);
    } finally {
      _$_OnboardingViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void continueButtonTapped() {
    final _$actionInfo = _$_OnboardingViewModelBaseActionController.startAction(
        name: '_OnboardingViewModelBase.continueButtonTapped');
    try {
      return super.continueButtonTapped();
    } finally {
      _$_OnboardingViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isOnboardingCompleted: ${isOnboardingCompleted},
pageController: ${pageController},
currentIndex: ${currentIndex},
notGoBack: ${notGoBack},
onboardingList: ${onboardingList}
    ''';
  }
}
