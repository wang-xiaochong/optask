import { TaskInfoStatusOptions, TaskInfoTypeOptions } from '@/pages/Components/Task';
import { getTaskInfoByID, updateTaskContent } from '@/request/taskInfo';
import { getAllUserInfo } from '@/request/userInfo';
import { getNowFormatDate } from '@/utils/utils';
import {
  ProCard,
  ProFieldFCMode,
  ProForm,
  ProFormDatePicker,
  ProFormDigit,
  ProFormRadio,
  ProFormSelect,
  ProFormText,
} from '@ant-design/pro-components';
import { history } from '@umijs/max';
import { Card, message, Radio, Space } from 'antd';
import BraftEditor from 'braft-editor';
import { useEffect, useState } from 'react';

const TaskDetail = () => {
  const [mode, setMode] = useState<ProFieldFCMode>('read');
  const [formData, setFormData] = useState<API.TaskInfo>();
  const [userName, setUserName] = useState<any>([]);
  const [editor, setEditor] = useState(BraftEditor.createEditorState(null));

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

  useEffect(() => {
    if (document.getElementById('htmlContent')) {
      document.getElementById('htmlContent').innerHTML = editor.toHTML();
    }
  }, [editor]);
  const getFormData = async () => {
    const taskInfoRes = await getTaskInfoByID(taskInfoID);
    setFormData(taskInfoRes.data);
    setEditor(BraftEditor.createEditorState(taskInfoRes.data?.detail));
    // console.log('taskInfoRes.data', taskInfoRes.data);
    return taskInfoRes.data;
  };
  const updateFormData = async (values: any) => {
    const htmlContent = editor.toHTML();
    // console.log('htmlContent', htmlContent);
    values['detail'] = htmlContent;
    values['id'] = formData?.id;
    values['parent'] = formData?.parent;
    values['project'] = formData?.project;
    values['updateTime'] = getNowFormatDate();
    console.log(values);
    const res = await updateTaskContent(values);
    if (res.success) {
      message.success("提交成功");
    }
    setMode('read');
  };
  const handleEditorChange = (editor: any) => {
    setEditor(editor);
  };
  const submitContent = async () => {
    // 在编辑器获得焦点时按下ctrl+s会执行此方法
    // 编辑器内容提交到服务端之前，可直接调用editorState.toHTML()来获取HTML格式的内容
    const htmlContent = editor.toHTML();
    console.log('htmlContent', htmlContent);

    // updateContent({ title, content: htmlContent });
    // setEditorEnable(false);
    // document.getElementById('htmlContent').innerHTML = editor.toHTML();
    // const result = await saveEditorContent(htmlContent);
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
              render: (_, doms) => (
                <span className={mode === 'read' ? 'none' : undefined}>
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
            onFinish={updateFormData}
          >
            <h6>
              <span> #id:{formData?.id}</span>
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
              <ProForm.Group>
                <ProFormSelect options={userName} width="xs" name="createdBy" label="创建人" />
                <ProFormSelect options={userName} width="xs" name="appoint" label="指定人" />
                {/* <ProFormText name={['contract', 'name']} label="合同名称" placeholder="请输入名称" /> */}
                <ProFormDigit width="xs" name="estimatedTime" label="估计的时间" />
                <ProFormDigit width="xs" name="consumeTime" label="已耗时间" />
                <ProFormDigit width="xs" name="leftTime" label="剩余时间" />
                <ProFormDatePicker
                  colProps={{ xl: 8, md: 12 }}
                  label="开始日期"
                  name="createdTime"
                />
                <ProFormDatePicker colProps={{ xl: 8, md: 12 }} label="结束日期" name="endTime" />
                <ProFormRadio.Group label="优先级" name="leval" options={['高', '中', '低']} />
              </ProForm.Group>
              <div>
                <ProForm.Group>
                  <label>任务详情</label>
                  <div
                    style={{
                      display: mode === 'read' ? 'none' : 'block',
                      width: '100%',
                      height: '630px',
                      border: '1px solid #ececec',
                      margin: '5px 0 10px 0',
                    }}
                  >
                    <BraftEditor
                      value={editor}
                      onChange={handleEditorChange}
                      onSave={submitContent}
                    />
                  </div>
                  <div
                    id="htmlContent"
                    style={{ display: mode === 'read' ? 'block' : 'none' }}
                  ></div>
                </ProForm.Group>
              </div>
            </ProForm.Group>
          </ProForm>
        </Card>
      </>
    </ProCard>
  );
};
export default TaskDetail;
