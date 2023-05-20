import { TaskInfoLevalOptions, TaskInfoStatusOptions, TaskInfoTypeOptions } from '@/pages/Components/Task';
import { getAllProjectInfo } from '@/request/projectInfo';
import { addTaskInfo } from '@/request/taskInfo';
import { currentUser } from '@/request/userInfo';
import { waitTime } from '@/utils/utils';
import { PlusOutlined } from '@ant-design/icons';
import {
  ModalForm,
  ProForm,
  ProFormSelect,
  ProFormText,
} from '@ant-design/pro-components';
import { Button, Form, message } from 'antd';
import { useEffect, useState } from 'react';

const TaskAdd = (props: any) => {

  const [form] = Form.useForm<{ name: string; type: string; status: string; leval: string; project: string; appoint: string, createdBy: string }>();
  const [projectName, setProjectName] = useState<{ value: string, label: string }[]>([]);
  const { refreshTaskInfo } = props;
  const [createdBy, setCreatedBy] = useState<string>();

  useEffect(() => {
    getAllProjectInfo().then((res) => {
      let ret = [];
      for (let i = 0; i < res?.data?.length; i++) {
        const project = res?.data[i] as API.ProjectInfo;
        if (project?.name) {
          ret.push({ value: project?.name, label: project?.name });
        }
      }
      // console.log('project:', ret);
      setProjectName(ret);
    });
    currentUser().then((res) => {
      if (res?.data.name) {
        setCreatedBy(res?.data.name);
      }
    })

  }, [])

  return (
    <ModalForm<{
      name: string;
      type: string;
      status: string;
      leval: string;
      appoint: string;
      createdBy: string;
    }>
      title="新建"
      trigger={
        <Button type="primary">
          <PlusOutlined />
          新建
        </Button>
      }
      form={form}
      autoFocusFirstInput
      modalProps={{
        destroyOnClose: true,
        onCancel: () => console.log('run'),
      }}
      submitTimeout={2000}
      onFinish={async (values) => {
        await waitTime(500);
        values["createdBy"] = createdBy!;
        // console.log(values);
        await addTaskInfo(values);
        message.success('提交成功');
        await refreshTaskInfo();
        return true;
      }}
    >
      <ProForm.Group>
        <ProFormText
          width="xl"
          name="name"
          label="任务名称"
          tooltip="最长为 24 位"
          placeholder="请输入名称"
        />
      </ProForm.Group>

      <ProForm.Group>
        <ProFormSelect
          width="md"
          name="createdBy"
          label="创建人"
          hidden
        />
        <ProFormSelect
          request={async () => TaskInfoTypeOptions}
          width="md"
          name="type"
          label="类型"
        />
        <ProFormSelect
          request={async () => TaskInfoStatusOptions}
          width="md"
          name="status"
          label="状态"
        />
        <ProFormSelect
          request={async () => TaskInfoLevalOptions}
          width="md"
          name="leval"
          label="优先级"
        />
        <ProFormSelect
          request={async () => projectName}
          width="md"
          name="project"
          label="所属项目"
        />
      </ProForm.Group>
    </ModalForm>
  );
};

export default TaskAdd;