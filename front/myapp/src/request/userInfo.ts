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

/** 获取当前的用户 GET /api/currentUser */
export async function currentUser(options?: { [key: string]: any }) {
  return request<{
    data: API.CurrentUser;
  }>('/api/user/getCurrentUser', {
    method: 'GET',
    ...(options || {}),
  });
}

/** 退出登录接口 POST /api/login/outLogin */
export async function outLogin(options?: { [key: string]: any }) {
  return request<Record<string, any>>('/api/user/logout', {
    method: 'POST',
    ...(options || {}),
  });
}

/** 登录接口 POST /api/login/account */
export async function login(body: API.LoginParams, options?: { [key: string]: any }) {
  return request<API.LoginResult>('/api/user/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    data: body,
    ...(options || {}),
  });
}

/** 查找用户信息接口 POST /api/login/account */
export async function getUserInfoById(id: number, options?: { [key: string]: any }) {
  return request<{ data: API.CurrentUser }>(`/api/user/getUserInfoById?id=${id}`, {
    method: 'GET',
    // data: id,
    ...(options || {}),
  });
}

/** 查找用户信息接口 POST /api/login/account */
export async function checkAccount(account: string, options?: { [key: string]: any }) {
  return request<{ data: boolean }>(`/api/user/checkAccount?account=${account}`, {
    method: 'GET',
    // data: id,
    ...(options || {}),
  });
}



/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function updateUserInfoByID(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  // params: API.updateUserParams,
  body: any,
  options?: { [key: string]: any },
) {
  // console.log('body', body);
  // const { username: param0, ...queryParams } = params;
  // console.log('updateWikiInfoByID', body);
  return request<any>(`/api/user/updateUserInfoByID`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}

/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function addUserInfo(body: any, options?: { [key: string]: any }) {
  return request<any>(`/api/user/addUserInfo`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}



/** 查找用户信息接口 POST /api/login/account */
export async function getRoleInfoByUserRoleInfo(name: string, options?: { [key: string]: any }) {
  if (name !== undefined) {
    return request<API.RoleInfo>(`/api/user/getRoleInfoByUserRoleInfo?name=${name}`, {
      method: 'GET',
      // data: id,
      ...(options || {}),
    });
  }
}

/** Updated user This can only be done by the logged in user. PUT /user/${param0} */
export async function updateUserRoleAndJob(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  // params: API.updateUserParams,
  body: any,
  options?: { [key: string]: any },
) {
  // console.log('body', body);
  // const { username: param0, ...queryParams } = params;
  return request<any>(`/api/user/updateUserRoleAndJob`, {
    method: 'POST',
    // params: { ...queryParams },
    data: body,
    ...(options || {}),
  });
}

// export async function getUserInfoByProjectId(id: number, options?: { [key: string]: any }) {
//   return request<API.CurrentUser>(`/api/user/getUserInfoById?id=${id}`, {
//     method: 'GET',
//     // data: id,
//     ...(options || {}),
//   });
// }
