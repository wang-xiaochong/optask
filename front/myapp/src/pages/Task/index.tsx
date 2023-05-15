import { getAllProjectInfo } from '@/request/projectInfo';
import { getAllTaskInfo, updateTaskInfo } from '@/request/taskInfo';
import { getAllUserInfo } from '@/request/userInfo';
import { getNowFormatDate } from '@/utils/utils';
import { ProColumns, ProTable, RequestData } from '@ant-design/pro-components';
import { NewLineConfig, RecordKey } from '@ant-design/pro-utils/es/useEditableArray';
import { history } from '@umijs/max';
import { message } from 'antd';
import { useEffect, useRef, useState } from 'react';
import { TaskInfoStatus, TaskInfoType } from '../Components/Task';
import { pageSize } from '../Components/unitConfig';
import TaskAdd from './components/TaskAdd';

const TaskProtable = () => {
  const [userName, setUserName] = useState({});
  const [project, setProject] = useState({});
  // const [allTaskInfo, setAllTaskInfo] = useState<Array<any>>([]);
  const allTaskInfoRef = useRef<Array<any>>([]);
  const taskRef = useRef<any>();

  // const refreshTaskInfo = async () => {
  //   getAllTaskInfo().then(res => {
  //     if (res.data) {
  //       // console.log('res.data');
  //       setAllTaskInfo(res.data);
  //       allTaskInfoRef.current = res.data;
  //     }
  //   })
  // }

  const refreshTaskInfo = async (params?: any, sorter?: any, filter?: any) => {
    delete params?.current;
    delete params?.pageSize;


    if (params && Object.keys(params).length === 0) {
      return getAllTaskInfo();
    }
    if (!params) {
      taskRef.current.submit();
    }

    if (allTaskInfoRef.current.length === 0) {
      allTaskInfoRef.current = (await getAllTaskInfo())?.data;
    }
    // 表单搜索项会从 params 传入，传递给后端接口。
    console.log(params, sorter, filter);
    // return Promise.resolve({
    //   data: tableListDataSource,
    //   success: true,
    // });
    const nowTaskInfo = [...allTaskInfoRef.current];
    if (params && Object.keys(params).length !== 0) {
      for (let i = 0; i < nowTaskInfo.length; i++) {
        const taskInfo = nowTaskInfo[i];
        for (const key in params) {
          if (params.hasOwnProperty(key)) {
            if (!taskInfo[key] || params[key] !== taskInfo[key]) {
              nowTaskInfo.splice(i, 1);
              i--;
              break;
            }
          }
        }
      }
    }
    // console.log('nowTaskInfo', nowTaskInfo);
    // setAllTaskInfo(nowTaskInfo);
    return { data: nowTaskInfo, success: true, total: nowTaskInfo.length };
  }

  useEffect(() => {
    getAllUserInfo().then((res) => {
      let ret = {};
      for (let i = 0; i < res?.data?.length; i++) {
        const user = res?.data[i] as API.CurrentUser;
        if (user?.name) {
          ret[user.name] = { text: user.name, id: user?.id };
        }
      }
      setUserName(ret);
    });
    getAllProjectInfo().then((res) => {
      let ret = {};
      for (let i = 0; i < res?.data?.length; i++) {
        const project = res?.data[i] as API.ProjectInfo;
        if (project?.name) {
          ret[project.name] = { text: project.name, id: project.id };
        }
      }
      setProject(ret);
    });

    // refreshTaskInfo();

    // console.log('TaskProtable');
  }, []);
  const columns: ProColumns<API.TaskInfo>[] = [
    {
      title: 'ID',
      dataIndex: 'id',
      valueType: 'text',
      readonly: true,
      render: (text, record) => {
        // console.log(text, record, index);
        return (
          <a>
            <span
              onClick={() => {
                let pathname = location.pathname;
                history.push(`${pathname}/detail`, record);
              }}
            >
              #{Number(text?.toString())}
            </span>
          </a>
        );
      },
    },
    {
      title: '主题',
      dataIndex: 'name',
      valueType: 'text',
      width: '30%',
      render: (text, record) => {
        return (
          <a>
            <span
              onClick={() => {
                let pathname = location.pathname;
                history.push(`${pathname}/detail`, record);
              }}
            >
              {text}
            </span>
          </a>
        );
      },
    },
    {
      title: '类型',
      dataIndex: 'type',
      valueType: 'select',
      valueEnum: TaskInfoType,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '状态',
      dataIndex: 'status',
      valueType: 'select',
      valueEnum: TaskInfoStatus,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '创建人',
      dataIndex: 'createdBy',
      valueType: 'select',
      valueEnum: userName,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '指定人',
      dataIndex: 'appoint',
      valueType: 'select',
      valueEnum: userName,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '更新时间',
      readonly: true,
      dataIndex: 'updateTime',
      valueType: 'text',
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '项目',
      dataIndex: 'project',
      valueType: 'select',
      valueEnum: project,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '操作',
      valueType: 'option',
      key: 'option',
      render: (text, record, _, action) => {
        return [
          <a
            key="editable"
            onClick={() => {
              action?.startEditable?.(record.id);
            }}
          >
            编辑
          </a>,
          // <TableDropdown
          //   key="actionGroup"
          //   onSelect={() => action?.reload()}
          //   menus={[
          //     { key: 'copy', name: '复制' },
          //     { key: 'delete', name: '删除' },
          //   ]}
          // />,
        ];
      },
    },
  ];
  const onSaveTaskInfo = async (
    rows: RecordKey,
    record: API.TaskInfo & { index?: number | undefined },
    originRow: API.TaskInfo & { index?: number | undefined },
    newLineConfig: NewLineConfig<API.TaskInfo> | undefined,
  ) => {
    console.log('rows', rows);
    console.log('record', record);
    console.log('originRow', originRow);
    console.log('newLineConfig', newLineConfig);
    record.updateTime = getNowFormatDate() as any;
    // console.log('time', time);
    // record sent to end

    const res = await updateTaskInfo(record);
    if (res.success) {
      message.success("更新成功");
    }
    refreshTaskInfo();
  };

  return (
    <ProTable<API.TaskInfo>
      formRef={taskRef}
      toolBarRender={() => {
        return [
          // <Button key="add" type="primary">
          //   新建
          // </Button>,
          <TaskAdd key="add" refreshTaskInfo={refreshTaskInfo} />
        ];
      }}
      columns={columns}
      editable={{
        type: 'multiple',
        actionRender: (row, config, defaultDoms) => {
          return [defaultDoms.save, defaultDoms.cancel];
        },
        onSave: async (rows, record, originRow, newLineConfig) => {
          await onSaveTaskInfo(rows, record, originRow, newLineConfig);
        },
      }}
      // dataSource={allTaskInfo}
      // request={async (params, sorter, filter) => {
      //   // 表单搜索项会从 params 传入，传递给后端接口。
      //   console.log(params, sorter, filter);
      //   // return Promise.resolve({
      //   //   data: tableListDataSource,
      //   //   success: true,
      //   // });
      //   return addKeyToFnDataArray(getAllTaskInfo);
      // }}
      ErrorBoundary={false}
      rowKey="id"
      search={{}}
      request={refreshTaskInfo}
      pagination={{
        pageSize: pageSize,
        // onChange: (page) => console.log(page),
      }}
    />
  );
};

export default TaskProtable;
