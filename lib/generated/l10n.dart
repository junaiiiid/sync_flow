// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `POWERED BY`
  String get poweredBy {
    return Intl.message(
      'POWERED BY',
      name: 'poweredBy',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `App Type`
  String get appType {
    return Intl.message(
      'App Type',
      name: 'appType',
      desc: '',
      args: [],
    );
  }

  /// `Simple`
  String get simple {
    return Intl.message(
      'Simple',
      name: 'simple',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `NO PROJECTS FOUND`
  String get noProjectsFound {
    return Intl.message(
      'NO PROJECTS FOUND',
      name: 'noProjectsFound',
      desc: '',
      args: [],
    );
  }

  /// `CREATE NEW`
  String get createNew {
    return Intl.message(
      'CREATE NEW',
      name: 'createNew',
      desc: '',
      args: [],
    );
  }

  /// `id`
  String get id {
    return Intl.message(
      'id',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Board`
  String get board {
    return Intl.message(
      'Board',
      name: 'board',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `NEW PROJECT`
  String get newProject {
    return Intl.message(
      'NEW PROJECT',
      name: 'newProject',
      desc: '',
      args: [],
    );
  }

  /// `Enter Project Name:`
  String get enterProjectName {
    return Intl.message(
      'Enter Project Name:',
      name: 'enterProjectName',
      desc: '',
      args: [],
    );
  }

  /// `eg My Project`
  String get egMyProject {
    return Intl.message(
      'eg My Project',
      name: 'egMyProject',
      desc: '',
      args: [],
    );
  }

  /// `Select Project Color`
  String get selectProjectColor {
    return Intl.message(
      'Select Project Color',
      name: 'selectProjectColor',
      desc: '',
      args: [],
    );
  }

  /// `eg red`
  String get egRed {
    return Intl.message(
      'eg red',
      name: 'egRed',
      desc: '',
      args: [],
    );
  }

  /// `Choose Kanban Sections`
  String get chooseKanbanSections {
    return Intl.message(
      'Choose Kanban Sections',
      name: 'chooseKanbanSections',
      desc: '',
      args: [],
    );
  }

  /// `Select 1st Section`
  String get select1stSection {
    return Intl.message(
      'Select 1st Section',
      name: 'select1stSection',
      desc: '',
      args: [],
    );
  }

  /// `eg first label`
  String get egFirstLabel {
    return Intl.message(
      'eg first label',
      name: 'egFirstLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select 2nd Section`
  String get select2ndSection {
    return Intl.message(
      'Select 2nd Section',
      name: 'select2ndSection',
      desc: '',
      args: [],
    );
  }

  /// `eg second label`
  String get egSecondLabel {
    return Intl.message(
      'eg second label',
      name: 'egSecondLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select 3rd Section`
  String get select3rdSection {
    return Intl.message(
      'Select 3rd Section',
      name: 'select3rdSection',
      desc: '',
      args: [],
    );
  }

  /// `eg third label`
  String get egThirdLabel {
    return Intl.message(
      'eg third label',
      name: 'egThirdLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Labels`
  String get labels {
    return Intl.message(
      'Labels',
      name: 'labels',
      desc: '',
      args: [],
    );
  }

  /// `NO LABELS FOUND`
  String get noLabelsFound {
    return Intl.message(
      'NO LABELS FOUND',
      name: 'noLabelsFound',
      desc: '',
      args: [],
    );
  }

  /// `NEW LABEL`
  String get newLabel {
    return Intl.message(
      'NEW LABEL',
      name: 'newLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Label Name:`
  String get enterLabelName {
    return Intl.message(
      'Enter Label Name:',
      name: 'enterLabelName',
      desc: '',
      args: [],
    );
  }

  /// `eg TO-DO`
  String get egTodo {
    return Intl.message(
      'eg TO-DO',
      name: 'egTodo',
      desc: '',
      args: [],
    );
  }

  /// `Select Label Color`
  String get selectLabelColor {
    return Intl.message(
      'Select Label Color',
      name: 'selectLabelColor',
      desc: '',
      args: [],
    );
  }

  /// `Please wait...`
  String get pleaseWait {
    return Intl.message(
      'Please wait...',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Total Comments`
  String get totalComments {
    return Intl.message(
      'Total Comments',
      name: 'totalComments',
      desc: '',
      args: [],
    );
  }

  /// `ADD A COMMENT`
  String get addAComment {
    return Intl.message(
      'ADD A COMMENT',
      name: 'addAComment',
      desc: '',
      args: [],
    );
  }

  /// `NO COMMENTS FOUND`
  String get noCommentsFound {
    return Intl.message(
      'NO COMMENTS FOUND',
      name: 'noCommentsFound',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Project`
  String get selectYourProject {
    return Intl.message(
      'Select Your Project',
      name: 'selectYourProject',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Task`
  String get selectYourTask {
    return Intl.message(
      'Select Your Task',
      name: 'selectYourTask',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Comment`
  String get addYourComment {
    return Intl.message(
      'Add Your Comment',
      name: 'addYourComment',
      desc: '',
      args: [],
    );
  }

  /// `eg This is a comment.`
  String get egThisIsAComment {
    return Intl.message(
      'eg This is a comment.',
      name: 'egThisIsAComment',
      desc: '',
      args: [],
    );
  }

  /// `PUBLISH`
  String get publish {
    return Intl.message(
      'PUBLISH',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `TASK`
  String get task {
    return Intl.message(
      'TASK',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Create New Task`
  String get createNewTask {
    return Intl.message(
      'Create New Task',
      name: 'createNewTask',
      desc: '',
      args: [],
    );
  }

  /// `Enter Task Title`
  String get enterTaskTitle {
    return Intl.message(
      'Enter Task Title',
      name: 'enterTaskTitle',
      desc: '',
      args: [],
    );
  }

  /// `eg Task title`
  String get egTaskTitle {
    return Intl.message(
      'eg Task title',
      name: 'egTaskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Task Description`
  String get enterTaskDescription {
    return Intl.message(
      'Enter Task Description',
      name: 'enterTaskDescription',
      desc: '',
      args: [],
    );
  }

  /// `eg Task Description`
  String get egTaskDescription {
    return Intl.message(
      'eg Task Description',
      name: 'egTaskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter A Label`
  String get enterALabel {
    return Intl.message(
      'Enter A Label',
      name: 'enterALabel',
      desc: '',
      args: [],
    );
  }

  /// `eg Label Name`
  String get egLabelName {
    return Intl.message(
      'eg Label Name',
      name: 'egLabelName',
      desc: '',
      args: [],
    );
  }

  /// `Select A Label`
  String get selectALabel {
    return Intl.message(
      'Select A Label',
      name: 'selectALabel',
      desc: '',
      args: [],
    );
  }

  /// `eg My label`
  String get egMyLabel {
    return Intl.message(
      'eg My label',
      name: 'egMyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select Due Date`
  String get selectDueDate {
    return Intl.message(
      'Select Due Date',
      name: 'selectDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select a due date`
  String get tapToSelectADueDate {
    return Intl.message(
      'Tap to select a due date',
      name: 'tapToSelectADueDate',
      desc: '',
      args: [],
    );
  }

  /// `CREATE TASK`
  String get createTask {
    return Intl.message(
      'CREATE TASK',
      name: 'createTask',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Your Project`
  String get pleaseSelectYourProject {
    return Intl.message(
      'Please Select Your Project',
      name: 'pleaseSelectYourProject',
      desc: '',
      args: [],
    );
  }

  /// `View Attachment`
  String get viewAttachment {
    return Intl.message(
      'View Attachment',
      name: 'viewAttachment',
      desc: '',
      args: [],
    );
  }

  /// `Edit Comment`
  String get editComment {
    return Intl.message(
      'Edit Comment',
      name: 'editComment',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task Title`
  String get editTaskTitle {
    return Intl.message(
      'Edit Task Title',
      name: 'editTaskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task Description`
  String get editTaskDescription {
    return Intl.message(
      'Edit Task Description',
      name: 'editTaskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Move To`
  String get moveTo {
    return Intl.message(
      'Move To',
      name: 'moveTo',
      desc: '',
      args: [],
    );
  }

  /// `eg Choose where to move`
  String get egChooseWhereToMove {
    return Intl.message(
      'eg Choose where to move',
      name: 'egChooseWhereToMove',
      desc: '',
      args: [],
    );
  }

  /// `SAVE CHANGES`
  String get saveChanges {
    return Intl.message(
      'SAVE CHANGES',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `write something...`
  String get writeSomething {
    return Intl.message(
      'write something...',
      name: 'writeSomething',
      desc: '',
      args: [],
    );
  }

  /// `NO TASKS FOUND`
  String get noTasksFound {
    return Intl.message(
      'NO TASKS FOUND',
      name: 'noTasksFound',
      desc: '',
      args: [],
    );
  }

  /// `Select a Project`
  String get selectAProject {
    return Intl.message(
      'Select a Project',
      name: 'selectAProject',
      desc: '',
      args: [],
    );
  }

  /// `A`
  String get a {
    return Intl.message(
      'A',
      name: 'a',
      desc: '',
      args: [],
    );
  }

  /// `B`
  String get b {
    return Intl.message(
      'B',
      name: 'b',
      desc: '',
      args: [],
    );
  }

  /// `This field can not be empty`
  String get thisFieldCanNotBeEmpty {
    return Intl.message(
      'This field can not be empty',
      name: 'thisFieldCanNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `ERROR`
  String get error {
    return Intl.message(
      'ERROR',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `SUCCESS`
  String get success {
    return Intl.message(
      'SUCCESS',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Please select an option`
  String get pleaseSelectAnOption {
    return Intl.message(
      'Please select an option',
      name: 'pleaseSelectAnOption',
      desc: '',
      args: [],
    );
  }

  /// `color`
  String get color {
    return Intl.message(
      'color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `url`
  String get url {
    return Intl.message(
      'url',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `viewStyle`
  String get viewstyle {
    return Intl.message(
      'viewStyle',
      name: 'viewstyle',
      desc: '',
      args: [],
    );
  }

  /// `is_favorite`
  String get isfavorite {
    return Intl.message(
      'is_favorite',
      name: 'isfavorite',
      desc: '',
      args: [],
    );
  }

  /// `projectId`
  String get projectid {
    return Intl.message(
      'projectId',
      name: 'projectid',
      desc: '',
      args: [],
    );
  }

  /// `content`
  String get content {
    return Intl.message(
      'content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `posted_at`
  String get postedat {
    return Intl.message(
      'posted_at',
      name: 'postedat',
      desc: '',
      args: [],
    );
  }

  /// `Comment can not be empty.`
  String get commentCanNotBeEmpty {
    return Intl.message(
      'Comment can not be empty.',
      name: 'commentCanNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The fields can not be empty.`
  String get theFieldsCanNotBeEmpty {
    return Intl.message(
      'The fields can not be empty.',
      name: 'theFieldsCanNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `do`
  String get doKey {
    return Intl.message(
      'do',
      name: 'doKey',
      desc: '',
      args: [],
    );
  }

  /// `progress`
  String get progress {
    return Intl.message(
      'progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `complete`
  String get complete {
    return Intl.message(
      'complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Create Default Sections`
  String get createDefaultSections {
    return Intl.message(
      'Create Default Sections',
      name: 'createDefaultSections',
      desc: '',
      args: [],
    );
  }

  /// `Create Sections From Labels`
  String get createSectionsFromLabels {
    return Intl.message(
      'Create Sections From Labels',
      name: 'createSectionsFromLabels',
      desc: '',
      args: [],
    );
  }

  /// `TO-DO`
  String get todo {
    return Intl.message(
      'TO-DO',
      name: 'todo',
      desc: '',
      args: [],
    );
  }

  /// `IN-PROGRESS`
  String get inprogress {
    return Intl.message(
      'IN-PROGRESS',
      name: 'inprogress',
      desc: '',
      args: [],
    );
  }

  /// `COMPLETED`
  String get completed {
    return Intl.message(
      'COMPLETED',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `berry_red`
  String get berryred {
    return Intl.message(
      'berry_red',
      name: 'berryred',
      desc: '',
      args: [],
    );
  }

  /// `red`
  String get red {
    return Intl.message(
      'red',
      name: 'red',
      desc: '',
      args: [],
    );
  }

  /// `orange`
  String get orange {
    return Intl.message(
      'orange',
      name: 'orange',
      desc: '',
      args: [],
    );
  }

  /// `yellow`
  String get yellow {
    return Intl.message(
      'yellow',
      name: 'yellow',
      desc: '',
      args: [],
    );
  }

  /// `olive_green`
  String get olivegreen {
    return Intl.message(
      'olive_green',
      name: 'olivegreen',
      desc: '',
      args: [],
    );
  }

  /// `lime_green`
  String get limegreen {
    return Intl.message(
      'lime_green',
      name: 'limegreen',
      desc: '',
      args: [],
    );
  }

  /// `green`
  String get green {
    return Intl.message(
      'green',
      name: 'green',
      desc: '',
      args: [],
    );
  }

  /// `mint_green`
  String get mintgreen {
    return Intl.message(
      'mint_green',
      name: 'mintgreen',
      desc: '',
      args: [],
    );
  }

  /// `teal`
  String get teal {
    return Intl.message(
      'teal',
      name: 'teal',
      desc: '',
      args: [],
    );
  }

  /// `sky_blue`
  String get skyblue {
    return Intl.message(
      'sky_blue',
      name: 'skyblue',
      desc: '',
      args: [],
    );
  }

  /// `light_blue`
  String get lightblue {
    return Intl.message(
      'light_blue',
      name: 'lightblue',
      desc: '',
      args: [],
    );
  }

  /// `blue`
  String get blue {
    return Intl.message(
      'blue',
      name: 'blue',
      desc: '',
      args: [],
    );
  }

  /// `grape`
  String get grape {
    return Intl.message(
      'grape',
      name: 'grape',
      desc: '',
      args: [],
    );
  }

  /// `violet`
  String get violet {
    return Intl.message(
      'violet',
      name: 'violet',
      desc: '',
      args: [],
    );
  }

  /// `lavender`
  String get lavender {
    return Intl.message(
      'lavender',
      name: 'lavender',
      desc: '',
      args: [],
    );
  }

  /// `magenta`
  String get magenta {
    return Intl.message(
      'magenta',
      name: 'magenta',
      desc: '',
      args: [],
    );
  }

  /// `salmon`
  String get salmon {
    return Intl.message(
      'salmon',
      name: 'salmon',
      desc: '',
      args: [],
    );
  }

  /// `charcoal`
  String get charcoal {
    return Intl.message(
      'charcoal',
      name: 'charcoal',
      desc: '',
      args: [],
    );
  }

  /// `grey`
  String get grey {
    return Intl.message(
      'grey',
      name: 'grey',
      desc: '',
      args: [],
    );
  }

  /// `taupe`
  String get taupe {
    return Intl.message(
      'taupe',
      name: 'taupe',
      desc: '',
      args: [],
    );
  }

  /// `false`
  String get falseKey {
    return Intl.message(
      'false',
      name: 'falseKey',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get projects {
    return Intl.message(
      'Projects',
      name: 'projects',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `View all the tasks you have to start.`
  String get viewAllTheTasksYouHaveToStart {
    return Intl.message(
      'View all the tasks you have to start.',
      name: 'viewAllTheTasksYouHaveToStart',
      desc: '',
      args: [],
    );
  }

  /// `View all the tasks you are working on.`
  String get viewAllTheTasksYouAreWorkingOn {
    return Intl.message(
      'View all the tasks you are working on.',
      name: 'viewAllTheTasksYouAreWorkingOn',
      desc: '',
      args: [],
    );
  }

  /// `View all the tasks you have completed.`
  String get viewAllTheTasksYouHaveCompleted {
    return Intl.message(
      'View all the tasks you have completed.',
      name: 'viewAllTheTasksYouHaveCompleted',
      desc: '',
      args: [],
    );
  }

  /// `list`
  String get list {
    return Intl.message(
      'list',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Total Projects`
  String get totalProjects {
    return Intl.message(
      'Total Projects',
      name: 'totalProjects',
      desc: '',
      args: [],
    );
  }

  /// `Total Tasks`
  String get totalTasks {
    return Intl.message(
      'Total Tasks',
      name: 'totalTasks',
      desc: '',
      args: [],
    );
  }

  /// `taskId`
  String get taskid {
    return Intl.message(
      'taskId',
      name: 'taskid',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch $url`
  String get couldNotLaunchUrl {
    return Intl.message(
      'Could not launch \$url',
      name: 'couldNotLaunchUrl',
      desc: '',
      args: [],
    );
  }

  /// `section_id`
  String get sectionid {
    return Intl.message(
      'section_id',
      name: 'sectionid',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message(
      'description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `due_date`
  String get duedate {
    return Intl.message(
      'due_date',
      name: 'duedate',
      desc: '',
      args: [],
    );
  }

  /// `created_at`
  String get createdat {
    return Intl.message(
      'created_at',
      name: 'createdat',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications To Show`
  String get noNotificationsToShow {
    return Intl.message(
      'No Notifications To Show',
      name: 'noNotificationsToShow',
      desc: '',
      args: [],
    );
  }

  /// `Task Timer`
  String get taskTimer {
    return Intl.message(
      'Task Timer',
      name: 'taskTimer',
      desc: '',
      args: [],
    );
  }

  /// `ACTIVE`
  String get active {
    return Intl.message(
      'ACTIVE',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Please Create A Task`
  String get pleaseCreateATask {
    return Intl.message(
      'Please Create A Task',
      name: 'pleaseCreateATask',
      desc: '',
      args: [],
    );
  }

  /// `START TIMER`
  String get startTimer {
    return Intl.message(
      'START TIMER',
      name: 'startTimer',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
