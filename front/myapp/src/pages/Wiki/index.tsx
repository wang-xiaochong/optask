import { history } from '@umijs/max';
import { Collapse } from 'antd';
import { useEffect } from 'react';
const { Panel } = Collapse;
const WikiList = () => {
  const getValue = (v) => {
    console.log(v);
  };

  useEffect(() => {}, []);

  const onClick = () => {
    console.log('clickpathname', location);
    history.push(`${location.pathname}/detail`, { data: 123 });
  };

  const text = (
    <p style={{ paddingLeft: 24 }}>
      A dog is a type of domesticated animal. Known for its loyalty and faithfulness, it can be
      found as a welcome guest in many households across the world.
    </p>
  );

  return (
    <>
      <div>
        <Collapse bordered={false} defaultActiveKey={['1']}>
          <Panel header="This is panel header 1" key="1">
            {text}
          </Panel>
          <Panel header="This is panel header 2" key="2">
            {text}
          </Panel>
          <Panel header="This is panel header 3" key="3">
            {text}
          </Panel>
        </Collapse>
        <button type="button" onClick={onClick}>
          click
        </button>
      </div>
    </>
  );
};

export default WikiList;
