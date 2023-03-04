// @ts-ignore
/* eslint-disable */
import { request } from '@umijs/max';

/** 获取当前的用户 GET /api/currentUser */
export async function getAllUserInfo(options?: { [key: string]: any }) {
  return request<{
    data: API.CurrentUser[];
  }>('/api/user/getAllUserInfo', {
    method: 'GET',
    ...(options || {}),
  });
}
