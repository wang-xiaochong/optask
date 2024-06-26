import { getInitialState } from '@/app';
import { pageSize } from '@/pages/Components/unitConfig';
import { getAllProjectInfo } from '@/request/projectInfo';
import { getTaskInfoByCreatedBy, updateTaskInfo } from '@/request/taskInfo';
import { getAllUserInfo } from '@/request/userInfo';
import { ProColumns, ProTable } from '@ant-design/pro-components';
import { NewLineConfig, RecordKey } from '@ant-design/pro-utils/es/useEditableArray';
import { history } from '@umijs/max';
import { message } from 'antd';
import { useEffect, useState } from 'react';
import { TaskInfoStatus, TaskInfoType } from '../../Components/Task';
import TaskAdd from './TaskAdd';

const TaskCreatedByMe = () => {
  const [userName, setUserName] = useState({});
  const [project, setProject] = useState({});
  const [myTasks, setMyTasks] = useState([]);


  const refreshTaskInfo = async () => {
    const userRes = await getInitialState();
    if (userRes?.currentUser?.name) {
      getTaskInfoByCreatedBy(userRes?.currentUser?.name).then((res) => {
        if (res.data) {
          setMyTasks(res?.data);
        }
      });
    }
  }

  useEffect(() => {
    getAllUserInfo().then((res) => {
      let ret = {};
      for (let i = 0; i < res?.data?.length; i++) {
        const user = res?.data[i] as API.CurrentUser;
        if (user?.name) {
          ret[user.name] = { text: user.name, id: user.userid };
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

    refreshTaskInfo();
    // console.log('TaskProtable');
  }, []);

  // useEffect(() => {
  //   getTaskInfoByCreatedBy(createdBy).then((res) => {
  //     if (res.data) {
  //       setMyTasks(res?.data);
  //     }
  //   });
  // }, [createdBy]);

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
    // record sent to end
    const res = await updateTaskInfo(record);
    refreshTaskInfo();
    if (res.success) {
      message.success("更新成功");
    }
  };
  return (
    <ProTable<API.TaskInfo>
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
      dataSource={myTasks}
      // request={(params, sorter, filter) => {
      //   // 表单搜索项会从 params 传入，传递给后端接口。
      //   console.log(params, sorter, filter);
      //   return Promise.resolve({
      //     data: [],
      //     success: true,
      //   });
      //   // return getTaskInfoByCreatedBy(createdBy);
      //   // return [];
      // }}
      ErrorBoundary={false}
      rowKey="id"
      search={false}
      options={false}
      pagination={{
        pageSize: pageSize
      }}
    />
  );
};

export default TaskCreatedByMe;
