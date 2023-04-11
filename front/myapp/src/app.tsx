/* eslint-disable react-hooks/rules-of-hooks */
import { TaskOptionsDropdown } from '@/components/RightContent/TaskOptions';
import { LinkOutlined } from '@ant-design/icons';
import { PageLoading, Settings as LayoutSettings } from '@ant-design/pro-components';
import type { RequestConfig, RunTimeLayoutConfig } from '@umijs/max';
import { history, Link } from '@umijs/max';
import { message } from 'antd';
import { useEffect, useState } from 'react';
import defaultSettings from '../config/defaultSettings';
import { AvatarDropdown, AvatarName } from './components/RightContent/AvatarDropdown';
import { RouterInfoType } from './request/enum';
import { getAllRouterInfo } from './request/routerInfo';
import { API } from './request/typings';
import { currentUser as queryCurrentUser, getRoleInfoByUserRoleInfo } from './request/userInfo';
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
  menuType?: RouterInfoType;
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
  type projectRender = {
    value?: string;
    label?: string;
    disabled?: boolean;
  };
  const [menuItems, setMenuItems] = useState<Array<API.RouterInfo>>([]);
  const [isShowSide, setIsShowSide] = useState<boolean>(false);
  const [routerInfo, setRouterInfo] = useState<any>([]);
  // const [menuType, setMenuType] = useState<RouterInfoType>();

  const routingPermissionVerification = async (menuType?: RouterInfoType, push = true) => {
    let allRouterInfo = await getAllRouterInfo();
    // console.log('res:', res);
    let routerInfoData = allRouterInfo?.data as Array<API.RouterInfo>;
    let hasPath = false;
    // 验证是否包含路由
    routerInfoData.forEach((routerInfo) => {
      if (routerInfo.path === location.pathname) {
        hasPath = true;
      }
    });
    if (!hasPath) {
      // console.log('location.pathname', location.pathname);
      message.error('非法跳转');
      history.back();
    }
    hasPath = false;
    // 验证是否有路由权限
    let routerInfoArr = routerInfo;
    if (routerInfo.length === 0 && initialState?.currentUser?.roleInfo) {
      routerInfoArr = await getRoleInfoByUserRoleInfo(initialState?.currentUser?.roleInfo);
      routerInfoArr = (routerInfoArr?.data?.routerInfo as string).split(',');
      setRouterInfo(routerInfoArr);
    }
    routerInfoData.forEach((routerInfo) => {
      if (
        routerInfo.path === location.pathname &&
        routerInfoArr.indexOf(routerInfo.id?.toString()) !== -1
      ) {
        hasPath = true;
      }
    });
    if (!hasPath && initialState.currentUser) {
      message.error('请联系管理员分配权限');
      history.push('/welcome');
    }

    if (menuType && initialState.currentUser) {
      let menuItemsArr: Array<API.RouterInfo> = [];
      menuItemsArr = routerInfoData.reduce((prev, current) => {
        if (current.type === menuType && routerInfoArr.indexOf(current.id?.toString()) !== -1) {
          return prev.concat(current);
        } else {
          return prev;
        }
      }, []);
      if (menuItemsArr.length !== 0) {
        setMenuItems(menuItemsArr);
        setIsShowSide(true);
        // setMenuType(menuType);
        if (menuType) sessionStorage.setItem('menuType', menuType?.toString());
        if (push) {
          const defaultPath = menuItemsArr[0].path || '/welcome';
          history.push(defaultPath);
        }
      } else {
        message.error('请联系管理员分配权限');
      }
    }
  };

  const getRouterInfoByMenuType = (menuType?: RouterInfoType, push = true) => {
    routingPermissionVerification(menuType, push);
  };

  useEffect(() => {
    if (!initialState?.currentUser && location.pathname !== loginPath) {
      history.push(loginPath);
      return;
    }
    // console.log('history.location', history.location.pathname);
    if (initialState?.currentUser?.roleInfo) {
      getRoleInfoByUserRoleInfo(initialState?.currentUser?.roleInfo).then((res) => {
        let routerInfoArr = (res?.data?.routerInfo as string).split(',');
        // console.log('routerInfoArr', routerInfoArr);
        setRouterInfo(routerInfoArr);
      });
    }
    if (history.location.pathname === '/welcome') {
      getRouterInfoByMenuType(RouterInfoType.home);
    } else {
      let menuType = sessionStorage.getItem('menuType');
      getRouterInfoByMenuType(menuType as RouterInfoType, false);
    }
    // getAllProjectInfo().then((res) => {
    //   let data = res?.data;
    //   let ret: Array<projectRender> = [];
    //   if (data) {
    //     ret = data.reduce((prev, current) => {
    //       return prev.concat({
    //         value: current?.id,
    //         label: current?.name,
    //         disabled: current?.status === ProjectInfoStatus.关闭,
    //       } as projectRender);
    //     }, ret);
    //     setProjects(ret);
    //   }
    // });
  }, []);
  return {
    // menutype: menuType,
    actionsRender: () => [
      <TaskOptionsDropdown key="task" getRouterInfoByMenuType={getRouterInfoByMenuType} />,
      // <Question key="doc" />,
      // <SelectLang key="SelectLang" />
    ],
    avatarProps: {
      src: initialState?.currentUser?.avatar,
      title: <AvatarName />,
      render: (_, avatarChildren) => {
        const handleClick = () => {
          getRouterInfoByMenuType(RouterInfoType.user);
        };
        return (
          <span onClick={handleClick}>
            <AvatarDropdown>{avatarChildren}</AvatarDropdown>
          </span>
        );
      },
    },

    menuDataRender: (allMenuItem) => {
      let allMenuItemFilter = allMenuItem.filter((item) => {
        let hasPath = false;
        // console.log('routerInfo', routerInfo);
        for (let i = 0; i < menuItems.length; i++) {
          if (
            menuItems[i].path === item.path &&
            routerInfo.indexOf(menuItems[i].id.toString()) !== -1
          ) {
            hasPath = true;
            break;
          }
        }
        return hasPath;
      });
      // console.log(allMenuItemFilter);
      return allMenuItemFilter;
    },
    menuRender: (props, defaultDom) => {
      return isShowSide && defaultDom;
    },
    // waterMarkProps: {
    //   content: initialState?.currentUser?.name,
    // },
    // footerRender: () => <Footer />,
    onPageChange: async () => {
      const { location } = history;
      // 如果没有登录，重定向到 login
      if (!initialState?.currentUser && location.pathname !== loginPath) {
        history.push(loginPath);
        return;
      }
      await routingPermissionVerification();
    },
    links: isDev
      ? [
          <Link key="openapi" to="/umi/plugin/openapi" target="_blank">
            <LinkOutlined />
            <span>OpenAPI 文档</span>
          </Link>,
        ]
      : [],
    // 侧边栏菜单头部
    menuHeaderRender: undefined,
    // 顶部菜单栏中间内容
    // headerContentRender: (props) => {
    //   // console.log('headerContentRender:', props);
    //   return (
    //     <div style={{ display: 'flex', justifyContent: 'center' }}>
    //       <img src={props.logo?.toString()} alt="logo" width={25} />
    //       <span>{props.title}</span>
    //     </div>
    //   );
    // },
    // 顶部菜单栏左侧
    headerTitleRender(logo: any, title: any, props: any) {
      return (
        <>
          {/* {logo}
          {title?.props?.children} */}
          <span
            style={{ display: 'inline-flex', cursor: 'pointer' }}
            onClick={() => getRouterInfoByMenuType(RouterInfoType.home)}
          >
            {logo}
            {title}
          </span>
        </>
      );
    },
    // 顶部菜单栏左侧
    // headerTitleRender(logo, title, props) {
    //   const handleChange = (value: number | string) => {
    //     getRouterInfoByMenuType(RouterInfoType.project);
    //     console.log(value);
    //   };
    //   return (
    //     <>
    //       <Select
    //         defaultValue="请选择项目"
    //         bordered={false}
    //         showArrow={false}
    //         style={{ minWidth: 200 }}
    //         onChange={handleChange}
    //         options={
    //           projects
    //           // [
    //           // { value: 'disabled', label: 'Disabled', disabled: true },
    //           // ]
    //         }
    //       />
    //     </>
    //   );
    // },
    // 自定义 403 页面
    // unAccessible: <div>unAccessible</div>,
    // 增加一个 loading 的状态
    childrenRender: (children) => {
      if (initialState?.loading) return <PageLoading />;
      return (
        <>
          {children}
          {/* <SettingDrawer
            disableUrlParams
            enableDarkTheme
            settings={initialState?.settings}
            onSettingChange={(settings) => {
              setInitialState((preInitialState) => ({
                ...preInitialState,
                settings,
              }));
            }}
          /> */}
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
