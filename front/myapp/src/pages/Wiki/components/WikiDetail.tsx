import { useEffect, useState } from 'react';
import Edit from './edit';
import './index.css';
const Wiki = () => {
  const [htmlContent, setHtmlContent] = useState();

  const getValue = (v) => {
    console.log(v);
  };

  useEffect(() => {}, []);

  return (
    <>
      <Edit getValue={getValue} />
    </>
  );
};

export default Wiki;
