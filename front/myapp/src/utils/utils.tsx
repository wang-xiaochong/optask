/* eslint-disable no-param-reassign */
/* eslint-disable @typescript-eslint/no-unused-expressions */
/**
 * 向返回值为数组的函数中添加key
 * @param fn
 * @returns
 */
export const addKeyToFnDataArray = async (fn: any) => {
  // if (typeof fn === 'function') {
  const ret = await fn();
  let data = ret?.data;
  for (let i = 0; i < data.length; i++) {
    data[i]['key'] = JSON.stringify(data);
  }
  return ret;
  // } else {
  //   let data = fn?.data;
  //   for (let i = 0; i < data.length; i++) {
  //     data[i]['key'] = JSON.stringify(data);
  //   }
  //   return fn;
  // }
};
export const waitTime = (time: number = 100) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(true);
    }, time);
  });
};
// export const sleep = (wait: number) => {
//   return new Promise((resolve, reject) => {
//     setTimeout(() => {
//       resolve();
//     }, wait);
//   });
// };

// export { addKeyToFnDataArray };

//js获取当前时间 格式“yyyy-MM-dd HH:MM:SS”

export function getNowFormatDate() {
  let date = new Date(); //获取当前时间
  let month: any = date.getMonth() + 1; //月份处理
  let day: any = date.getDate();
  month = month < 10 ? '0' + month : month; //月份为1-9月,在其前面加0
  day = day < 10 ? '0' + day : day; //日期为1-9号,在其前面加了0
  let s1 = '-'; //定义年月日分隔符-
  let s2 = ':'; //定义时分秒分隔符:
  //拼接年月日,时分秒
  let currDate =
    date.getFullYear() +
    s1 +
    month +
    s1 +
    day +
    ' ' +
    date.getHours() +
    s2 +
    date.getMinutes() +
    s2 +
    date.getSeconds();
  return currDate;
}
