import 'dart:io';

import 'package:path/path.dart';
import 'package:server/dto/offers/replace_offer.dart';
import 'package:server/repos/data_source.dart';
import 'package:excel/excel.dart';

class ReportRepo {
  final MySqlDataSource db;

  ReportRepo(this.db);

  Future<void> replaceReport(ReplaceOfferReport report) async {
    final file = Excel.createExcel();
    final sheet = file.getDefaultSheet() ?? '';
    CellStyle cellStyle = CellStyle(
      backgroundColorHex: '#C5BBF6',
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    Sheet sheetObject = file[sheet];
    final labels = [
      'Заявитель',
      "Контакты",
      "Тип заявки",
      "Прична заявки",
      'Аппарат',
      "Исполнитель",
    ];
    final values = [
      report.user.description ?? report.user.phone,
      report.user.phone,
      report.offer.offerTypeId,
      report.offer.description,
      report.apparat.name,
      report.company.name,
    ];
    sheetObject.merge(
      CellIndex.indexByString('H5'),
      CellIndex.indexByString('I5'),
      customValue: 'Заявка на замену',
    );
    sheetObject.updateCell(
      CellIndex.indexByString('H5'),
      'Заявка на замену',
      cellStyle: cellStyle.copyWith(
        boldVal: true,
        horizontalAlignVal: HorizontalAlign.Center,
        fontSizeVal: 15,
        backgroundColorHexVal: '#6AF2EA',
      ),
    );

    for (var i = 0; i < labels.length; i++) {
      sheetObject.updateCell(
        CellIndex.indexByString('H${i + 7}'),
        labels[i],
        cellStyle: cellStyle,
      );
      sheetObject.updateCell(CellIndex.indexByString('I${i + 7}'), values[i]);
    }

    final fileName = 'report_${report.runtimeType}.xlsx';

    final bytes = file.save(fileName: fileName) ?? [];
    Directory current = Directory.current;
    File(join("${current.path}/$fileName"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);
  }
}
