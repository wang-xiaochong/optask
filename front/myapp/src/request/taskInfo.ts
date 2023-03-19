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
  createdBy: number | string,
  options?: { [key: string]: any },
) {
  if (typeof createdBy == 'number') {
    createdBy = createdBy.toString();
  }
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
  appoint: number | string,
  options?: { [key: string]: any },
) {
  if (typeof appoint == 'number') {
    appoint = appoint.toString();
  }
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
  id: number | string,
  options?: { [key: string]: any },
) {
  if (typeof id == 'number') {
    id = id.toString();
  }
  return request<{
    data: API.TaskInfo[];
  }>('/api/task/getTaskInfoByProjectID', {
    method: 'GET',
    params: {
      id: id,
    },
    ...(options || {}),
  });
}
