import { defineConfig } from '@umijs/max';
const { REACT_APP_ENV } = process.env;

export default defineConfig({
  define: {
    REACT_APP_ENV: REACT_APP_ENV || false,
    REACT_APP_BASEURL: 'http://localhost:9090',
  },
});
