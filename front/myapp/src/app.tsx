/* eslint-disable react-hooks/rules-of-hooks */
import { Question } from '@/components/RightContent';
import { TaskOptionsDropdown } from '@/components/RightContent/TaskOptions';
import { LinkOutlined } from '@ant-design/icons';
import { PageLoading, SettingDrawer, Settings as LayoutSettings } from '@ant-design/pro-components';
import type { RequestConfig, RunTimeLayoutConfig } from '@umijs/max';
import { history, Link } from '@umijs/max';
import defaultSettings from '../config/defaultSettings';
import { AvatarDropdown, AvatarName } from './components/RightContent/AvatarDropdown';
import { currentUser as queryCurrentUser } from './request/userInfo';
import { errorConfig } from './requestErrorConfig';
const isDev = process.env.NODE_ENV === 'development';
const loginPath = '/user/login';

/**
 * @see  https://umijs.org/zh-CN/plugins/plugin-initial-state
 * */
export async function getInitialState(): Promise<{
  settings?: Partial<LayoutSettings>;
  currentUser?: API.CurrentUser;
  loading?: boolean;
  fetchUserInfo?: () => Promise<API.CurrentUser | undefined>;
}> {
  const fetchUserInfo = async () => {
    try {
      const msg = await queryCurrentUser({
        skipErrorHandler: true,
      });
      return msg.data;
    } catch (error) {
      history.push(loginPath);
    }
    return undefined;
  };
  // 如果不是登录页面，执行
  const { location } = history;
  if (location.pathname !== loginPath) {
    // const currentUser = await fetchUserInfo();
    const currentUser = await fetchUserInfo();
    return {
      fetchUserInfo,
      currentUser,
      settings: defaultSettings as Partial<LayoutSettings>,
    };
  }
  return {
    fetchUserInfo,
    settings: defaultSettings as Partial<LayoutSettings>,
  };
}

// ProLayout 支持的api https://procomponents.ant.design/components/layout
export const layout: RunTimeLayoutConfig = ({ initialState, setInitialState }) => {
  return {
    actionsRender: () => [
      <TaskOptionsDropdown key="task" />,
      <Question key="doc" />,
      // <SelectLang key="SelectLang" />
    ],
    avatarProps: {
      src: initialState?.currentUser?.avatar,
      title: <AvatarName />,
      render: (_, avatarChildren) => {
        return <AvatarDropdown>{avatarChildren}</AvatarDropdown>;
      },
    },

    menuDataRender: (menuData) => {
      // const [menuItems, setMenuItems] = useState();
      // useEffect(() => {
      //   console.log('useEffect:', menuData);
      // }, []);
      return menuData.filter((item) => item.name !== 'wiki.wiki-list');
    },
    // waterMarkProps: {
    //   content: initialState?.currentUser?.name,
    // },
    // footerRender: () => <Footer />,
    onPageChange: () => {
      const { location } = history;
      // 如果没有登录，重定向到 login
      if (!initialState?.currentUser && location.pathname !== loginPath) {
        history.push(loginPath);
      }
    },
    links: isDev
      ? [
          <Link key="openapi" to="/umi/plugin/openapi" target="_blank">
            <LinkOutlined />
            <span>OpenAPI 文档</span>
          </Link>,
        ]
      : [],
    menuHeaderRender: undefined,

    // menuRender: (children) => {
    //   console.log('children:', children);
    //   // return <>{children}</>;
    // },
    // headerRender: false, //隐藏顶部蓝，使用自定义
    // 自定义 403 页面
    // unAccessible: <div>unAccessible</div>,
    // 增加一个 loading 的状态
    childrenRender: (children) => {
      if (initialState?.loading) return <PageLoading />;

      return (
        <>
          {/* <Affix>
            <div
              style={{ height: '60px', width: '100vw', backgroundColor: 'rgba(0, 0, 0, .1)' }}
            ></div>
          </Affix> */}
          {/* <div style={{ display: 'flex' }}>
            <div style={{ width: '20vw', height: '100vh', backgroundColor: 'red' }}></div>
            <div style={{ flex: 1 }}>{children}</div>
          </div> */}
          {children}

          <SettingDrawer
            disableUrlParams
            enableDarkTheme
            settings={initialState?.settings}
            onSettingChange={(settings) => {
              setInitialState((preInitialState) => ({
                ...preInitialState,
                settings,
              }));
            }}
          />
        </>
      );
    },

    ...initialState?.settings,
    // fixSiderbar: false,
  };
};

/**
 * @name request 配置，可以配置错误处理
 * 它基于 axios 和 ahooks 的 useRequest 提供了一套统一的网络请求和错误处理方案。
 * @doc https://umijs.org/docs/max/request#配置
 */
export const request: RequestConfig = {
  ...errorConfig,
  baseURL: REACT_APP_BASEURL,
};
