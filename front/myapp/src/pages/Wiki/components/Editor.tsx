import { useEffect, useState } from 'react';
// 引入编辑器组件
import BraftEditor from 'braft-editor';
// 引入编辑器样式
import { getWikiInfoByProjectID } from '@/request/wikiInfo';
import { ProCard } from '@ant-design/pro-components';
import { history } from '@umijs/max';
import { Button, Input } from 'antd';
import 'braft-editor/dist/index.css';

const Editor = (props?: any) => {
  const { updateContent, state } = props;

  const [title, setTitle] = useState(state?.title);
  const [editor, setEditor] = useState(BraftEditor.createEditorState(null));
  const [editorEnable, setEditorEnable] = useState<boolean>(false);

  const submitContent = async () => {
    // 在编辑器获得焦点时按下ctrl+s会执行此方法
    // 编辑器内容提交到服务端之前，可直接调用editorState.toHTML()来获取HTML格式的内容
    const htmlContent = editor.toHTML();
    // console.log('htmlContent', htmlContent);

    updateContent({ title, content: htmlContent });
    setEditorEnable(false);
    // document.getElementById('htmlContent').innerHTML = editor.toHTML();
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
    getWikiInfoByProjectID(state?.id).then((res) => {
      // console.log('content', res?.data?.content);
      setEditor(BraftEditor.createEditorState(res?.data?.content));
    });

    // 使用BraftEditor.createEditorState将html字符串转换为编辑器需要的editorStat
    // this.setState({
    //   editorState: BraftEditor.createEditorState(htmlContent),
    // });
  }, []);
  useEffect(() => {
    if (document.getElementById('htmlContent')) {
      document.getElementById('htmlContent').innerHTML = editor.toHTML();
    }
  }, [editor]);

  return (
    <>
      <ProCard>
        <Button
          type="link"
          onClick={() => {
            history.push('/wiki/list');
          }}
        >
          返回
        </Button>
        <span>标题</span>
        <Input
          style={{ display: 'inline-block', width: '50%', marginLeft: '10px' }}
          placeholder="请输入标题"
          value={title}
          onChange={handleTitle}
          disabled={!editorEnable}
        />
        <Button
          style={{ display: editorEnable ? 'inline-block' : 'none' }}
          type="primary"
          onClick={submitContent}
        >
          保存
        </Button>
        <Button
          style={{ display: editorEnable ? 'none' : 'inline-block' }}
          type="primary"
          onClick={() => setEditorEnable(true)}
        >
          编辑
        </Button>
        <BraftEditor
          style={{ display: editorEnable ? 'block' : 'none' }}
          value={editor}
          onChange={handleEditorChange}
          onSave={submitContent}
        />
        <div id="htmlContent" style={{ display: editorEnable ? 'none' : 'block' }}></div>
      </ProCard>
    </>
  );
};

export default Editor;
