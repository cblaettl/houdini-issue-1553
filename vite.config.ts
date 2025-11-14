import houdini from "houdini/vite";
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	resolve: {
		alias: {
			'near-api-js': 'near-api-js/dist/near-api-js.js'
		}
	},

	plugins: [
		houdini(),
		sveltekit(),
	],

	server: {
		proxy: {
			'/graphql': {
				target: 'http://localhost:8080',
				changeOrigin: true,
				secure: false,
			},
		}
	},
});
