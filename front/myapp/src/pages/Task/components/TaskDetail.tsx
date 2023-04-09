import { TaskInfoStatusOptions, TaskInfoTypeOptions } from '@/pages/Components/Task';
import { getTaskInfoByID } from '@/request/taskInfo';
import { getAllUserInfo } from '@/request/userInfo';
import {
  ProCard,
  ProFieldFCMode,
  ProForm,
  ProFormDatePicker,
  ProFormDigit,
  ProFormRadio,
  ProFormSelect,
  ProFormText,
  ProFormTextArea,
} from '@ant-design/pro-components';
import { history } from '@umijs/max';
import { Card, Radio, Space } from 'antd';
import { useEffect, useState } from 'react';

const TaskDetail = () => {
  const [mode, setMode] = useState<ProFieldFCMode>('read');
  const [formData, setFormData] = useState<API.TaskInfo>();
  const [userName, setUserName] = useState<any>([]);

  const state = history.location.state;
  const taskInfoID = state?.id;
  useEffect(() => {
    getAllUserInfo().then((res) => {
      let ret = [];
      for (let i = 0; i < res?.data?.length; i++) {
        const user = res?.data[i] as API.CurrentUser;
        if (user?.name) {
          ret.push({ value: user.name, label: user.name, id: user.id });
        }
      }
      setUserName(ret);
    });
  }, []);
  const getFormData = async () => {
    const taskInfoRes = await getTaskInfoByID(taskInfoID);
    setFormData(taskInfoRes.data);
    console.log('taskInfoRes.data', taskInfoRes.data);
    return taskInfoRes.data;
  };
  const updateFormData = async (values: any) => {
    console.log(values);
  };

  return (
    <ProCard>
      <>
        <Space>
          <Radio.Group onChange={(e) => setMode(e.target.value as ProFieldFCMode)} value={mode}>
            <Radio value="read">只读</Radio>
            <Radio value="edit">编辑</Radio>
          </Radio.Group>
        </Space>
        <br />
        <br />
        <Card>
          <ProForm
            readonly={mode === 'read' ? true : false}
            request={getFormData}
            // submitter={{
            //   render: (_, dom) => <FooterToolbar>{dom}</FooterToolbar>,
            // }}
            submitter={{
              render: (_, dom) => (
                <span style={{ visibility: mode === 'read' ? 'hidden' : 'visible' }}>{dom}</span>
              ),
            }}
            onFinish={updateFormData}
          >
            <h6>
              <span> #id:{1000 + formData?.id}</span>
              <span>最后更新日期：{formData?.updateTime}</span>
            </h6>

            <ProForm.Group>
              <ProFormSelect options={TaskInfoStatusOptions} width="xs" name="status" label="" />
              <ProFormSelect options={TaskInfoTypeOptions} width="xs" name="type" label="" />
              <ProFormText
                name="name"
                label=""
                tooltip="最长为 24 位"
                placeholder="请输入名称"
                width="xl"
              />
            </ProForm.Group>
            <ProForm.Group>
              <ProFormTextArea width={900} label="任务详情" name="detail" labelAlign="left" />
            </ProForm.Group>

            <ProForm.Group>
              <ProFormSelect options={userName} width="xs" name="createdBy" label="创建人" />
              <ProFormSelect options={userName} width="xs" name="appoint" label="指定人" />
              {/* <ProFormText name={['contract', 'name']} label="合同名称" placeholder="请输入名称" /> */}
            </ProForm.Group>
            <ProForm.Group>
              <ProFormDigit width="xs" name="estimatedTime" label="估计的时间" />
              <ProFormDigit width="xs" name="consumeTime" label="已耗时间" />
              <ProFormDigit width="xs" name="leftTime" label="剩余时间" />
            </ProForm.Group>
            <ProForm.Group>
              <ProFormDatePicker colProps={{ xl: 8, md: 12 }} label="开始日期" name="createdTime" />
              <ProFormDatePicker colProps={{ xl: 8, md: 12 }} label="结束日期" name="endTime" />
            </ProForm.Group>
            <ProForm.Group>
              <ProFormRadio.Group
                label="优先级"
                name="invoiceType"
                initialValue="高"
                options={['高', '中', '低']}
              />
            </ProForm.Group>
          </ProForm>
        </Card>
      </>
    </ProCard>
  );
};
export default TaskDetail;
