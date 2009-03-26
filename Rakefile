#!/usr/bin/env ruby

require 'rake'
require '../../common'
require 'objective-j'
require 'objective-j/bundletask'


$PRODUCT = :ojtest
$BUILD_PATH = File.join($BUILD_DIR, $CONFIGURATION, 'ojtest')
$ENVIRONMENT_BIN_PRODUCT = File.join($ENVIRONMENT_BIN_DIR, 'ojtest')
$ENVIRONMENT_LIB_PRODUCT = File.join($ENVIRONMENT_LIB_DIR, 'ojtest')

ObjectiveJ::BundleTask.new(:ojtest) do |t|
    t.name          = 'ojtest'
    t.identifier    = 'com.280n.ojtest'
    t.version       = '0.6.5'
    t.author        = '280 North, Inc.'
    t.email         = 'feedback @nospam@ 280north.com'
    t.summary       = 'Run ojunit tests'
    t.sources       = FileList['*.j']
    t.license       = ObjectiveJ::License::LGPL_v2_1
    t.build_path    = $BUILD_PATH
    t.flag          = 'DEBUG' if $CONFIGURATION == 'Debug'
end

#executable in environment directory
file_d $ENVIRONMENT_BIN_PRODUCT do
    make_objj_executable($ENVIRONMENT_BIN_PRODUCT)
end

file_d $ENVIRONMENT_LIB_PRODUCT => [:ojtest] do
    cp_r(File.join($BUILD_PATH, '.'), $ENVIRONMENT_LIB_PRODUCT)
end

task :build => [:ojtest, $ENVIRONMENT_BIN_PRODUCT, $ENVIRONMENT_LIB_PRODUCT]

CLOBBER.include($ENVIRONMENT_BIN_PRODUCT, $ENVIRONMENT_LIB_PRODUCT)
