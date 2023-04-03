import { updateWikiContent } from '@/request/wikiInfo';
import { history } from '@umijs/max';
import { useEffect, useState } from 'react';
import Editor from './Editor';
import './index.css';
const Wiki = () => {
  const [htmlContent, setHtmlContent] = useState();
  const [state, setState] = useState(history.location.state);

  const updateContent = (v) => {
    console.log(v);
    const data = {
      id: history.location.state.id,
      title: v.title,
      content: v.content,
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
