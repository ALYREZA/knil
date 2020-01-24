module.exports = {
  plugins: [
    require('postcss-import'), require('postcss-flexbugs-fixes'), require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
    require('tailwindcss')('./tailwind.config.js'),
    require('autoprefixer'),
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/views/layouts/main.html.erb', './app/views/main/*.erb'
      ],
      defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
    })
  ]
}
