export enum TaskInfoType {
  会议 = '会议',
  代码开发 = '代码开发',
  BUG = 'BUG',
  环境搭建 = '环境搭建',
  文档编写 = '文档编写',
  其他任务 = '其他任务',
}
export enum TaskInfoStatus {
  新建 = '新建',
  进行中 = '进行中',
  已完成 = '已完成',
  暂停中 = '暂停中',
  待办任务 = '待办任务',
  已关闭 = '已关闭',
}

export enum ProjectInfoStatus {
  打开 = '打开',
  关闭 = '关闭',
  暂停中 = '暂停中',
}

export enum RouterInfoType {
  project = 'project',
  wiki = 'wiki',
  task = 'task',
  user = 'user',
  home = 'home',
}
