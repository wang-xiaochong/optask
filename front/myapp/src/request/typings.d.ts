// @ts-ignore
/* eslint-disable */

enum type {
  会议 = '会议',
}
enum TaskInfoStatus {
  新建 = '新建',
}

enum ProjectInfoStatus {
  打开 = '打开',
  关闭 = '关闭',
  暂停中 = '暂停中',
}

declare namespace API {
  type TaskInfo = {
    id?: number;
    name?: string;
    type?: type;
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
  };

  // type CurrentUser = {
  //   name?: string;
  //   account?: string;
  //   avatar?: string;
  //   userid?: string;
  //   email?: string;
  //   signature?: string;
  //   title?: string;
  //   group?: string;
  //   tags?: { key?: string; label?: string }[];
  //   notifyCount?: number;
  //   unreadCount?: number;
  //   country?: string;
  //   access?: string;
  //   geographic?: {
  //     province?: { label?: string; key?: string };
  //     city?: { label?: string; key?: string };
  //   };
  //   address?: string;
  //   phone?: string;
  // };
}
