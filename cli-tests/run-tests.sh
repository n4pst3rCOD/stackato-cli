#!/bin/sh

start=`date`

stem=X
#stem=Z

# Override the variables below to avoid conflicts with other
# testsuites and instances of this running at the same time.

# These variables must contain information created before testing,
# i.e. target, and target setup. See script "setup.sh" for code
# setting up a configuration.

# ATTENTION: The configuration used here must match configuration
# created by "setup.sh".

#export STACKATO_CLI_TEST_TARGET   =api.stackato-nightly.activestate.com
#export STACKATO_CLI_TEST_ADMIN    =cli-test-admin@test
#export STACKATO_CLI_TEST_APASS    =cli-test-admin-pass
#export STACKATO_CLI_TEST_ORG      =cli-test-org
#export STACKATO_CLI_TEST_SPACE    =cli-test-space
#export STACKATO_CLI_TEST_DRAIN	   =tcp://flux.activestate.com:11100
#export STACKATO_CLI_TEST_SBROKER_L=http://kvmbuild.activestate.com:5000
#export STACKATO_CLI_TEST_SBROKER_U=foo
#export STACKATO_CLI_TEST_SBROKER_P=bar

#The values of these variables are used to create a non-admin user during the tests.
#
#export STACKATO_CLI_TEST_USER	 =cli-tester@test
#export STACKATO_CLI_TEST_GROUP	 =cli-test-group

rm -f ${stem}.* tests/*.out tests/*.err && \
clear     && \
echo      && \
echo Arguments "$@" && \
time ./build.tcl test --log ${stem} "$@"

echo Started__ $start
echo Completed `date`

# Requirements: Tcl, Kettle package and app.
exit
