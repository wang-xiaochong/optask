import { addUserInfo } from '@/request/userInfo';
import {
  ProCard,
  ProForm,
  ProFormDigit,
  ProFormSelect,
  ProFormText,
} from '@ant-design/pro-components';
import { Card, Col, message, Row, Space } from 'antd';
import { useRef } from 'react';

const UserAdd = () => {
  const formLayoutType = 'horizontal';
  const formRef: any = useRef();
  return (
    <ProCard>
      <Card>
        <ProForm
          readonly={false}
          layout={formLayoutType}
          formRef={formRef}
          // grid={grid}
          rowProps={{
            gutter: [16, 0],
          }}
          submitter={{
            render: (props, doms) => {
              return (
                <>
                  <Row>
                    <Col span={14} offset={4}>
                      <Space>{doms}</Space>
                    </Col>
                  </Row>
                </>
              );
            },
          }}
          onFinish={async (values) => {
            // await waitTime(2000);
            // console.log('values', values);
            await addUserInfo(values);
            message.success('添加成功');
            formRef.current?.resetFields(['account', 'password', 'name', 'roleInfo', 'job']);
          }}
          params={{}}
        >
          <ProFormText
            name="account"
            label="账号"
            tooltip="最长为 24 位"
            placeholder="请输入账号"
          />
          <ProFormText
            name="password"
            label="密码"
            required
            placeholder="请输入密码"
            initialValue={'123456'}
          />
          <ProFormText colProps={{ md: 12, xl: 8 }} name="name" label="姓名" />
          <ProFormDigit colProps={{ md: 12, xl: 8 }} name="roleInfo" label="角色" />
          <ProFormSelect
            colProps={{ xl: 8, md: 12 }}
            label="职位"
            name="job"
            valueEnum={{
              前端工程师: '前端工程师',
              后端工程师: '后端工程师',
              实习生: '实习生',
            }}
          />
        </ProForm>
      </Card>
    </ProCard>
  );
};

export default UserAdd;
