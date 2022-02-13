const gulp = require("gulp"),
  sass = require("gulp-sass")(require("sass")),
  sourceMaps = require("gulp-sourcemaps"),
  plumber = require("gulp-plumber"),
  // rename = require('gulp-rename'),
  csso = require("gulp-csso"),
  notify = require("gulp-notify"),
  del = require("del"),
  browserSync = require("browser-sync").create(),
  autoprefixer = require("gulp-autoprefixer"),
  // webpack = require("webpack"),
  webpackStream = require("webpack-stream");

const paths = {
  root: "../priv/static/assets/",
  styles: {
    src: "./css/**/*.scss",
    main: "./css/*.scss",
    dest: "../priv/static/assets/",
  },
  js: {
    src: "./js/**/*.js",
    scripts: {
      app: "./js/app.js",
    },
    dest: "../priv/static/assets/",
  },
};

const styles = () => {
  return (
    gulp
      .src(paths.styles.main)
      .pipe(sourceMaps.init())
      .pipe(plumber())
      .pipe(
        sass({
          includePaths: ["node_modules/"],
        })
      )
      .on(
        "error",
        notify.onError({
          title: "styles",
        })
      )
      .pipe(
        autoprefixer({
          borwsers: ["last 3 version"],
        })
      )
      .pipe(sourceMaps.write())
      // .pipe(rename('main.min.css'))
      .pipe(gulp.dest(paths.styles.dest))
      .pipe(browserSync.stream())
  );
};

const stylesProd = () => {
  return (
    gulp
      .src(paths.styles.main)
      .pipe(
        sass({
          includePaths: ["node_modules/"],
        })
      )
      .pipe(
        autoprefixer({
          borwsers: ["last 3 version"],
        })
      )
      .pipe(csso())
      // .pipe(rename('main.min.css'))
      .pipe(gulp.dest(paths.styles.dest))
  );
};

const js = () => {
  return gulp
    .src(paths.js.scripts.app)
    .pipe(
      webpackStream({
        mode: "none",
        entry: paths.js.scripts,
        output: {
          filename: "[name].js",
        },
        module: {
          rules: [
            {
              test: /\.(js)$/,
              exclude: "/(node_modules)/",
              loader: "babel-loader",
            },
          ],
        },
      })
    )
    .pipe(gulp.dest(paths.js.dest));
};

const clean = () => del(paths.root, { force: true });

const watch = () => {
  gulp.watch(paths.styles.src, styles);
  gulp.watch(paths.js.src, js);
};

exports.styles = styles;
exports.stylesProd = stylesProd;
exports.js = js;
exports.clean = clean;
exports.watch = watch;

gulp.task("default", gulp.series(clean, gulp.parallel(styles, js), watch));

gulp.task("build", gulp.series(clean, gulp.parallel(stylesProd, js)));
