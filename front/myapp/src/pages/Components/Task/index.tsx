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

export { TaskInfoType, TaskInfoStatus };
