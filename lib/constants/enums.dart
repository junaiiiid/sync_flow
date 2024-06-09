enum NavigationBarItems { home, projects, board, settings }

enum NetworkRequestType { get, post, delete }

enum ApiType {
  getAUsersProject,
  addANewProject,
  addANewTask,
  updateATask,
  completeATask,
  deleteAProject,
  getProject,
  updateProject,
  getAllCollaborators,
  getAllSections,
  createANewSection,
  getASingleSection,
  updateASection,
  deleteASection,
  getActiveTasks,
  createANewTask,
  getAnActiveTask,
  closeATask,
  reopenATask,
  deleteATask,
  getAllComments,
  createANewComment,
  getAComment,
  updateAComment,
  deleteAComment,
  getAllPersonalLabels,
  createNewPersonalLabel,
  getAPersonalLabel,
  updateAPersonalLabel,
  deleteAPersonalLabel,
  getAllSharedLabels,
  renameASharedLabel,
  removeASharedLabel
}
