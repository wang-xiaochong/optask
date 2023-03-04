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
