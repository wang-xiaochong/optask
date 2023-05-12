import { TaskInfoStatus, TaskInfoType } from '@/request/enum';
import { getProjectInfoByID } from '@/request/projectInfo';
import { getTaskInfoByProjectID } from '@/request/taskInfo';
import { getUserInfoById } from '@/request/userInfo';
// import { Bar } from '@ant-design/charts';
import { Bar } from '@ant-design/plots';
import { ProCard } from '@ant-design/pro-components';
import { history } from '@umijs/max';
import { useEffect, useState } from 'react';
const ProjectDetail = () => {
  // const [state, setState] = useState<ProFieldFCMode>('read');
  // const [plain, setPlain] = useState<boolean>(false);
  const [projectDetail, setProjectDetail] = useState<API.ProjectInfo>({});
  const [tasksInfo, setTasksInfo] = useState<API.TaskInfo[]>([]);
  const [tasksInfoRender, setTasksInfoRender] = useState<
    { value: number; type: TaskInfoType; status: TaskInfoStatus }[]
  >([]);
  const [userInfo, setUserInfo] = useState<API.CurrentUser[]>([]);

  const projectID = history.location.state?.title;

  const getProject = async () => {
    const projectInfo: API.ProjectInfo = (await getProjectInfoByID(projectID))?.data;
    console.log('项目详情：', projectInfo);
    setProjectDetail(projectInfo);
  }


  useEffect(() => {
    console.log('history.location.state', history.location.state);
    getTaskInfoByProjectID(projectID).then((res: { data: API.TaskInfo[] }) => {
      console.log('对应项目任务列表：', res);
      setTasksInfo(res?.data);
    });
    // console.log('项目ID: ', projectID);
    getProject();
  }, []);

  useEffect(() => {
    let ret: Array<{ value: number; type: TaskInfoType; status: TaskInfoStatus }> = [];
    tasksInfo?.forEach((item) => {
      let i = 0;
      for (i = 0; i < ret.length; i++) {
        if (ret[i].type === item.type && ret[i].status === item.status) {
          ret[i].value++;
          break;
        }
      }
      if (i === ret.length) {
        ret = ret.concat({ type: item.type, value: 1, status: item.status });
      }
    });
    // console.log('ret', ret);
    setTasksInfoRender(ret);
  }, [tasksInfo]);

  const getUserInfo = async () => {
    if (projectDetail.userInfo) {
      const userIdArr = projectDetail.userInfo?.split(",");
      const userArr: API.CurrentUser[] = [];
      for (let index = 0; index < userIdArr.length; index++) {
        const userRes = await getUserInfoById(Number(userIdArr[index]))
        userArr.push(userRes.data);
      }
      setUserInfo(userArr);
    }
  }

  useEffect(() => {
    getUserInfo();
  }, [projectDetail])

  const TaskBar = () => {
    const config = {
      data: tasksInfoRender,
      xField: 'value',
      yField: 'type',
      seriesField: 'status',
      isStack: true,
      legend: {
        position: 'top-left',
      },
    };
    return <Bar {...config} />;
  };

  return (
    <ProCard>
      <>
        {/* <Space>
          <Radio.Group onChange={(e) => setState(e.target.value as ProFieldFCMode)} value={state}>
            <Radio value="read">只读</Radio>
            <Radio value="edit">编辑</Radio>
          </Radio.Group>
          简约模式
          <Switch checked={plain} onChange={(checked) => setPlain(checked)} />
        </Space> */}
        <br />
        <br />

        <ProCard style={{ marginBlockStart: 8 }} gutter={8} title="">
          {projectDetail && (
            <ProCard
              layout="center"
              title={projectDetail.name}
              extra={projectDetail.status}
              // tooltip="这是提示"
              bordered
              style={{ minHeight: 300, maxWidth: 300, marginBlockStart: 24 }}
              size="small"
            >
              <div>{projectDetail.description}</div>
            </ProCard>
          )}
          {userInfo && (
            <ProCard
              layout="center"
              title="成员"
              // extra={projectDetail.status}
              // tooltip="这是提示"
              bordered
              style={{ minHeight: 300, maxWidth: 300, marginBlockStart: 24 }}
              size="small"
            >
              <div>
                {userInfo?.map((item) => {
                  return (
                    <div style={{ display: 'flex', margin: '5px' }} key={item.name}>
                      <img src={item.avatar} alt="头像" />
                      <span style={{ textAlign: 'center', lineHeight: '40px' }}>{item.name}</span>
                    </div>
                  );
                })}
              </div>
            </ProCard>
          )}
        </ProCard>

        {tasksInfo && (
          <ProCard style={{ marginBlockStart: 8 }} gutter={8} title="">
            <ProCard
              layout="center"
              title={'任务概况'}
              // extra={projectDetail.status}
              // tooltip="这是提示"
              bordered
              style={{ minHeight: 300, minWidth: 700, marginBlockStart: 24 }}
              size="small"
            >
              <div style={{ width: '100%' }}>
                <TaskBar />
              </div>
            </ProCard>
          </ProCard>
        )}
      </>
    </ProCard>
  );
};
export default ProjectDetail;
