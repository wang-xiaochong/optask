import { getTaskInfoByID } from '@/request/taskInfo';
import { ProCard, ProFieldFCMode } from '@ant-design/pro-components';
import { history } from '@umijs/max';
import { Radio, Space, Switch } from 'antd';
import { useEffect, useState } from 'react';

const TaskDetail = () => {
  const [mode, setMode] = useState<ProFieldFCMode>('read');
  const [plain, setPlain] = useState<boolean>(false);

  const state = history.location.state;
  const taskInfoID = state?.id;
  useEffect(() => {
    getTaskInfoByID(taskInfoID).then((res: { data: API.TaskInfo }) => {
      console.log(res);
    });
    console.log(taskInfoID);
  }, []);

  return (
    <ProCard>
      <>
        <Space>
          <Radio.Group onChange={(e) => setMode(e.target.value as ProFieldFCMode)} value={mode}>
            <Radio value="read">只读</Radio>
            <Radio value="edit">编辑</Radio>
          </Radio.Group>
          简约模式
          <Switch checked={plain} onChange={(checked) => setPlain(checked)} />
        </Space>
        <br />
        <br />
      </>
    </ProCard>
  );
};
export default TaskDetail;
