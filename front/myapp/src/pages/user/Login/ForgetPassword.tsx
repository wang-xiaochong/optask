import { resetPassword } from '@/request/userInfo';
import {
  ModalForm,
  ProForm,
  ProFormText,
} from '@ant-design/pro-components';
import { FormattedMessage } from '@umijs/max';
import { Form, message } from 'antd';

const isSamePassword = async (values: formDataType) => {
  if (!values.account || !values.password || !values.phone || !values.confirmPassword) {
    message.info("缺少必填项");
    return false;
  }

  if (values["password"] !== values["confirmPassword"]) {
    message.info("请再次确认新密码");
    return false;
  }
  return true;
};


const handleSubmit = async (values: API.ResetPasswordParams): Promise<boolean> => {
  console.log('values', values);
  const ret = await resetPassword(values);
  return ret.success
};

interface formDataType { account: string; password: string; confirmPassword: string; phone: string }

const ForgetPassword = () => {
  const [form] = Form.useForm<formDataType>();
  return (
    <ModalForm<formDataType>
      width={350}
      title="重置密码"
      trigger={
        <a
          style={{
            float: 'right',
            display: "inline-block",
            height: 30,
          }}
        >
          <FormattedMessage id="pages.login.forgotPassword" defaultMessage="忘记密码" />
        </a>

      }
      form={form}
      noValidate={false}
      autoFocusFirstInput
      modalProps={{
        destroyOnClose: true,
        onCancel: () => console.log('run'),
      }}
      submitTimeout={2000}
      onFinish={async (values) => {
        const ret = await isSamePassword(values);
        if (ret) {
          if (await handleSubmit(values as API.ResetPasswordParams)) {
            message.success('修改成功');
            return true;
          }
        }
      }}
    >
      <ProForm.Group>
        <ProFormText
          width="md"
          name="account"
          label="账号"
          placeholder="请输入账号"
          required
        />
      </ProForm.Group>
      <ProForm.Group>
        <ProFormText.Password
          width="md"
          name="password"
          label="新密码"
          placeholder="请输入新密码"
          required
        />
      </ProForm.Group>
      <ProForm.Group>
        <ProFormText.Password
          width="md"
          name="confirmPassword"
          label="确认新密码"
          placeholder="请确认新密码"
        />
      </ProForm.Group>
      <ProForm.Group>
        <ProFormText
          width="md"
          name="phone"
          label="手机号"
          placeholder="请输入手机号"
          required
        />
      </ProForm.Group>
    </ModalForm>
  );
};

export default ForgetPassword