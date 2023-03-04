// @ts-ignore
/* eslint-disable */

declare namespace API {
  type TaskInfo = {
    id?: number;
    name?: string;
    type?: string;
    status?: string;
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
