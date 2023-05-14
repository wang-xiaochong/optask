import { history } from '@umijs/max';
import { ProjectInfoStatus, TaskInfoStatus, TaskInfoType } from '@/request/enum';
import { Bar } from '@ant-design/charts';
import {
  ProCard,
  ProForm,
  ProFormGroup,
  ProFormSelect,
  ProFormText,
} from '@ant-design/pro-components';
import { Switch } from 'antd';
import { useEffect, useState } from 'react';
import { getTaskInfoByProjectID } from '@/request/taskInfo';
import { getProjectInfoByID } from '@/request/projectInfo';
import { getAllUserInfo, getUserInfoById } from '@/request/userInfo';

const ProjectDetail = () => {
  const [readonly, setReadonly] = useState(false);
  const [tasksInfo, setTasksInfo] = useState<API.TaskInfo[]>([]);
  const [userName, setUserName] = useState();
  const [tasksInfoRender, setTasksInfoRender] = useState<
    { value: number; type: TaskInfoType; status: TaskInfoStatus }[]
  >([]);
  const projectID = history.location.state?.title;

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

  const getProject = async () => {
    const projectInfo: API.ProjectInfo = (await getProjectInfoByID(projectID))?.data;
    // console.log('项目详情：', projectInfo);
    const userInfo = projectInfo.userInfo?.split(",");
    projectInfo.userInfo = userInfo as any;
    return projectInfo;
  }

  const getAllUser = async () => {
    let userData = await getAllUserInfo();
    let tmp = {};
    userData.data.forEach((user) => {
      tmp[user.id] = user.name
    })
    console.log('tmp', tmp);
    setUserName(tmp);

  }

  useEffect(() => {
    console.log('history.location.state', history.location.state);

    if (projectID) {
      getTaskInfoByProjectID(projectID).then((res: { data: API.TaskInfo[] }) => {
        // console.log('对应项目任务列表：', res);
        setTasksInfo(res?.data);
      });
      // console.log('项目ID: ', projectID);
      getProject();
    }
    getAllUser();

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

  return (
    <div
      style={{
        padding: 24,
      }}
    >
      <Switch
        style={{
          marginBlockEnd: 16,
        }}
        checked={readonly}
        checkedChildren="编辑"
        unCheckedChildren="只读"
        onChange={setReadonly}
      />
      <ProForm
        readonly={!readonly}
        name="validate_other"
        request={getProject}
        onValuesChange={(_, values) => {
          console.log(values);
        }}
        onFinish={async (value) => console.log(value)}
        submitter={{
          render: (_, doms) => (
            <span className={!readonly ? 'none' : undefined}>
              {doms.map((dom) => {
                return (
                  <span style={{ margin: '0 10px 0 10px' }} key={dom.key}>
                    {dom}
                  </span>
                );
              })}
            </span>
          ),
        }}
      >
        <ProFormGroup
          // title="文本类"
          // collapsible
          style={{
            gap: '0 32px',
          }}
        >
          <ProFormText width="md" name="name" label="名称" />
          <ProFormSelect
            name="status"
            label="状态"
            valueEnum={ProjectInfoStatus}
            // placeholder="Please select a country"
            rules={[{ required: true, message: '请选择项目状态' }]}
          />
          <ProFormSelect
            name="userInfo"
            label="成员"
            // valueEnum={{
            //   "red": 'Red',
            //   green: 'Green',
            //   blue: 'Blue',
            // }}
            width="xl"
            valueEnum={userName}
            fieldProps={{
              mode: 'multiple',
            }}
            // placeholder="Please select favorite colors"
            rules={[
              {
                required: true,
                message: 'Please select your favorite colors!',
                type: 'array',
              },
            ]}
          />
          <ProFormText width={740} name="description" label="简介" />

        </ProFormGroup>
      </ProForm>
      <div>
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
      </div>
    </div>
  );
};

export default ProjectDetail;