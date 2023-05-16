import { request } from "@umijs/max";

/** 获取当前的用户 GET /api/currentUser */
export async function getAllRoleInfo(options?: { [key: string]: any }) {
  return request<{
    data: API.CurrentUser[];
  }>('/api/role/getAllRoleInfo', {
    method: 'GET',
    ...(options || {}),
  });
}