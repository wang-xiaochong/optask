// import { Progress, Tag } from 'antd';
import { getAllUserInfo } from '@/request/userInfo';
import { ProColumns, ProTable } from '@ant-design/pro-components';
import { useEffect, useState } from 'react';
import { pageSize } from '../../Components/unitConfig';

const Manager = () => {
  const [userList, setUserList] = useState();

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
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '职位',
      dataIndex: 'job',
      valueType: 'text',
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

  useEffect(() => {
    getAllUserInfo().then((res) => {
      setUserList(res?.data);
    });
  }, []);

  return (
    <ProTable<API.User>
      columns={columns}
      editable={{
        type: 'multiple',
        actionRender: (row, config, defaultDoms) => {
          return [defaultDoms.save, defaultDoms.cancel];
        },
        onSave: async (rows, record, originRow, newLineConfig) => {
          // await updateWikiInfo(rows, record, originRow, newLineConfig);
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
