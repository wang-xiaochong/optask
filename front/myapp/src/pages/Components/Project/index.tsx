// const TaskInfoType = () => {
//   return {
//     会议: { text: '会议' },
//     代码开发: { text: '代码开发' },
//     BUG: { text: 'BUG' },
//     环境搭建: { text: '环境搭建' },
//     文档编写: { text: '文档编写' },
//     其他任务: { text: '其他任务' },
//   };
// };

const ProjectInfoStatus = {
  打开: { text: '打开' },
  关闭: { text: '关闭' },
  暂停: { text: '暂停' }
};

// const TaskInfoTypeOptions = [
//   { value: '会议', label: '会议' },
//   { value: '代码开发', label: '代码开发' },
//   { value: 'BUG', label: 'BUG' },
//   { value: '环境搭建', label: '环境搭建' },
//   { value: '文档编写', label: '文档编写' },
//   { value: '其他任务', label: '其他任务' },
// ];

const ProjectInfoStatusOptions = [
  { value: '打开', label: '打开' },
  { value: '关闭', label: '关闭' },
  { value: '暂停', label: '暂停' }
];

export { ProjectInfoStatus, ProjectInfoStatusOptions };
