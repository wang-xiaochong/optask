// @ts-ignore
/* eslint-disable */
import { request } from '@umijs/max';

/** 获取当前的用户 GET /api/currentUser */
export async function getAllRouterInfo(options?: { [key: string]: any }) {
  return request<{
    data: API.RouterInfo[];
  }>('/api/router/getAllRouterInfo', {
    method: 'GET',
    ...(options || {}),
  });
}

// /** 获取当前的用户 GET /api/currentUser */
// export async function getTaskInfoByID(id: number | string, options?: { [key: string]: any }) {
//   if (typeof id == 'number') {
//     id = id.toString();
//   }
//   return request<{
//     data: API.TaskInfo;
//   }>('/api/task/getTaskInfoByID', {
//     method: 'GET',
//     params: {
//       id: id,
//     },
//     ...(options || {}),
//   });
// }
