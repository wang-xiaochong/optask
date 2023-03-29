// @ts-ignore
/* eslint-disable */

declare namespace API {
  type CurrentUser = {
    name?: string;
    account?: string;
    avatar?: string;
    userid?: string;
    email?: string;
    signature?: string;
    title?: string;
    group?: string;
    tags?: { key?: string; label?: string }[];
    notifyCount?: number;
    unreadCount?: number;
    country?: string;
    access?: string;
    geographic?: {
      province?: { label?: string; key?: string };
      city?: { label?: string; key?: string };
    };
    address?: string;
    phone?: string;
  };

  type TaskInfo = {
    id?: number;
    name?: string;
    type?: TaskInfoType;
    status?: TaskInfoStatus;
    leval?: string;
    createdBy?: string;
    createdTime?: Date;
    appoint?: string;
    project?: string;
    taskUpdateInfo?: number;
    updateTime?: Date;
    estimatedTime?: Date;
    consumeTime?: Date;
    leftTime?: Date;
    detail?: string;
    date?: Date;
    parent?: number;
  };

  type ProjectInfo = {
    id?: number;
    name?: string;
    parent?: number;
    status?: ProjectInfoStatus;
    userInfo?: { id: string; name: string; avatar: string }[];
    desc?: string;
  };

  type RouterInfo = {
    id?: number;
    name?: string;
    component?: string;
    path?: string;
    type?: RouterInfoType;
    desc?: string;
  };

  type WikiInfo = {
    id?: number;
    title?: string;
    content?: string;
    project?: number;
    createdBy?: number;
    createdTime?: string;
    updateInfo?: number;
    updateTime?: string;
    parent?: number;
  };

  type LoginResult = {
    // status?: string;
    // type?: string;
    // currentAuthority?: string;
    data: numner;
    msg: string;
    success: boolean;
  };

  type PageParams = {
    current?: number;
    pageSize?: number;
  };

  type RuleListItem = {
    key?: number;
    disabled?: boolean;
    href?: string;
    avatar?: string;
    name?: string;
    owner?: string;
    desc?: string;
    callNo?: number;
    status?: number;
    updatedAt?: string;
    createdAt?: string;
    progress?: number;
  };

  type RuleList = {
    data?: RuleListItem[];
    /** 列表的内容总数 */
    total?: number;
    success?: boolean;
  };

  type FakeCaptcha = {
    code?: number;
    status?: string;
  };

  type LoginParams = {
    username?: string;
    password?: string;
    autoLogin?: boolean;
    type?: string;
  };

  type ErrorResponse = {
    /** 业务约定的错误码 */
    errorCode: string;
    /** 业务上的错误信息 */
    errorMessage?: string;
    /** 业务上的请求是否成功 */
    success?: boolean;
  };

  type NoticeIconList = {
    data?: NoticeIconItem[];
    /** 列表的内容总数 */
    total?: number;
    success?: boolean;
  };

  type NoticeIconItemType = 'notification' | 'message' | 'event';

  type NoticeIconItem = {
    id?: string;
    extra?: string;
    key?: string;
    read?: boolean;
    avatar?: string;
    title?: string;
    status?: string;
    datetime?: string;
    description?: string;
    type?: NoticeIconItemType;
  };
}
