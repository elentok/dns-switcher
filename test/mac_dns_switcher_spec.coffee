require './spec_helper'


execSync_stdout = sinon.spy()
sandbox = require 'sandboxed-module'
MacDnsSwitcher = sandbox.require '../lib/mac_dns_switcher',
  requires:
    execSync:
      stdout: execSync_stdout


describe "MacDnsSwitcher", ->
  describe "#resetDnsServers", ->
    it "runs 'sudo networksetup -setdnsservers {network_service} Empty'", ->
      switcher = new MacDnsSwitcher(network_service: 'Wi-Fi')
      switcher.resetDnsServers()
      cmd = 'sudo networksetup -setdnsservers Wi-Fi Empty'
      expect(execSync_stdout).to.have.been.calledWith(cmd)

  describe "#resetSearchDomains", ->
    it "runs 'sudo networksetup -setsearchdomains {network_service} Empty'", ->
      switcher = new MacDnsSwitcher(network_service: 'Wi-Fi')
      switcher.resetSearchDomains()
      cmd = 'sudo networksetup -setsearchdomains Wi-Fi Empty'
      expect(execSync_stdout).to.have.been.calledWith(cmd)

  describe "#setDnsServers", ->
    it "runs 'sudo networksetup -setdnsservers {network_service} {servers}'", ->
      switcher = new MacDnsSwitcher(network_service: 'Wi-Fi')
      switcher.setDnsServers(['1.2.3.4', '5.6.7.8'])
      cmd = 'sudo networksetup -setdnsservers Wi-Fi 1.2.3.4 5.6.7.8'
      expect(execSync_stdout).to.have.been.calledWith(cmd)

  describe "#setSearchDomains", ->
    it "runs 'sudo networksetup -setsearchdomains {network_service} {searchdomains}'", ->
      switcher = new MacDnsSwitcher(network_service: 'Wi-Fi')
      switcher.setSearchDomains(['mydomain', 'myotherdomain'])
      cmd = 'sudo networksetup -setsearchdomains Wi-Fi mydomain myotherdomain'
      expect(execSync_stdout).to.have.been.calledWith(cmd)

  #describe "#activate(network_service)", ->
    #beforeEach ->
      #@Profile = sandbox.require '../lib/profile',
        #requires:
          #execSync:
            #stdout: @stdout

    #describe "when no dns servers are defined", ->
      #it "resets the dns servers", ->
        #profile = new @Profile()
        #profile.activate()


    #itRunsCmdsForProfile = (profile_attribs, cmds) ->
      #describe "when profile is #{JSON.stringify(profile_attribs)}", ->
        #it "runs '#{cmds.join(', ')}'", ->
          #profile = new @Profile(profile_attribs)
          #profile.activate('Wi-Fi')
          #expect(@stdout).to.have.been.calledWith(cmd)

    #itRunsCmdsForProfile {},
      #['sudo networksetup -setdnsservers Wi-Fi Empty']

    #itRunsCmdsForProfile { nameservers: [] },
      #['sudo networksetup -setdnsservers Wi-Fi Empty']

    #itRunsCmdsForProfile { nameservers: ['1.2.3.4'] },
      #['sudo networksetup -setdnsservers Wi-Fi 1.2.3.4']

