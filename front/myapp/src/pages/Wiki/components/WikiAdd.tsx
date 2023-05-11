import { getAllProjectInfo } from '@/request/projectInfo';
import { addWikiInfo } from '@/request/wikiInfo';
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

const WikiAdd = (props: any) => {

  const [form] = Form.useForm<{ title: string; project: string; }>();
  const [projectName, setProjectName] = useState<{ value: string, label: string }[]>();
  const { refrehWikiList } = props;

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
  }, [])

  return (
    <ModalForm<{
      title: string;
      project: string;
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
        console.log(values);
        await addWikiInfo(values);
        message.success('提交成功');
        await refrehWikiList();
        return true;
      }}
    >
      <ProForm.Group>
        <ProFormText
          width="xl"
          name="title"
          label="wiki名称"
          tooltip="最长为 24 位"
          placeholder="请输入名称"
        />
      </ProForm.Group>

      <ProForm.Group>
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

export default WikiAdd;