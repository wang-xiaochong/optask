import { useEffect, useState } from 'react';
// 引入编辑器组件
import BraftEditor from 'braft-editor';
// 引入编辑器样式
import { ProCard } from '@ant-design/pro-components';
import { Button, Input } from 'antd';
import 'braft-editor/dist/index.css';

const Editor = (props?: any) => {
  const { getValue, state } = props;

  const [title, setTitle] = useState(state?.title);
  const [editor, setEditor] = useState(BraftEditor.createEditorState(null));

  const submitContent = async () => {
    // 在编辑器获得焦点时按下ctrl+s会执行此方法
    // 编辑器内容提交到服务端之前，可直接调用editorState.toHTML()来获取HTML格式的内容
    const htmlContent = editor.toHTML();
    console.log('htmlContent', htmlContent);

    // const result = await saveEditorContent(htmlContent);
  };

  const handleTitle = (v: any) => {
    setTitle(v?.target?.value);
  };

  const handleEditorChange = (editor: any) => {
    setEditor(editor);
  };

  useEffect(() => {
    // 假设此处从服务端获取html格式的编辑器内容
    // const htmlContent = await fetchEditorContent();
    // 使用BraftEditor.createEditorState将html字符串转换为编辑器需要的editorStat
    // this.setState({
    //   editorState: BraftEditor.createEditorState(htmlContent),
    // });
  }, []);

  return (
    <>
      <ProCard>
        <span>标题</span>
        <Input
          style={{ display: 'inline-block', width: '50%', marginLeft: '10px' }}
          placeholder="请输入标题"
          value={title}
          onChange={handleTitle}
        />
        <Button type="primary" onClick={() => getValue({ title, content: editor.toHTML() })}>
          保存
        </Button>
        <BraftEditor value={editor} onChange={handleEditorChange} onSave={submitContent} />
      </ProCard>
    </>
  );
};

export default Editor;
