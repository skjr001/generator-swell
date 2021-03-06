'use strict';

module.exports = {
    unitTestTimeout: 5000,
    unitTestReporter: 'mocha-multi',
    unitTestReporterOptions: {
        'xunit': {
            stdout: './testresults/unit-test-results.xml',
            options: {
                verbose: true,
            }
        },
        spec: {
            stdout: '-'
        }
    },
    unitTestMochaInterface: 'tdd'
};