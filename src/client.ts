import { HoudiniClient } from '$houdini';

export default new HoudiniClient({
  url: '/graphql',
  fetchParams() {
    return {
      credentials: 'include'
    }
  },
  plugins: []
});
