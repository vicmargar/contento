exports.config = {
  files: {
    javascripts: {
      joinTo: 'js/contento.js'
    },
    stylesheets: {
      joinTo: 'css/contento.css'
    },
    templates: {
      joinTo: 'js/contento.js'
    }
  },
  conventions: {
    assets: /^(static)/
  },
  paths: {
    watched: ['static', 'css', 'js', 'vendor'],
    public: '../priv/static'
  },
  plugins: {
    babel: {
      presets: ['es2015', 'stage-2'],
      plugins: [
        'transform-runtime'
      ],
      ignore: [/vendor/]
    },
    copycat: {
      'fonts': [
        'node_modules/font-awesome/fonts'
      ]
    },
    sass: {
      mode: 'native',
      options: {
        includePaths: ['node_modules']
      }
    }
  },
  modules: {
    autoRequire: {
      'js/contento.js': ['js/contento']
    }
  },
  npm: {
    enabled: true,
    globals: {
      $: 'jquery',
      jQuery: 'jquery',
      Popper: 'popper.js',
      bootstrap: 'bootstrap',
      marked: 'marked'
    }
  }
}
