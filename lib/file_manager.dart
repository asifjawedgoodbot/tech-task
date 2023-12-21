import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';

class FileManager {
  // Process File: Processes the .xlsx or .csv file and returns a list of pipetting steps
  Future<List<dynamic>> processFile(String filePath) async {
    try {
      // Read file and return a list of processable data list
      List<List<dynamic>> fileData = await readFile(filePath);

      /**
       * TODO
       * 
       * Any possible validations before parsing the file data
       * 
      **/

      return parseFileData(fileData);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading or processing file: $e');
      }
      throw 'Error reading or processing file';
    }
  }

  // Parse File Data: Parses the file data and returns a list of pipetting steps
  List<dynamic> parseFileData(List<List<dynamic>> fileData) {
    List<PipettingStep> pipettingSteps = [];
    List<String> invalidSteps = [];

    /**
       * TODO
       * 
       * Iterate over each row and identify valid and invalid steps
       * 
    **/

    return [pipettingSteps, invalidSteps];
  }

  // Extract Column Names: Extracts the column names from the header row for .xlsx files
  List<String> extractColumnNames(List<dynamic> headerRow) {
    return headerRow.map((header) => header.value.toString()).toList();
  }

  Future<List<List<dynamic>>> readFile(String filePath) async {
    try {
      if (filePath.endsWith('.csv')) {
        String csvContent = await File(filePath).readAsString();
        return const CsvToListConverter()
            .convert(csvContent, convertEmptyTo: '-');
      } else if (filePath.endsWith('.xlsx')) {
        var bytes = File(filePath).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        List<List<dynamic>> fileData = [];

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            fileData.add(row);
          }
        }

        return fileData;
      } else {
        throw 'Unsupported file format';
      }
    } catch (e) {
      throw 'Error reading file content';
    }
  }
}

class PipettingStep {
  final String action;

  PipettingStep(this.action);
}
