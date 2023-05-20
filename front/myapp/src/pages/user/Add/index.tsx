import { UserJob } from '@/pages/Components/User';
import { getAllRoleInfo } from '@/request/roleInfo';
import { addUserInfo } from '@/request/userInfo';
import {
  ProCard,
  ProForm,
  ProFormDigit,
  ProFormSelect,
  ProFormText,
} from '@ant-design/pro-components';
import { Card, Col, message, Row, Space } from 'antd';
import { useEffect, useRef, useState } from 'react';

const UserAdd = () => {
  const formLayoutType = 'horizontal';
  const formRef: any = useRef();
  const [role, setRole] = useState({});

  useEffect(() => {
    getAllRoleInfo().then((res) => {
      // console.log('res', res);
      let ret = {};
      for (let i = 0; i < res?.data?.length; i++) {
        const role = res?.data[i] as API.RoleInfo;
        if (role?.name) {
          ret[role.name] = role.name;
        }
      }
      setRole(ret);
    });
  })


  return (
    <ProCard>
      <Card style={{ width: "50%" }}>
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
          <ProFormSelect colProps={{ md: 12, xl: 8 }} name="roleInfo" label="角色" valueEnum={role} />
          <ProFormSelect
            colProps={{ xl: 8, md: 12 }}
            label="职位"
            name="job"
            valueEnum={UserJob}
          />
        </ProForm>
      </Card>
    </ProCard>
  );
};

export default UserAdd;
