abstract class TodoStates {}
 class TodoIntitialState extends TodoStates{}
 class TodoChangeIndexState extends TodoStates{}

 class TodoChangeTaskTimeState extends TodoStates{}
 class TodoChangeTaskDateState extends TodoStates{}

 class TodoCreateDatabaseState extends TodoStates {}

 class TodoInsertDatabaseTasksState extends TodoStates {}
 class TodoGetDatabasetasksLoadingState extends TodoStates {}
 class TodoGetDatabasetasksState extends TodoStates {}
 class TodoDeletetasksDatabaseState extends TodoStates {}
 class TodoUpdatetaskStatusDatabaseState extends TodoStates {}


 class TodoInsertDatabaseFolderState extends TodoStates {}
 class TodoGetDatabasefoldersLoadingState extends TodoStates {}
 class TodoGetDatabasefoldersState extends TodoStates {}
 class TodoDeletefoldersDatabaseState extends TodoStates {}
 class TodoInsertTasksToFolderState extends TodoStates {}
 class TodoGetTasksFromFolderState extends TodoStates {}
 class UpdateTasksInFolderDatabaseStatus extends TodoStates {}
 class TodoDeletTasksFromFolderState extends TodoStates {}

 

 
