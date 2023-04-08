﻿/**
 * @name umi 的路由配置
 * @description 只支持 path,component,routes,redirect,wrappers,name,icon 的配置
 * @param path  path 只支持两种占位符配置，第一种是动态参数 :id 的形式，第二种是 * 通配符，通配符只能出现路由字符串的最后。
 * @param component 配置 location 和 path 匹配后用于渲染的 React 组件路径。可以是绝对路径，也可以是相对路径，如果是相对路径，会从 src/pages 开始找起。
 * @param routes 配置子路由，通常在需要为多个路径增加 layout 组件时使用。
 * @param redirect 配置路由跳转
 * @param wrappers 配置路由组件的包装组件，通过包装组件可以为当前的路由组件组合进更多的功能。 比如，可以用于路由级别的权限校验
 * @param name 配置路由的标题，默认读取国际化文件 menu.ts 中 menu.xxxx 的值，如配置 name 为 login，则读取 menu.ts 中 menu.login 的取值作为标题
 * @param icon 配置路由的图标，取值参考 https://ant.design/components/icon-cn， 注意去除风格后缀和大小写，如想要配置图标为 <StepBackwardOutlined /> 则取值应为 stepBackward 或 StepBackward，如想要配置图标为 <UserOutlined /> 则取值应为 user 或者 User
 * @doc https://umijs.org/docs/guides/routes
 */
export default [
  {
    path: '/user',
    layout: false,
    routes: [
      {
        name: 'login',
        path: '/user/login',
        component: './User/Login',
      },
    ],
  },
  {
    path: '/welcome',
    // name: 'welcome',
    name: '欢迎',
    icon: 'smile',
    component: './Welcome',
  },
  {
    path: '/admin',
    name: 'admin',
    icon: 'crown',
    // access: 'canAdmin',
    routes: [
      {
        path: '/admin',
        redirect: '/admin/sub-page',
      },
      {
        path: '/admin/sub-page',
        name: 'sub-page',
        component: './Admin',
      },
      {
        path: '/admin/sub-page',
        name: 'sub-page',
        component: './Admin',
      },
    ],
  },
  {
    // name: 'wiki.wiki-list',
    name: 'wiki',
    icon: 'table',
    path: '/wiki/list',
    component: './Wiki',
    // hideInMenu: true,
    // hideChildrenInMenu: true,
    // layout: false,
  },
  {
    name: 'wikiDetail',
    icon: 'table',
    path: '/wiki/list/:id',
    component: './Wiki/components/WikiDetail.tsx',
    hideInMenu: true,
  },
  // {
  //   name: 'list.table-list',
  //   icon: 'table',
  //   path: '/list',
  //   component: './TableList',
  // },
  {
    // name: 'project.project-list',
    name: '项目列表',
    icon: 'table',
    path: '/project/list',
    component: './Project',
    // routes: [
    //   {
    //     icon: 'table',
    //     path: '/project/list/:id',
    //     component: './Project/components/ProjectDetail.tsx',
    //     hideInMenu: true,
    //   },
    // ],
    // layout: false,
  },
  {
    // name: 'task.task-list',
    icon: 'table',
    path: '/project/list/:id',
    component: './Project/components/ProjectDetail.tsx',
    hideInMenu: true,
    // layout: false,
  },

  {
    // name: 'task.task-list',
    name: '分配给我',
    icon: 'table',
    path: '/task/appointme',
    component: './Task/components/AppointMe.tsx',
    // layout: false,
  },
  {
    path: '/task/appointme/:id',
    component: './Task/components/TaskDetail.tsx',
    hideInMenu: true,
  },
  {
    // name: 'task.task-list',
    name: '由我创建',
    icon: 'table',
    path: '/task/createdbyme',
    component: './Task/components/CreatedByMe.tsx',
    // layout: false,
  },
  {
    path: '/task/createdbyme/:id',
    component: './Task/components/TaskDetail.tsx',
    hideInMenu: true,
  },
  {
    // name: 'task.task-list',
    name: '任务列表',
    icon: 'table',
    path: '/task/list',
    component: './Task',
    // layout: false,
  },
  {
    // name: 'task.task-list',
    icon: 'table',
    path: '/task/list/:id',
    component: './Task/components/TaskDetail.tsx',
    hideInMenu: true,
    // layout: false,
  },
  {
    // name: 'task.task-list',
    icon: 'table',
    name: '用户管理',
    path: '/userManagement/list',
    component: './User/Manager',
    // hideInMenu: true,
    // layout: false,
  },
  {
    // name: 'task.task-list',
    icon: 'table',
    name: '个人中心',
    path: '/personal',
    component: './User/Personal',
    // hideInMenu: true,
    // layout: false,
  },

  {
    path: '/',
    redirect: '/welcome',
  },
  {
    path: '*',
    layout: false,
    component: './404',
  },
];
