/*global require*/
'use strict';

var glob            = require('glob');
var path            = require('path');

var gulp            = require('gulp');
var $               = require('gulp-load-plugins')();
var runSequence     = require('run-sequence');

var rimraf          = require('rimraf');
var browserSync     = require('browser-sync');
var reload          = browserSync.reload;
var stylishReporter = require('jshint-stylish');

var config = {
    'srcDir': 'src',
    'tmpDir': '.tmp',
    'distDir': 'dist'
};

gulp.task('haml', function () {
    return gulp.src(config.srcDir + '/**/*.haml')
        .pipe($.haml({
            ext: '.html'
        }))
        .pipe(gulp.dest(config.tmpDir));
});


gulp.task('coffee', function () {
    return gulp.src(config.srcDir + '/scripts/**/*.coffee')
        .pipe($.coffee({bare: true}))
        .pipe(gulp.dest(config.tmpDir + '/scripts/'));
});

gulp.task('sass', function () {
    return gulp.src(config.srcDir + '/styles/**/*.sass')
        .pipe($.rubySass())
        .pipe(gulp.dest(config.tmpDir + '/styles/'));
});

// Clean

gulp.task('clean:dist', function (cb) {
    return rimraf(config.distDir, cb);
});

gulp.task('clean:tmp', function (cb) {
    return rimraf(config.tmpDir, cb);
});

gulp.task('clean', ['clean:tmp', 'clean:dist']);


// default
gulp.task('precompile', ['haml', 'sass', 'coffee']);

gulp.task('build', function () {
    return gulp.src(config.tmpDir + '/*.html')
        .pipe($.smoosher())
        .pipe(gulp.dest(config.distDir + '/'));
});


gulp.task('default', ['clean'], function (cb) {
    runSequence(
        'precompile',
        ['build', 'dist'],
        cb
    );
});

gulp.task('dist:bower', function () {
    return gulp.src('bower.json')
        .pipe(gulp.dest(config.distDir + '/'));
});

gulp.task('dist:license', function () {
    return gulp.src('LICENSE')
        .pipe(gulp.dest(config.distDir + '/'));
});

gulp.task('dist:readme', function () {
    return gulp.src('README.md')
        .pipe(gulp.dest(config.distDir + '/'));
});

gulp.task('dist', ['dist:bower', 'dist:license', 'dist:readme']);