import { currentUser } from '@/request/userInfo';
import { updateWikiContent } from '@/request/wikiInfo';
import { getNowFormatDate } from '@/utils/utils';
import { history } from '@umijs/max';
import { useEffect, useState } from 'react';
import Editor from './Editor';
import './index.css';
const Wiki = () => {
  const [htmlContent, setHtmlContent] = useState();
  const [state, setState] = useState(history.location.state);

  const updateContent = async (v) => {
    // console.log(v);
    const user = await currentUser();
    const data = {
      id: history.location.state.id,
      title: v.title,
      content: v.content,
      project: history.location.state.project,
      updateTime: getNowFormatDate(),
      updateInfo: user.data.id,
      parent: history.location.state.parent,
    };
    updateWikiContent(data);
  };

  useEffect(() => {
    console.log('history', history.location.state);
  }, []);

  return (
    <>
      <Editor state={history.location.state} updateContent={updateContent} />
    </>
  );
};

export default Wiki;
