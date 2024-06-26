import { getAllProjectInfo } from '@/request/projectInfo';
import { getAllUserInfo } from '@/request/userInfo';
import { getAllWikiInfo, getWikiInfoByProjectID, updateWikiInfoByID } from '@/request/wikiInfo';
import { ProColumns, ProTable } from '@ant-design/pro-components';
import { RecordKey } from '@ant-design/pro-utils/es/useEditableArray';
import { history } from '@umijs/max';
import { Select } from 'antd';
import { useEffect, useState } from 'react';
import { pageSize } from '../Components/unitConfig';
import WikiAdd from './components/WikiAdd';

const WikiProtable = () => {
  const [userName, setUserName] = useState({});
  const [project, setProject] = useState<any>([]);
  const [projectID, setProjectID] = useState<any>();
  const [wikiList, setWikiList] = useState<API.WikiInfo[]>([]);

  const refrehWikiList = () => {
    getAllWikiInfo().then((res) => {
      setWikiList(res.data);
    });
  }

  useEffect(() => {
    getAllUserInfo().then((res) => {
      let ret = {};
      for (let i = 0; i < res?.data?.length; i++) {
        const user = res?.data[i] as API.CurrentUser;
        if (user?.name) {
          ret[user.name] = { text: user.name, id: user.id };
        }
      }
      setUserName(ret);
    });

    getAllProjectInfo().then((res) => {
      let ret: { value: number; label: string }[] = [{ value: 0, label: '全部' }];
      for (let i = 0; i < res?.data?.length; i++) {
        const t = { value: res?.data[i].id, label: res?.data[i].name };
        ret.push(t);
      }
      // console.log('project:', ret);
      setProject(ret);
    });
    refrehWikiList();
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
  const updateWikiInfo = async (
    rows: RecordKey,
    record: API.TaskInfo & { index?: number | undefined },
    // originRow: API.TaskInfo & { index?: number | undefined },
    // newLineConfig: NewLineConfig<API.TaskInfo> | undefined,
  ) => {
    // console.log('rows', rows);
    console.log('record', record);
    // console.log('originRow', originRow);
    // console.log('newLineConfig', newLineConfig);
    // record sent to end
    delete record.index;
    await updateWikiInfoByID(record);

    if (projectID) {
      getWikiInfoByProjectID(projectID).then((res) => {
        setWikiList(res.data);
      });
    } else {
      getAllWikiInfo().then((res) => {
        setWikiList(res.data);
      });
    }
  };
  const selectProject = () => {
    const handleChange = (value: number) => {
      // console.log(`selected ${value}`);
      setProjectID(value);
      if (value) {
        getWikiInfoByProjectID(value).then((res) => {
          setWikiList(res.data);
        });
      } else {
        getAllWikiInfo().then((res) => {
          setWikiList(res.data);
        });
      }
    };

    return (
      <>
        <span> 项目名称</span>
        <Select
          style={{ width: 200, marginLeft: '10px' }}
          onChange={handleChange}
          options={project}
          defaultValue={0}
        />
      </>
    );
  };

  return (
    <ProTable<API.WikiInfo>
      toolBarRender={() => {
        return [
          // <Button key="add" type="primary">
          //   新建
          // </Button>,
          <WikiAdd key="add" refrehWikiList={refrehWikiList} />
        ];
      }}
      columns={columns}
      editable={{
        type: 'multiple',
        actionRender: (row, config, defaultDoms) => {
          return [defaultDoms.save, defaultDoms.cancel];
        },
        onSave: async (rows, record, originRow, newLineConfig) => {
          await updateWikiInfo(rows, record, originRow, newLineConfig);
        },
      }}
      dataSource={wikiList}
      ErrorBoundary={false}
      rowKey="id"
      search={false}
      headerTitle={selectProject()}
      pagination={{
        pageSize: pageSize,
        // onChange: (page) => console.log(page),
      }}
    />
  );
};

export default WikiProtable;
