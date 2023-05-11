// @ts-ignore
/* eslint-disable */
import { request } from '@umijs/max';

/** 获取当前的用户 GET /api/currentUser */
export async function getAllProjectInfo(options?: { [key: string]: any }) {
  return request<{
    data: API.ProjectInfo[];
  }>('/api/project/getAllProjectInfo', {
    method: 'GET',
    ...(options || {}),
  });
}

/** 获取当前的用户 GET /api/currentUser */
export async function getProjectInfoByID(name: string, options?: { [key: string]: any }) {
  return request<{
    data: API.ProjectInfo;
  }>('/api/project/getProjectInfoByID', {
    method: 'GET',
    params: {
      name: name,
    },
    ...(options || {}),
  });
}

/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function addProjectInfo(body: any, options?: { [key: string]: any }) {
  return request<any>(`/api/project/addProjectInfo`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}
