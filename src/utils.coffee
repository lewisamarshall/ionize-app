exporter = this

execSync = require('child_process').execSync

exporter.db = JSON.parse(execSync('ionize database'))
