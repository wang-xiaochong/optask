// @ts-ignore
/* eslint-disable */
import { request } from '@umijs/max';

/** 获取当前的用户 GET /api/currentUser */
export async function getAllWikiInfo(options?: { [key: string]: any }) {
  return request<{
    data: API.WikiInfo[];
  }>('/api/wiki/getAllWikiInfo', {
    method: 'GET',
    ...(options || {}),
  });
}

/** 获取当前的用户 GET /api/currentUser */
export async function getWikiInfoByProjectID(
  id: number | string,
  options?: { [key: string]: any },
) {
  if (typeof id == 'number') {
    id = id.toString();
  }
  return request<{
    data: API.WikiInfo[];
  }>('/api/wiki/getWikiInfoByProjectID', {
    method: 'GET',
    params: {
      id: id,
    },
    ...(options || {}),
  });
}
