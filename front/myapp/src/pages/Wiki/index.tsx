// import { history } from '@umijs/max';
// import { Collapse } from 'antd';
// import { useEffect } from 'react';
// const { Panel } = Collapse;
// const WikiList = () => {
//   const getValue = (v) => {
//     console.log(v);
//   };

//   useEffect(() => {}, []);

//   const onClick = () => {
//     console.log('clickpathname', location);
//     history.push(`${location.pathname}/detail`, { data: 123 });
//   };

//   const text = (
//     <p style={{ paddingLeft: 24 }}>
//       A dog is a type of domesticated animal. Known for its loyalty and faithfulness, it can be
//       found as a welcome guest in many households across the world.
//     </p>
//   );

//   return (
//     <>
//       <div>
//         <Collapse bordered={false} defaultActiveKey={['1']}>
//           <Panel header="This is panel header 1" key="1">
//             {text}
//           </Panel>
//           <Panel header="This is panel header 2" key="2">
//             {text}
//           </Panel>
//           <Panel header="This is panel header 3" key="3">
//             {text}
//           </Panel>
//         </Collapse>
//         <button type="button" onClick={onClick}>
//           click
//         </button>
//       </div>
//     </>
//   );
// };

// export default WikiList;

import { getAllProjectInfo } from '@/request/projectInfo';
import { getAllUserInfo } from '@/request/userInfo';
import { getAllWikiInfo } from '@/request/wikiInfo';
import { addKeyToFnDataArray } from '@/utils/utils';
import { ProColumns, ProTable } from '@ant-design/pro-components';
import { NewLineConfig, RecordKey } from '@ant-design/pro-utils/es/useEditableArray';
import { history } from '@umijs/max';
import { useEffect, useState } from 'react';
import { pageSize } from '../Components/unitConfig';

const WikiProtable = () => {
  const [userName, setUserName] = useState({});
  const [project, setProject] = useState({});
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

    // console.log('TaskProtable');
  }, []);
  const columns: ProColumns<API.WikiInfo>[] = [
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
                history.push(`${pathname}/${record.id}`, record);
              }}
            >
              #{1000 + Number(text?.toString())}
            </span>
          </a>
        );
      },
    },
    {
      title: '标题',
      dataIndex: 'title',
      valueType: 'text',
      width: '30%',
      render: (text, record) => {
        return (
          <a>
            <span
              onClick={() => {
                let pathname = location.pathname;
                history.push(`${pathname}/${record.id}`, record);
              }}
            >
              {text}
            </span>
          </a>
        );
      },
    },
    {
      title: '创建人',
      dataIndex: 'createdBy',
      valueType: 'select',
      valueEnum: userName,
      readonly: true,
      // render: (_) => <a>{_}</a>,
    },
    {
      title: '更新时间',
      readonly: true,
      dataIndex: 'updateTime',
      valueType: 'text',
      // render: (_) => <a>{_}</a>,
    },
    // {
    //   title: '项目',
    //   dataIndex: 'project',
    //   valueType: 'select',
    //   valueEnum: project,
    //   // render: (_) => <a>{_}</a>,
    // },
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
  const updateTaskInfo = async (
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
  };

  // const myGetAllTaskInfo = () => {
  //   getAllWikiInfo().then((res) => {
  //     console.log('resgetAllTaskInfo', res);
  //   });
  // };
  return (
    // <button type="button" onClick={myGetAllTaskInfo}>
    //   click
    // </button>

    <ProTable<API.WikiInfo>
      columns={columns}
      editable={{
        type: 'multiple',
        actionRender: (row, config, defaultDoms) => {
          return [defaultDoms.save, defaultDoms.cancel];
        },
        onSave: async (rows, record, originRow, newLineConfig) => {
          await updateTaskInfo(rows, record, originRow, newLineConfig);
        },
      }}
      request={(params, sorter, filter) => {
        // 表单搜索项会从 params 传入，传递给后端接口。
        console.log(params, sorter, filter);
        // return Promise.resolve({
        //   data: tableListDataSource,
        //   success: true,
        // });
        return addKeyToFnDataArray(getAllWikiInfo);
      }}
      ErrorBoundary={false}
      rowKey="id"
      search={false}
      pagination={{
        pageSize: pageSize,
        // onChange: (page) => console.log(page),
      }}
    />
  );
};

export default WikiProtable;
