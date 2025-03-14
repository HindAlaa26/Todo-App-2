abstract class TodoStates {}
 class TodoIntitialState extends TodoStates{}
 class TodoChangeIndexState extends TodoStates{}

 class TodoChangeTaskTimeState extends TodoStates{}
 class TodoChangeTaskDateState extends TodoStates{}

 class TodoAddTaskState extends TodoStates{}
 class TodoRemoveTaskState extends TodoStates {}
 class TodoUpdateTaskStatusState extends TodoStates {}
 class TodoGetTasksState extends TodoStates {}

 class TodoAddTaskToFolderState extends TodoStates {}
 class TodoFolderCreatedState extends TodoStates {}
 class TodoRemoveFolderState extends TodoStates {}
 
