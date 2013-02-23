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
    console.log execSync.stdout(
      "sudo networksetup -setdnsservers #{@options.network_service} #{servers}")

  setSearchDomains: (domains) ->
    domains = @_buildArgument(domains)
    console.log execSync.stdout(
      "sudo networksetup -setsearchdomains #{@options.network_service} #{domains}")

  _buildArgument: (servers) ->
    if servers? and servers.length
      servers.join(' ')
    else
      'Empty'

  showStatus: ->
    console.log clc.blue('DNS Servers:')
    @showDnsServers()
    console.log clc.blue('Search Domains:')
    @showSearchDomains()

  showDnsServers: ->
    console.log execSync.stdout(
      "networksetup -getdnsservers #{@options.network_service}")

  showSearchDomains: ->
    console.log execSync.stdout(
      "networksetup -getsearchdomains #{@options.network_service}")

