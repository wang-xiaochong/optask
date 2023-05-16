// import { Progress, Tag } from 'antd';
import { UserJob } from '@/pages/Components/User';
import { getAllRoleInfo } from '@/request/roleInfo';
import { getAllUserInfo, updateUserRoleAndJob } from '@/request/userInfo';
import { ProColumns, ProTable } from '@ant-design/pro-components';
import { NewLineConfig, RecordKey } from '@ant-design/pro-utils/es/useEditableArray';
import { message } from 'antd';
import { useEffect, useState } from 'react';
import { pageSize } from '../../Components/unitConfig';

const Manager = () => {
  const [userList, setUserList] = useState();
  const [role, setRole] = useState({});

  const refreshUserInfo = () => {
    getAllRoleInfo().then((res) => {
      // console.log('res', res);
      let ret = {};
      for (let i = 0; i < res?.data?.length; i++) {
        const role = res?.data[i] as API.RoleInfo;
        if (role?.name) {
          ret[role.name] = { text: role.name, id: role?.id };
        }
      }
      setRole(ret);
    });

    getAllUserInfo().then((res) => {
      setUserList(res?.data);
    });

  }

  useEffect(() => {
    refreshUserInfo();
  }, [])


  const columns: ProColumns<API.User>[] = [
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
            // onClick={() => {
            //   let pathname = location.pathname;
            //   history.push(`${pathname}/${record.id}`, record);
            // }}
            >
              #{Number(text?.toString())}
            </span>
          </a>
        );
      },
    },
    {
      title: '账号',
      dataIndex: 'account',
      valueType: 'text',
      readonly: true,
      width: '10%',
      render: (text, record) => {
        return (
          <a>
            <span
            // onClick={() => {
            //   let pathname = location.pathname;
            //   history.push(`${pathname}/${record.id}`, record);
            // }}
            >
              {text}
            </span>
          </a>
        );
      },
    },
    {
      title: '姓名',
      dataIndex: 'name',
      valueType: 'text',
      // valueType: 'select',
      // valueEnum: userName,
      readonly: true,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '角色',
      dataIndex: 'roleInfo',
      valueType: 'text',
      valueEnum: role,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '职位',
      dataIndex: 'job',
      valueType: 'text',
      valueEnum: UserJob,
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
              action?.startEditable?.(record?.id);
            }}
          >
            编辑
          </a>,
        ];
      },
    },
  ];

  const onSaveUserInfo = async (
    rows: RecordKey,
    record: API.TaskInfo & { index?: number | undefined },
    originRow: API.TaskInfo & { index?: number | undefined },
    newLineConfig: NewLineConfig<API.TaskInfo> | undefined,
  ) => {
    console.log('rows', rows);
    console.log('record', record);
    console.log('originRow', originRow);
    console.log('newLineConfig', newLineConfig);

    console.log('record', record);
    // // record sent to end

    const res = await updateUserRoleAndJob(record);
    if (res.success) {
      message.success("更新成功");
    }
    refreshUserInfo();
  };

  return (
    <ProTable<API.User>
      columns={columns}
      editable={{
        type: 'multiple',
        actionRender: (row, config, defaultDoms) => {
          return [defaultDoms.save, defaultDoms.cancel];
        },
        onSave: async (rows, record, originRow, newLineConfig) => {
          await onSaveUserInfo(rows, record, originRow, newLineConfig);
        },
      }}
      dataSource={userList}
      ErrorBoundary={false}
      rowKey="id"
      search={false}
      // headerTitle={selectProject()}
      pagination={{
        pageSize: pageSize,
        // onChange: (page) => console.log(page),
      }}
    />
  );
};

export default Manager;
