/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the UserReport type in your schema. */
class UserReport extends amplify_core.Model {
  static const classType = const _UserReportModelType();
  final String id;
  final String? _userId;
  final PostStatus? _status;
  final FeedbackStatus? _feedbackStatus;
  final String? _videoUrl;
  final String? _commentsByDoctor;
  final bool? _heartDisease;
  final bool? _everHadAStroke;
  final bool? _experienceChestPainsFrequently;
  final bool? _sufferHighBloodPressure;
  final bool? _familyHistoryHeartDisease;
  final String? _skinColor;
  final bool? _smoke;
  final String? _heartRate;
  final String? _breathingRate;
  final String? _JugularVeinHeight;
  final String? _ImageOfDetectedResultUrl;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserReportModelIdentifier get modelIdentifier {
      return UserReportModelIdentifier(
        id: id
      );
  }
  
  String get userId {
    try {
      return _userId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  PostStatus get status {
    try {
      return _status!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  FeedbackStatus? get feedbackStatus {
    return _feedbackStatus;
  }
  
  String get videoUrl {
    try {
      return _videoUrl!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get commentsByDoctor {
    return _commentsByDoctor;
  }
  
  bool get heartDisease {
    try {
      return _heartDisease!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get everHadAStroke {
    try {
      return _everHadAStroke!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get experienceChestPainsFrequently {
    try {
      return _experienceChestPainsFrequently!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get sufferHighBloodPressure {
    try {
      return _sufferHighBloodPressure!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get familyHistoryHeartDisease {
    try {
      return _familyHistoryHeartDisease!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get skinColor {
    try {
      return _skinColor!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get smoke {
    try {
      return _smoke!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get heartRate {
    return _heartRate;
  }
  
  String? get breathingRate {
    return _breathingRate;
  }
  
  String? get JugularVeinHeight {
    return _JugularVeinHeight;
  }
  
  String? get ImageOfDetectedResultUrl {
    return _ImageOfDetectedResultUrl;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserReport._internal({required this.id, required userId, required status, feedbackStatus, required videoUrl, commentsByDoctor, required heartDisease, required everHadAStroke, required experienceChestPainsFrequently, required sufferHighBloodPressure, required familyHistoryHeartDisease, required skinColor, required smoke, heartRate, breathingRate, JugularVeinHeight, ImageOfDetectedResultUrl, createdAt, updatedAt}): _userId = userId, _status = status, _feedbackStatus = feedbackStatus, _videoUrl = videoUrl, _commentsByDoctor = commentsByDoctor, _heartDisease = heartDisease, _everHadAStroke = everHadAStroke, _experienceChestPainsFrequently = experienceChestPainsFrequently, _sufferHighBloodPressure = sufferHighBloodPressure, _familyHistoryHeartDisease = familyHistoryHeartDisease, _skinColor = skinColor, _smoke = smoke, _heartRate = heartRate, _breathingRate = breathingRate, _JugularVeinHeight = JugularVeinHeight, _ImageOfDetectedResultUrl = ImageOfDetectedResultUrl, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserReport({String? id, required String userId, required PostStatus status, FeedbackStatus? feedbackStatus, required String videoUrl, String? commentsByDoctor, required bool heartDisease, required bool everHadAStroke, required bool experienceChestPainsFrequently, required bool sufferHighBloodPressure, required bool familyHistoryHeartDisease, required String skinColor, required bool smoke, String? heartRate, String? breathingRate, String? JugularVeinHeight, String? ImageOfDetectedResultUrl}) {
    return UserReport._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      userId: userId,
      status: status,
      feedbackStatus: feedbackStatus,
      videoUrl: videoUrl,
      commentsByDoctor: commentsByDoctor,
      heartDisease: heartDisease,
      everHadAStroke: everHadAStroke,
      experienceChestPainsFrequently: experienceChestPainsFrequently,
      sufferHighBloodPressure: sufferHighBloodPressure,
      familyHistoryHeartDisease: familyHistoryHeartDisease,
      skinColor: skinColor,
      smoke: smoke,
      heartRate: heartRate,
      breathingRate: breathingRate,
      JugularVeinHeight: JugularVeinHeight,
      ImageOfDetectedResultUrl: ImageOfDetectedResultUrl);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserReport &&
      id == other.id &&
      _userId == other._userId &&
      _status == other._status &&
      _feedbackStatus == other._feedbackStatus &&
      _videoUrl == other._videoUrl &&
      _commentsByDoctor == other._commentsByDoctor &&
      _heartDisease == other._heartDisease &&
      _everHadAStroke == other._everHadAStroke &&
      _experienceChestPainsFrequently == other._experienceChestPainsFrequently &&
      _sufferHighBloodPressure == other._sufferHighBloodPressure &&
      _familyHistoryHeartDisease == other._familyHistoryHeartDisease &&
      _skinColor == other._skinColor &&
      _smoke == other._smoke &&
      _heartRate == other._heartRate &&
      _breathingRate == other._breathingRate &&
      _JugularVeinHeight == other._JugularVeinHeight &&
      _ImageOfDetectedResultUrl == other._ImageOfDetectedResultUrl;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserReport {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("status=" + (_status != null ? amplify_core.enumToString(_status)! : "null") + ", ");
    buffer.write("feedbackStatus=" + (_feedbackStatus != null ? amplify_core.enumToString(_feedbackStatus)! : "null") + ", ");
    buffer.write("videoUrl=" + "$_videoUrl" + ", ");
    buffer.write("commentsByDoctor=" + "$_commentsByDoctor" + ", ");
    buffer.write("heartDisease=" + (_heartDisease != null ? _heartDisease!.toString() : "null") + ", ");
    buffer.write("everHadAStroke=" + (_everHadAStroke != null ? _everHadAStroke!.toString() : "null") + ", ");
    buffer.write("experienceChestPainsFrequently=" + (_experienceChestPainsFrequently != null ? _experienceChestPainsFrequently!.toString() : "null") + ", ");
    buffer.write("sufferHighBloodPressure=" + (_sufferHighBloodPressure != null ? _sufferHighBloodPressure!.toString() : "null") + ", ");
    buffer.write("familyHistoryHeartDisease=" + (_familyHistoryHeartDisease != null ? _familyHistoryHeartDisease!.toString() : "null") + ", ");
    buffer.write("skinColor=" + "$_skinColor" + ", ");
    buffer.write("smoke=" + (_smoke != null ? _smoke!.toString() : "null") + ", ");
    buffer.write("heartRate=" + "$_heartRate" + ", ");
    buffer.write("breathingRate=" + "$_breathingRate" + ", ");
    buffer.write("JugularVeinHeight=" + "$_JugularVeinHeight" + ", ");
    buffer.write("ImageOfDetectedResultUrl=" + "$_ImageOfDetectedResultUrl" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserReport copyWith({String? userId, PostStatus? status, FeedbackStatus? feedbackStatus, String? videoUrl, String? commentsByDoctor, bool? heartDisease, bool? everHadAStroke, bool? experienceChestPainsFrequently, bool? sufferHighBloodPressure, bool? familyHistoryHeartDisease, String? skinColor, bool? smoke, String? heartRate, String? breathingRate, String? JugularVeinHeight, String? ImageOfDetectedResultUrl}) {
    return UserReport._internal(
      id: id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      feedbackStatus: feedbackStatus ?? this.feedbackStatus,
      videoUrl: videoUrl ?? this.videoUrl,
      commentsByDoctor: commentsByDoctor ?? this.commentsByDoctor,
      heartDisease: heartDisease ?? this.heartDisease,
      everHadAStroke: everHadAStroke ?? this.everHadAStroke,
      experienceChestPainsFrequently: experienceChestPainsFrequently ?? this.experienceChestPainsFrequently,
      sufferHighBloodPressure: sufferHighBloodPressure ?? this.sufferHighBloodPressure,
      familyHistoryHeartDisease: familyHistoryHeartDisease ?? this.familyHistoryHeartDisease,
      skinColor: skinColor ?? this.skinColor,
      smoke: smoke ?? this.smoke,
      heartRate: heartRate ?? this.heartRate,
      breathingRate: breathingRate ?? this.breathingRate,
      JugularVeinHeight: JugularVeinHeight ?? this.JugularVeinHeight,
      ImageOfDetectedResultUrl: ImageOfDetectedResultUrl ?? this.ImageOfDetectedResultUrl);
  }
  
  UserReport copyWithModelFieldValues({
    ModelFieldValue<String>? userId,
    ModelFieldValue<PostStatus>? status,
    ModelFieldValue<FeedbackStatus?>? feedbackStatus,
    ModelFieldValue<String>? videoUrl,
    ModelFieldValue<String?>? commentsByDoctor,
    ModelFieldValue<bool>? heartDisease,
    ModelFieldValue<bool>? everHadAStroke,
    ModelFieldValue<bool>? experienceChestPainsFrequently,
    ModelFieldValue<bool>? sufferHighBloodPressure,
    ModelFieldValue<bool>? familyHistoryHeartDisease,
    ModelFieldValue<String>? skinColor,
    ModelFieldValue<bool>? smoke,
    ModelFieldValue<String?>? heartRate,
    ModelFieldValue<String?>? breathingRate,
    ModelFieldValue<String?>? JugularVeinHeight,
    ModelFieldValue<String?>? ImageOfDetectedResultUrl
  }) {
    return UserReport._internal(
      id: id,
      userId: userId == null ? this.userId : userId.value,
      status: status == null ? this.status : status.value,
      feedbackStatus: feedbackStatus == null ? this.feedbackStatus : feedbackStatus.value,
      videoUrl: videoUrl == null ? this.videoUrl : videoUrl.value,
      commentsByDoctor: commentsByDoctor == null ? this.commentsByDoctor : commentsByDoctor.value,
      heartDisease: heartDisease == null ? this.heartDisease : heartDisease.value,
      everHadAStroke: everHadAStroke == null ? this.everHadAStroke : everHadAStroke.value,
      experienceChestPainsFrequently: experienceChestPainsFrequently == null ? this.experienceChestPainsFrequently : experienceChestPainsFrequently.value,
      sufferHighBloodPressure: sufferHighBloodPressure == null ? this.sufferHighBloodPressure : sufferHighBloodPressure.value,
      familyHistoryHeartDisease: familyHistoryHeartDisease == null ? this.familyHistoryHeartDisease : familyHistoryHeartDisease.value,
      skinColor: skinColor == null ? this.skinColor : skinColor.value,
      smoke: smoke == null ? this.smoke : smoke.value,
      heartRate: heartRate == null ? this.heartRate : heartRate.value,
      breathingRate: breathingRate == null ? this.breathingRate : breathingRate.value,
      JugularVeinHeight: JugularVeinHeight == null ? this.JugularVeinHeight : JugularVeinHeight.value,
      ImageOfDetectedResultUrl: ImageOfDetectedResultUrl == null ? this.ImageOfDetectedResultUrl : ImageOfDetectedResultUrl.value
    );
  }
  
  UserReport.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userId = json['userId'],
      _status = amplify_core.enumFromString<PostStatus>(json['status'], PostStatus.values),
      _feedbackStatus = amplify_core.enumFromString<FeedbackStatus>(json['feedbackStatus'], FeedbackStatus.values),
      _videoUrl = json['videoUrl'],
      _commentsByDoctor = json['commentsByDoctor'],
      _heartDisease = json['heartDisease'],
      _everHadAStroke = json['everHadAStroke'],
      _experienceChestPainsFrequently = json['experienceChestPainsFrequently'],
      _sufferHighBloodPressure = json['sufferHighBloodPressure'],
      _familyHistoryHeartDisease = json['familyHistoryHeartDisease'],
      _skinColor = json['skinColor'],
      _smoke = json['smoke'],
      _heartRate = json['heartRate'],
      _breathingRate = json['breathingRate'],
      _JugularVeinHeight = json['JugularVeinHeight'],
      _ImageOfDetectedResultUrl = json['ImageOfDetectedResultUrl'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userId': _userId, 'status': amplify_core.enumToString(_status), 'feedbackStatus': amplify_core.enumToString(_feedbackStatus), 'videoUrl': _videoUrl, 'commentsByDoctor': _commentsByDoctor, 'heartDisease': _heartDisease, 'everHadAStroke': _everHadAStroke, 'experienceChestPainsFrequently': _experienceChestPainsFrequently, 'sufferHighBloodPressure': _sufferHighBloodPressure, 'familyHistoryHeartDisease': _familyHistoryHeartDisease, 'skinColor': _skinColor, 'smoke': _smoke, 'heartRate': _heartRate, 'breathingRate': _breathingRate, 'JugularVeinHeight': _JugularVeinHeight, 'ImageOfDetectedResultUrl': _ImageOfDetectedResultUrl, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'userId': _userId,
    'status': _status,
    'feedbackStatus': _feedbackStatus,
    'videoUrl': _videoUrl,
    'commentsByDoctor': _commentsByDoctor,
    'heartDisease': _heartDisease,
    'everHadAStroke': _everHadAStroke,
    'experienceChestPainsFrequently': _experienceChestPainsFrequently,
    'sufferHighBloodPressure': _sufferHighBloodPressure,
    'familyHistoryHeartDisease': _familyHistoryHeartDisease,
    'skinColor': _skinColor,
    'smoke': _smoke,
    'heartRate': _heartRate,
    'breathingRate': _breathingRate,
    'JugularVeinHeight': _JugularVeinHeight,
    'ImageOfDetectedResultUrl': _ImageOfDetectedResultUrl,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UserReportModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UserReportModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USERID = amplify_core.QueryField(fieldName: "userId");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static final FEEDBACKSTATUS = amplify_core.QueryField(fieldName: "feedbackStatus");
  static final VIDEOURL = amplify_core.QueryField(fieldName: "videoUrl");
  static final COMMENTSBYDOCTOR = amplify_core.QueryField(fieldName: "commentsByDoctor");
  static final HEARTDISEASE = amplify_core.QueryField(fieldName: "heartDisease");
  static final EVERHADASTROKE = amplify_core.QueryField(fieldName: "everHadAStroke");
  static final EXPERIENCECHESTPAINSFREQUENTLY = amplify_core.QueryField(fieldName: "experienceChestPainsFrequently");
  static final SUFFERHIGHBLOODPRESSURE = amplify_core.QueryField(fieldName: "sufferHighBloodPressure");
  static final FAMILYHISTORYHEARTDISEASE = amplify_core.QueryField(fieldName: "familyHistoryHeartDisease");
  static final SKINCOLOR = amplify_core.QueryField(fieldName: "skinColor");
  static final SMOKE = amplify_core.QueryField(fieldName: "smoke");
  static final HEARTRATE = amplify_core.QueryField(fieldName: "heartRate");
  static final BREATHINGRATE = amplify_core.QueryField(fieldName: "breathingRate");
  static final JUGULARVEINHEIGHT = amplify_core.QueryField(fieldName: "JugularVeinHeight");
  static final IMAGEOFDETECTEDRESULTURL = amplify_core.QueryField(fieldName: "ImageOfDetectedResultUrl");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserReport";
    modelSchemaDefinition.pluralName = "UserReports";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.USERID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.STATUS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.FEEDBACKSTATUS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.VIDEOURL,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.COMMENTSBYDOCTOR,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.HEARTDISEASE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.EVERHADASTROKE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.EXPERIENCECHESTPAINSFREQUENTLY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.SUFFERHIGHBLOODPRESSURE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.FAMILYHISTORYHEARTDISEASE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.SKINCOLOR,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.SMOKE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.HEARTRATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.BREATHINGRATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.JUGULARVEINHEIGHT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserReport.IMAGEOFDETECTEDRESULTURL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserReportModelType extends amplify_core.ModelType<UserReport> {
  const _UserReportModelType();
  
  @override
  UserReport fromJson(Map<String, dynamic> jsonData) {
    return UserReport.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UserReport';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UserReport] in your schema.
 */
class UserReportModelIdentifier implements amplify_core.ModelIdentifier<UserReport> {
  final String id;

  /** Create an instance of UserReportModelIdentifier using [id] the primary key. */
  const UserReportModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UserReportModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserReportModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}