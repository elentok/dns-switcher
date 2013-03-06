execSync = require 'execSync'
clc = require 'cli-color'

module.exports = class MacDnsSwitcher
  constructor: (options = {}) ->
    @options = options

  activate: (profile) ->
    @setDnsServers(profile.nameservers)
    @setSearchDomains(profile.search_domains)

  setDnsServers: (servers) ->
    servers = @_buildArgument(servers)
    @_run(
      "sudo networksetup -setdnsservers \"#{@options.network_service}\" #{servers}")

  setSearchDomains: (domains) ->
    domains = @_buildArgument(domains)
    @_run(
      "sudo networksetup -setsearchdomains \"#{@options.network_service}\" #{domains}")

  _run: (cmd) ->
    output = execSync.stdout(cmd)
    if output? and output.trim().length > 0
      console.log output
    output

  _buildArgument: (servers) ->
    if servers? and servers.length
      servers.join(' ')
    else
      'Empty'

  getDnsServers: ->
    execSync.stdout(
      "networksetup -getdnsservers \"#{@options.network_service}\"")

  getSearchDomains: ->
    execSync.stdout(
      "networksetup -getsearchdomains \"#{@options.network_service}\"")

