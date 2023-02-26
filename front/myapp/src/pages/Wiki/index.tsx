import { DeleteOutlined, PlusOutlined } from '@ant-design/icons';
import { Button, Form, Input } from 'antd';
import BraftEditor from 'braft-editor';

const Wiki = () => {
  const handleSubmit = () => {
    console.log('handleSubmit');
  };

  return (
    <>
      <Form onFinish={handleSubmit} layout="horizontal" autoComplete="off">
        <Form.List name="moduleExtras">
          {(fields, { add, remove }) => (
            <>
              {fields.map((field) => {
                return (
                  <div
                    key={field.key}
                    // className={styles.formItem}
                    style={{ height: '500px', width: '800px' }}
                  >
                    <div
                      // className={styles.formItemHeader}
                      style={{ height: '100px' }}
                    >
                      <Form.Item
                        {...field}
                        label="标题"
                        name={[field.name, 'title']}
                        // fieldKey={[field.fieldKey, 'title']}
                      >
                        <Input placeholder="请输入标题" allowClear style={{ width: 300 }} />
                      </Form.Item>
                      <Button onClick={() => remove(field.name)} icon={<DeleteOutlined />} danger>
                        删除
                      </Button>
                    </div>
                    <Form.Item
                      {...field}
                      name={[field.name, 'content']}
                      // fieldKey={[field.fieldKey, 'content']}
                    >
                      <BraftEditor
                        style={{ border: '1px solid #dedede', marginTop: 10 }}
                        // controls={controls}
                        placeholder="请输入正文内容"
                      />
                    </Form.Item>
                  </div>
                );
              })}
              <Form.Item>
                <Button type="default" onClick={() => add()} icon={<PlusOutlined />}>
                  新增模块
                </Button>
              </Form.Item>
            </>
          )}
        </Form.List>
        <Form.Item style={{ marginTop: 10 }}>
          <Button type="primary" htmlType="submit">
            保存配置
          </Button>
        </Form.Item>
      </Form>
    </>
  );
};

export default Wiki;
