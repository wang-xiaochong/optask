// @ts-ignore
/* eslint-disable */

import { ProjectInfoStatus, RouterInfoType, TaskInfoStatus, TaskInfoType } from './enum';

declare namespace API {
  export type TaskInfo = {
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

  export type ProjectInfo = {
    id?: number;
    name?: string;
    parent?: number;
    status?: ProjectInfoStatus;
  };

  type RouterInfo = {
    id?: number;
    name?: string;
    component?: string;
    path?: string;
    type?: RouterInfoType;
    desc?: string;
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
