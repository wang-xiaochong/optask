import { currentUser } from '@/request/userInfo';
import { updateWikiContent } from '@/request/wikiInfo';
import { getNowFormatDate } from '@/utils/utils';
import { history } from '@umijs/max';
import { message } from 'antd';
import Editor from './Editor';
import './index.css';
const Wiki = () => {
  const updateContent = async (v) => {
    // console.log(v);
    const user = await currentUser();
    const data = {
      id: history.location.state.id,
      title: v.title,
      content: v.content,
      project: history.location.state.project,
      updateTime: getNowFormatDate(),
      updateInfo: user.data.id,
      parent: history.location.state.parent,
    };
    const res = await updateWikiContent(data);
    if (res.success) {
      message.success("更新成功")
    }
  };

  // useEffect(() => {
  //   console.log('history', history.location.state);
  // }, []);

  return (
    <>
      <Editor state={history.location.state} updateContent={updateContent} />
    </>
  );
};

export default Wiki;
