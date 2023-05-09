import { TaskInfoStatus, TaskInfoType } from '@/request/enum';
import { getProjectInfoByID } from '@/request/projectInfo';
import { getTaskInfoByProjectID } from '@/request/taskInfo';
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

  useEffect(() => {
    console.log('history.location.state', history.location.state);
    const projectID = history.location.state?.title;
    getTaskInfoByProjectID(projectID).then((res: { data: API.TaskInfo[] }) => {
      // console.log('对应项目任务列表：', res);
      setTasksInfo(res?.data);
    });
    // console.log('项目ID: ', projectID);
    getProjectInfoByID(projectID).then((res: { data: API.ProjectInfo }) => {
      // console.log('项目详情：', res);
      setProjectDetail(res.data);
    });
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
              <div>{projectDetail.desc}</div>
            </ProCard>
          )}
          {projectDetail?.userInfo && (
            <ProCard
              layout="center"
              title="成员"
              // extra={projectDetail.status}
              // tooltip="这是提示"
              bordered
              style={{ minHeight: 300, maxWidth: 300, marginBlockStart: 24 }}
              size="small"
            >
              {/* <div>
                {projectDetail.userInfo?.map((item) => {
                  return (
                    <div style={{ display: 'flex', margin: '5px' }} key={item.name}>
                      <img src={item.avatar} alt="头像" />
                      <span style={{ textAlign: 'center', lineHeight: '40px' }}>{item.name}</span>
                    </div>
                  );
                })}
              </div> */}
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
