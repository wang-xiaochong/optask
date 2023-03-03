const addKeyToFnDataArray = async (fn: () => any) => {
  const ret = await fn();
  let data = ret.data;
  for (let i = 0; i < data.length; i++) {
    data[i]['key'] = JSON.stringify(data);
  }
  return ret;
};

export { addKeyToFnDataArray };
