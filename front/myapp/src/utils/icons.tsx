export enum allIcons {
  TaskOptions = 'TaskOptions',
}

export const getIcons = (icon: allIcons) => {
  switch (icon) {
    case allIcons.TaskOptions:
      return (
        <svg
          viewBox="0 0 1024 1024"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
          p-id="2760"
          width="32"
          height="32"
        >
          <path
            d="M213.333333 554.666667h298.666667v298.666666H213.333333v-298.666666z m42.666667 42.666666v213.333334h213.333333v-213.333334H256zM213.333333 213.333333h298.666667v298.666667H213.333333V213.333333z m42.666667 42.666667v213.333333h213.333333V256H256z m298.666667-42.666667h298.666666v298.666667h-298.666666V213.333333z m42.666666 42.666667v213.333333h213.333334V256h-213.333334z m-42.666666 298.666667h298.666666v298.666666h-298.666666v-298.666666z m42.666666 42.666666v213.333334h213.333334v-213.333334h-213.333334z"
            fill="#2c2c2c"
            p-id="2761"
          ></path>
        </svg>
      );

    default:
      return (
        <svg
          viewBox="0 0 1024 1024"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
          p-id="2760"
          width="32"
          height="32"
        >
          <path
            d="M213.333333 554.666667h298.666667v298.666666H213.333333v-298.666666z m42.666667 42.666666v213.333334h213.333333v-213.333334H256zM213.333333 213.333333h298.666667v298.666667H213.333333V213.333333z m42.666667 42.666667v213.333333h213.333333V256H256z m298.666667-42.666667h298.666666v298.666667h-298.666666V213.333333z m42.666666 42.666667v213.333333h213.333334V256h-213.333334z m-42.666666 298.666667h298.666666v298.666666h-298.666666v-298.666666z m42.666666 42.666666v213.333334h213.333334v-213.333334h-213.333334z"
            fill="#2c2c2c"
            p-id="2761"
          ></path>
        </svg>
      );
  }
};