import { history } from '@umijs/max';
import { useEffect } from 'react';
const WikiList = () => {
  const getValue = (v) => {
    console.log(v);
  };

  useEffect(() => {}, []);

  const onClick = () => {
    console.log('clickpathname', location);
    history.push(`${location.pathname}?title=?&id=?`);
  };

  return (
    <>
      <div>
        <button type="button" onClick={onClick}>
          click
        </button>
      </div>
    </>
  );
};

export default WikiList;
