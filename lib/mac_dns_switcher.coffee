execSync = require 'execSync'

module.exports = class MacDnsSwitcher
  constructor: (options = {}) ->
    @options = options

  resetDnsServers: ->
    @setDnsServers()

  resetSearchDomains: ->
    @setSearchDomains()

  setDnsServers: (servers) ->
    servers = @_buildArgument(servers)
    execSync.stdout(
      "sudo networksetup -setdnsservers #{@options.network_service} #{servers}")

  setSearchDomains: (domains) ->
    domains = @_buildArgument(domains)
    execSync.stdout(
      "sudo networksetup -setsearchdomains #{@options.network_service} #{domains}")

  _buildArgument: (servers) ->
    if servers? and servers.length
      servers.join(' ')
    else
      'Empty'
