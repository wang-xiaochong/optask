import { ProjectInfoStatusOptions } from '@/pages/Components/Project';
import { addProjectInfo, getAllProjectInfo } from '@/request/projectInfo';
import { waitTime } from '@/utils/utils';
import { PlusOutlined } from '@ant-design/icons';
import {
  ModalForm,
  ProForm,
  ProFormSelect,
  ProFormText,
} from '@ant-design/pro-components';
import { Button, Form, message } from 'antd';
// import { useEffect, useState } from 'react';

const ProjectAdd = (props: any) => {

  const [form] = Form.useForm<{ name: string; status: string; description: string; }>();
  // const [projectName, setProjectName] = useState<{ value: string, label: string }[]>();
  const { refreshProject } = props;

  // useEffect(() => {
  //   getAllProjectInfo().then((res) => {
  //     let ret = [];
  //     for (let i = 0; i < res?.data?.length; i++) {
  //       const project = res?.data[i] as API.ProjectInfo;
  //       if (project?.name) {
  //         ret.push({ value: project?.name, label: project?.name });
  //       }
  //     }
  //     // console.log('project:', ret);
  //     setProjectName(ret);
  //   });
  // }, [])

  return (
    <ModalForm<{
      name: string;
      status: string;
      // parent: string;
      description: string;
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
      submitTimeout={1000}
      onFinish={async (values) => {
        await waitTime(500);
        // console.log(values);
        await addProjectInfo(values);
        message.success('提交成功');
        refreshProject();
        return true;
      }}
    >
      <ProForm.Group>
        <ProFormText
          width="md"
          name="name"
          label="项目名称"
          tooltip="最长为 24 位"
          placeholder="请输入名称"
          required
        />
        <ProFormSelect
          request={async () => ProjectInfoStatusOptions}
          width="sm"
          name="status"
          label="状态"
          required
        />
      </ProForm.Group>

      <ProForm.Group>


        {/* <ProFormSelect
          request={async () => projectName}
          width="md"
          name="parent"
          label="父级"
        /> */}
      </ProForm.Group>
      <ProForm.Group>
        <ProFormText
          width="xl"
          name="description"
          label="简介"
          required
        />
      </ProForm.Group>
    </ModalForm>
  );
};

export default ProjectAdd;