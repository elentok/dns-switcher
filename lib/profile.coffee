fs = require 'fs'
path = require 'path'
_ = require 'lodash'

module.exports =
  _configPath: path.join(process.env['HOME'], '.dns.coffee')

  getNames: ->
    _.keys(@_getAll())

  findByName: (name) ->
    @_getAll()[name]

  _getAll: ->
    if fs.existsSync(@_configPath)
      require @_configPath
    else
      console.log "WARNING: ~/.dns.coffee doesn't exist"
      {}
