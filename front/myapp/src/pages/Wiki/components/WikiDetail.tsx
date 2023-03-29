import { history } from '@umijs/max';
import { useEffect, useState } from 'react';
import Editor from './Editor';
import './index.css';
const Wiki = () => {
  const [htmlContent, setHtmlContent] = useState();

  const getValue = (v) => {
    console.log(v);
  };

  useEffect(() => {
    console.log('history', history.location.state);
  }, []);

  return (
    <>
      <Editor state={history.location.state} getValue={getValue} />
    </>
  );
};

export default Wiki;
