const TaskInfoType = () => {
  return {
    会议: { text: '会议' },
    代码开发: { text: '代码开发' },
    BUG: { text: 'BUG' },
    环境搭建: { text: '环境搭建' },
    文档编写: { text: '文档编写' },
    其他任务: { text: '其他任务' },
  };
};

const TaskInfoStatus = () => {
  return {
    新建: { text: '新建' },
    进行中: { text: '进行中' },
    已完成: { text: '已完成' },
    暂停中: { text: '暂停中' },
    待办任务: { text: '待办任务' },
    已关闭: { text: '已关闭' },
  };
};

const TaskInfoTypeOptions = [
  { value: '会议', label: '会议' },
  { value: '代码开发', label: '代码开发' },
  { value: 'BUG', label: 'BUG' },
  { value: '环境搭建', label: '环境搭建' },
  { value: '文档编写', label: '文档编写' },
  { value: '其他任务', label: '其他任务' },
];

const TaskInfoStatusOptions = [
  { value: '新建', label: '新建' },
  { value: '进行中', label: '进行中' },
  { value: '已完成', label: '已完成' },
  { value: '暂停中', label: '暂停中' },
  { value: '待办任务', label: '待办任务' },
  { value: '已关闭', label: '已关闭' },
];

export { TaskInfoType, TaskInfoStatus, TaskInfoStatusOptions, TaskInfoTypeOptions };
