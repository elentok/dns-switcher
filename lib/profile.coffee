fs = require 'fs'
path = require 'path'
_ = require 'lodash'

module.exports = class Profile
  constructor: (options = {}) ->
    @nameservers = options.nameservers or null
    @search_domains = options.search_domains or null

  activate: (switcher) ->
    switcher.setDnsServers(@nameservers)
    switcher.setSearchDomains(@search_domains)

Profile._configPath = path.join(process.env['HOME'], '.dns.coffee')

Profile.getNames = ->
  _.keys(@_all())

Profile.findByName = (name) ->
  attribs = @_all()[name]
  if attribs?
    new Profile(attribs)
  else
    null

Profile._all = ->
  if fs.existsSync(@_configPath)
    require @_configPath
  else
    console.log "WARNING: ~/.dns.coffee doesn't exist"
    {}
