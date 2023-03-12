import { getAllProjectInfo } from '@/request/projectInfo';
import { ProList } from '@ant-design/pro-components';
// import { Progress, Tag } from 'antd';
import { useEffect, useState } from 'react';
import { pageSize } from '../Components/unitConfig';

// const data = [
//   '语雀的天空',
//   'Ant Design',
//   '蚂蚁金服体验科技',
//   'TechUI',
//   'TechUI 2.0',
//   'Bigfish',
//   'Umi',
//   'Ant Design Pro',
// ].map((item) => ({
//   title: item,
//   subTitle: <Tag color="#5BD8A6">语雀专栏</Tag>,
//   actions: [<a key="run">邀请</a>, <a key="delete">删除</a>],
//   avatar: 'https://gw.alipayobjects.com/zos/antfincdn/UCSiy1j6jx/xingzhuang.svg',
//   content: (
//     <div
//       style={{
//         flex: 1,
//       }}
//     >
//       <div
//         style={{
//           width: 200,
//         }}
//       >
//         <div>发布中</div>
//         <Progress percent={80} />
//       </div>
//     </div>
//   ),
// }));

const Project = () => {
  const [cardActionProps, setCardActionProps] = useState<'actions' | 'extra'>('extra');
  const [project, setProject] = useState<Array<API.ProjectInfo>>([]);
  const [projectRender, setProjectRender] = useState<any>([]);
  useEffect(() => {
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
  }, []);
  useEffect(() => {
    let ret = project.map((item) => {
      return {
        id: item.id,
        title: item.name,
        // subTitle: <Tag color="#5BD8A6">语雀专栏</Tag>,
        actions: [
          <span key="status"> {item.status}</span>,
          <a key="run">查看</a>,
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
    <ProList<any>
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
  );
};

export default Project;
