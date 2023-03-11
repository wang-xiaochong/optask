import { getTaskInfoByID } from '@/request/taskInfo';
import { ProCard, ProFieldFCMode } from '@ant-design/pro-components';
import { Radio, Space, Switch } from 'antd';
import { useEffect, useState } from 'react';

const TaskDetail = () => {
  const [state, setState] = useState<ProFieldFCMode>('read');
  const [plain, setPlain] = useState<boolean>(false);
  const getID = () => {
    const arr = location.pathname.split('/');
    if (arr.length === 0) return 0;
    return arr[arr.length - 1];
  };
  const taskInfoID = getID();
  useEffect(() => {
    getTaskInfoByID(taskInfoID).then((res:{data:API.TaskInfo}) => {
      console.log(res);
      
    });
    console.log(taskInfoID);
  }, []);

  return (
    <ProCard>
      <>
        <Space>
          <Radio.Group onChange={(e) => setState(e.target.value as ProFieldFCMode)} value={state}>
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
