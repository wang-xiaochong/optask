/* eslint-disable @typescript-eslint/no-unused-expressions */
/**
 * 向返回值为数组的函数中添加key
 * @param fn
 * @returns
 */
export const addKeyToFnDataArray = async (fn: () => any) => {
  const ret = await fn();
  let data = ret.data;
  for (let i = 0; i < data.length; i++) {
    data[i]['key'] = JSON.stringify(data);
  }
  return ret;
};

export const sleep = (wait: number) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve();
    }, wait);
  });
};

// export { addKeyToFnDataArray };
