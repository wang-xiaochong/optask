import { currentUser, updateUserInfoByID } from '@/request/userInfo';
import {
  ProCard,
  ProForm,
  ProFormDatePicker,
  ProFormSelect,
  ProFormText,
} from '@ant-design/pro-components';
import { Avatar, Button, Col, message, Row, Space } from 'antd';
import { useEffect, useState } from 'react';

const Personal = () => {
  const formLayoutType = 'horizontal';
  const [user, setUser] = useState<API.CurrentUser>();
  const [editEnable, setEditEnable] = useState(false);

  const initData = async () => {
    const userRet = await currentUser();
    setUser(userRet.data);
  };

  const myCurrentUser = async () => {
    const userRet = await currentUser();
    return userRet.data;
  };

  useEffect(() => {
    initData();
  }, []);

  return (
    <ProCard>
      <ProForm
        readonly={!editEnable}
        layout={formLayoutType}
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
                    <Space>
                      {editEnable ? (
                        doms
                      ) : (
                        <Button onClick={() => setEditEnable(!editEnable)}>编辑</Button>
                      )}
                    </Space>
                  </Col>
                </Row>
              </>
            );
          },
        }}
        onFinish={async (values) => {
          // await waitTime(2000);
          values['id'] = user?.id;
          values['avatar'] = user?.avatar;
          console.log(values);
          await updateUserInfoByID(values);
          message.success('提交成功');
          setEditEnable(!editEnable);
        }}
        params={{}}
        request={myCurrentUser}
      >
        <div style={{ margin: '10px' }}>
          头像：
          <Avatar size={64} src={user?.avatar} />
        </div>
        <ProFormText name="account" label="账号" tooltip="最长为 24 位" placeholder="请输入账号" />
        <ProFormText colProps={{ md: 12, xl: 8 }} name="name" label="姓名" />
        {/* <ProFormDigit colProps={{ md: 12, xl: 8 }} name="email" label="邮箱" /> */}
        <ProFormText colProps={{ md: 12, xl: 8 }} name="email" label="邮箱" />
        <ProFormText colProps={{ md: 12, xl: 8 }} name="phone" label="电话" />
        <ProFormText colProps={{ md: 12, xl: 8 }} name="roleInfo" label="角色" />
        <ProFormDatePicker colProps={{ xl: 8, md: 12 }} label="生日" name="birthday" />
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
    </ProCard>
  );
};

export default Personal;
