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
export async function getWikiInfoByID(id: number | string, options?: { [key: string]: any }) {
  if (typeof id == 'number') {
    id = id.toString();
  }
  return request<{
    data: API.WikiInfo;
  }>('/api/wiki/getWikiInfoByID', {
    method: 'GET',
    params: {
      id: id,
    },
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

/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function updateWikiContent(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  // params: API.updateUserParams,
  body: any,
  options?: { [key: string]: any },
) {
  // console.log('body', body);
  // const { username: param0, ...queryParams } = params;
  return request<any>(`/api/wiki/update`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}

/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function updateWikiInfoByID(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  // params: API.updateUserParams,
  body: any,
  options?: { [key: string]: any },
) {
  // console.log('body', body);
  // const { username: param0, ...queryParams } = params;
  // console.log('updateWikiInfoByID', body);
  return request<any>(`/api/wiki/updateWikiInfoByID`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}


/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function addWikiInfo(body: any, options?: { [key: string]: any }) {
  return request<any>(`/api/wiki/addWikiInfo`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}
