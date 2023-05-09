// @ts-ignore
/* eslint-disable */
import { request } from '@umijs/max';

/** 获取当前的用户 GET /api/currentUser */
export async function getAllTaskInfo(options?: { [key: string]: any }) {
  return request<{
    data: API.TaskInfo[];
  }>('/api/task/getAllTaskInfo', {
    method: 'GET',
    ...(options || {}),
  });
}

/** 获取当前的用户 GET /api/currentUser */
export async function getTaskInfoByCreatedBy(
  createdBy: string,
  options?: { [key: string]: any },
) {
  return request<{
    data: API.TaskInfo[];
  }>('/api/task/getTasksByCreatedBy', {
    method: 'GET',
    params: {
      createdBy: createdBy,
    },
    ...(options || {}),
  });
}

/** 获取当前的用户 GET /api/currentUser */
export async function getTaskInfoByAppoint(
  appoint: string,
  options?: { [key: string]: any },
) {
  return request<{
    data: API.TaskInfo[];
  }>('/api/task/getTasksByAppoint', {
    method: 'GET',
    params: {
      appoint: appoint,
    },
    ...(options || {}),
  });
}

/** 获取当前的用户 GET /api/currentUser */
export async function getTaskInfoByID(id: number | string, options?: { [key: string]: any }) {
  if (typeof id == 'number') {
    id = id.toString();
  }
  return request<{
    data: API.TaskInfo;
  }>('/api/task/getTaskInfoByID', {
    method: 'GET',
    params: {
      id: id,
    },
    ...(options || {}),
  });
}

/** 获取当前的用户 GET /api/currentUser */
export async function getTaskInfoByProjectID(
  name: string,
  options?: { [key: string]: any },
) {
  return request<{
    data: API.TaskInfo[];
  }>('/api/task/getTaskInfoByProjectID', {
    method: 'GET',
    params: {
      name: name,
    },
    ...(options || {}),
  });
}

/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function updateTaskContent(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  // params: API.updateUserParams,
  body: any,
  options?: { [key: string]: any },
) {
  // console.log('body', body);
  // const { username: param0, ...queryParams } = params;
  return request<any>(`/api/task/update`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}
