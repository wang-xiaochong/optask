import { getAllTaskInfo } from '@/request/taskInfo';
import { addKeyToFnDataArray } from '@/utils/utils';
import type { ProColumns } from '@ant-design/pro-components';
import { ProTable } from '@ant-design/pro-components';
import { history } from '@umijs/max';
// import TaskDetail from "./components/TaskDetail"

// export type TableListItem = {
//   key: number;
//   name: string;
//   containers: number;
//   creator: string;
// };
// const tableListDataSource: TableListItem[] = [];

// const creators = ['付小小', '曲丽丽', '林东东', '陈帅帅', '兼某某'];

// for (let i = 0; i < 5; i += 1) {
//   tableListDataSource.push({
//     key: i,
//     name: 'AppName',
//     containers: Math.floor(Math.random() * 20),
//     creator: creators[Math.floor(Math.random() * creators.length)],
//   });
// }

const columns: ProColumns<API.TaskInfo>[] = [
  // {
  //   title: '应用名称',
  //   dataIndex: 'name',
  //   render: (_) => <a>{_}</a>,
  // },
  {
    title: 'ID',
    dataIndex: 'id',
    render: (_) => (
      <a>
        <span
          onClick={() => {
            history.push('/task/list/2');
          }}
        >
          {_}
        </span>
      </a>
    ),
  },
  {
    title: '主题',
    dataIndex: 'name',
    render: (_) => (
      <a>
        <span
          onClick={() => {
            history.push('/task/list/2');
          }}
        >
          {_}
        </span>
      </a>
    ),
  },
  {
    title: '类型',
    dataIndex: 'type',
    render: (_) => <a>{_}</a>,
  },
  {
    title: '状态',
    dataIndex: 'status',
    render: (_) => <a>{_}</a>,
  },
  {
    title: '指定人',
    dataIndex: 'appoint',
    render: (_) => <a>{_}</a>,
  },
  {
    title: '更新时间',
    dataIndex: 'updateTime',
    render: (_) => <a>{_}</a>,
  },
  {
    title: '项目',
    dataIndex: 'project',
    render: (_) => <a>{_}</a>,
  },
  // {
  //   title: '容器数量',
  //   dataIndex: 'containers',
  //   align: 'right',
  //   sorter: (a, b) => a.containers - b.containers,
  // },
  // {
  //   title: '创建者',
  //   dataIndex: 'creator',
  //   valueType: 'select',
  //   valueEnum: {
  //     all: { text: '全部' },
  //     付小小: { text: '付小小' },
  //     曲丽丽: { text: '曲丽丽' },
  //     林东东: { text: '林东东' },
  //     陈帅帅: { text: '陈帅帅' },
  //     兼某某: { text: '兼某某' },
  //   },
  // },
  {
    title: '操作',
    key: 'option',
    // width: 120,
    valueType: 'option',
    render: () => [<a key="link">编辑</a>],
  },
];

const TaskProtable = () => {
  // useEffect(() => {
  //   console.log('TaskProtable');
  // }, []);
  return (
    <ProTable<API.TaskInfo>
      columns={columns}
      request={(params, sorter, filter) => {
        // 表单搜索项会从 params 传入，传递给后端接口。
        console.log(params, sorter, filter);
        // return Promise.resolve({
        //   data: tableListDataSource,
        //   success: true,
        // });
        return addKeyToFnDataArray(getAllTaskInfo);
      }}
      ErrorBoundary={false}
      rowKey="key"
      search={false}
    />
  );
};

export default TaskProtable;
