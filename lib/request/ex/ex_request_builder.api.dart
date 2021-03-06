// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ApiGenerator
// **************************************************************************

import 'dart:io' show ContentType;
import 'package:meta/meta.dart';
import 'package:mx_core/mx_core.dart';
import 'package:rxdart/rxdart.dart';
import 'ex_request_builder.dart';

abstract class ExRequestApi extends RequestBuilderBase
    implements ExRequestInterface {
  @override
  HttpContent exApi(String titlePath, String aId, String bToken, String cBody,
      String rawBody, FileInfo dBodyFile,
      {String opId,
      String opToken,
      String opBody,
      FileInfo opBodyFile,
      String optRawBody}) {
    var content = generator.generate('ex/$titlePath',
        method: HttpMethod.post,
        host: "titleHost",
        scheme: "titleHttps",
        port: 8881,
        contentType: ContentType.parse("application/x-www-form-urlencoded"));
    content.bodyType = HttpBodyType.formUrlencoded;
    var _temp3 = "titleBodyValue";
    content.addBody(
      key: "titleBodyKey",
      value: "$_temp3",
    );
    content.addBody(
      key: "body",
      value: "$cBody",
    );
    content.setBody(raw: "$rawBody");
    content.addBody(
      key: "bodyF",
      filename: "${dBodyFile.filename}",
      filepath: "${dBodyFile.filepath}",
    );
    if (opBody != null) {
      content.addBody(
        key: "bodyOp",
        value: "$opBody",
      );
    }
    if (opBodyFile != null) {
      content.addBody(
        key: "bodyFOp",
        filename: "${opBodyFile.filename}",
        filepath: "${opBodyFile.filepath}",
      );
    }
    if (optRawBody != null) {
      content.setBody(raw: "$optRawBody");
    }
    var _temp2 = "titleHValue";
    content.addHeader("titleHKey", value: "$_temp2");
    content.addHeader("toke¥n", value: "$bToken");
    if (opToken != null) {
      content.addHeader("tokenOp", value: "$opToken");
    }
    var _temp1 = "titleQPValue";
    content.addQueryParam("titleQPKey", value: "$_temp1");
    content.addQueryParam("id", value: "$aId");
    if (opId != null) {
      content.addQueryParam("opId", value: "$opId");
    }
    return content;
  }
}

abstract class ExRequestClientMixin implements ExRequestInterface {
  ExRequestApi exRequestApi;

  @override
  HttpContent exApi(String titlePath, String aId, String bToken, String cBody,
      String rawBody, FileInfo dBodyFile,
      {String opId,
      String opToken,
      String opBody,
      FileInfo opBodyFile,
      String optRawBody}) {
    return exRequestApi.exApi(
      titlePath,
      aId,
      bToken,
      cBody,
      rawBody,
      dBodyFile,
      opId: opId,
      opToken: opToken,
      opBody: opBody,
      opBodyFile: opBodyFile,
      optRawBody: optRawBody,
    );
  }
}

abstract class ExRequestServicePattern {
  ExRequestClientMixin exRequestClientMixin;

  Observable<ServerResponse> exApi(String titlePath, String aId, String bToken,
      String cBody, String rawBody, FileInfo dBodyFile,
      {String opId,
      String opToken,
      String opBody,
      FileInfo opBodyFile,
      String optRawBody}) {
    return exRequestClientMixin
        .exApi(
          titlePath,
          aId,
          bToken,
          cBody,
          rawBody,
          dBodyFile,
          opId: opId,
          opToken: opToken,
          opBody: opBody,
          opBodyFile: opBodyFile,
          optRawBody: optRawBody,
        )
        .connect();
  }
}
