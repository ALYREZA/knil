/* eslint no-console: 0 */
import App from '../app.svelte'

document.addEventListener('DOMContentLoaded', () => {
  const app = new App({
    target: document.body,
    props: {
      name: 'Svelte'
    }
  });

  window.app = app;
})
