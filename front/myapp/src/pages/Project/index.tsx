import { getAllProjectInfo } from '@/request/projectInfo';
import { ProList } from '@ant-design/pro-components';
// import { Progress, Tag } from 'antd';
import { history } from '@umijs/max';
import { useEffect, useState } from 'react';
import { pageSize } from '../Components/unitConfig';
import ProjectAdd from "./components/ProjectAdd";

const Project = () => {
  const [cardActionProps, setCardActionProps] = useState<'actions' | 'extra'>('extra');
  const [project, setProject] = useState<Array<API.ProjectInfo>>([]);
  const [projectRender, setProjectRender] = useState<any>([]);


  const refreshProject = () => {
    getAllProjectInfo().then((res) => {
      let ret = [];
      for (let i = 0; i < res?.data?.length; i++) {
        const project = res?.data[i] as API.ProjectInfo;
        if (project?.name) {
          ret.push(project);
        }
      }
      // console.log('project:', ret);
      setProject(ret);
    });

  }

  useEffect(() => {
    refreshProject();
  }, []);
  useEffect(() => {
    let ret = project.map((item) => {
      return {
        id: item.id,
        title: item.name,
        // userInfo: item?.userInfo,
        // desc: item?.desc,
        // subTitle: <Tag color="#5BD8A6">语雀专栏</Tag>,
        actions: [
          <span key="status" style={{ width: 120 }}>
            状态:{item.status}
          </span>,
          // <a key="run">
          //   <span
          //     onClick={() => {
          //       history.push(`/project/list/${item?.id}`);
          //     }}
          //   >
          //     查看
          //   </span>
          // </a>,
          // <a key="delete">删除</a>,
        ],
        avatar: 'https://gw.alipayobjects.com/zos/antfincdn/UCSiy1j6jx/xingzhuang.svg',
        // content: (
        //   <div
        //     style={{
        //       flex: 1,
        //     }}
        //   >
        //     <div
        //       style={{
        //         width: 200,
        //       }}
        //     >
        //       <div></div>
        //     </div>
        //   </div>
        // ),
      };
    });
    setProjectRender(ret);
  }, [project]);

  return (
    <>

      <ProList editable={{ type: "multiple" }}
        toolBarRender={() => {
          return [
            // <Button key="add" type="primary">
            //   新建
            // </Button>,
            <ProjectAdd key="add" refreshProject={refreshProject} />
          ];
        }}
        pagination={{
          defaultPageSize: pageSize,
          showSizeChanger: false,
        }}
        showActions="hover"
        rowSelection={{}}
        grid={{ gutter: 16, column: 2 }}
        onItem={(record: any) => {
          return {
            // onMouseEnter: () => {
            //   console.log(record);
            // },
            onClick: () => {
              console.log(record);
              delete record.actions;
              history.push(`/project/list/detail`, record);
            },
          };
        }}
        metas={{
          title: {},
          subTitle: {},
          type: {},
          avatar: {},
          content: {},
          actions: {
            cardActionProps,
          },
        }}

        headerTitle="项目列表"
        dataSource={projectRender}
      />
    </>
  );
};

export default Project;
