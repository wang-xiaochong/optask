// import { PageContainer } from '@ant-design/pro-components';
// import React from 'react';

// const Welcome: React.FC = () => {
//   return <PageContainer></PageContainer>;
// };

// export default Welcome;
// import { RouterInfoType } from '@/request/enum';
import { history } from '@umijs/max';
import { Card, Col, Row } from 'antd';
import React from 'react';

const Welcome: React.FC = (props: any) => {
  // console.log('welcomeProps', props);
  // const { getRouterInfoByMenuType } = props;
  const paddingStyle = { padding: "20px" }
  let pathname = location.pathname.slice(0, -8);
  return <>
    <div style={paddingStyle}>
      <Row gutter={16}>
        <Col span={8}>
          <Card onClick={() => {
            history.push(`${pathname}/project/list`);
            // getRouterInfoByMenuType(RouterInfoType.project);
          }}
            hoverable
            bordered
          >
            项目模块
          </Card>
        </Col>
        <Col span={8}>
          <Card
            onClick={() => {
              history.push(`${pathname}/task/list`);
            }}
            hoverable
            bordered
          >
            任务模块
          </Card>
        </Col>
      </Row>
    </div>
    <div style={paddingStyle}>
      <Row gutter={16}>
        <Col span={8}>
          <Card
            onClick={() => {
              history.push(`${pathname}/wiki/list`);
            }}
            hoverable
            bordered
          >
            wiki模块
          </Card>
        </Col>
        <Col span={8}>
          <Card
            onClick={() => {
              history.push(`${pathname}/personal`);
            }}
            hoverable
            bordered
          >
            个人中心
          </Card>
        </Col>
      </Row>
    </div>
  </>
};

export default Welcome;
