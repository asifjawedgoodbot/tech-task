import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file_manager.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  final _fileManager = FileManager();

  FileManagerCubit() : super(FileManagerInitialState());

  List<dynamic>? get loadedSteps {
    if (state is FileManagerLoadedState) {
      return (state as FileManagerLoadedState).steps;
    } else {
      return null;
    }
  }

  Future<void> processFile(String filePath) async {
    emit(FileManagerLoadingState());

    // Process file method will return valid and invalid steps
    final steps = await _fileManager.processFile(filePath);

    emit(FileManagerLoadedState(steps));
  }

  processingFinished() {
    emit(FileManagerFinishedState());
  }
}

abstract class FileManagerState extends Equatable {
  const FileManagerState();

  @override
  List<Object?> get props => [];
}

class FileManagerInitialState extends FileManagerState {}

class FileManagerLoadingState extends FileManagerState {}

class FileManagerFinishedState extends FileManagerState {}

class FileManagerLoadedState extends FileManagerState {
  final List<dynamic> steps;

  const FileManagerLoadedState(this.steps);

  @override
  List<Object?> get props => [steps];
}

class FileManagerErrorState extends FileManagerState {
  final String error;

  const FileManagerErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
