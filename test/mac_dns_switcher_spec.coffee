require './spec_helper'


execSync_stdout = sinon.spy()
sandbox = require 'sandboxed-module'
MacDnsSwitcher = sandbox.require '../lib/mac_dns_switcher',
  requires:
    execSync:
      stdout: execSync_stdout


describe "MacDnsSwitcher", ->
  beforeEach ->
    @switcher = new MacDnsSwitcher(network_service: 'Wi-Fi')

  describe "#setDnsServers", ->
    describe "for null", ->
      it "runs 'sudo networksetup -setdnsservers {network_service} Empty'", ->
        @switcher.setDnsServers(null)
        cmd = 'sudo networksetup -setdnsservers Wi-Fi Empty'
        expect(execSync_stdout).to.have.been.calledWith(cmd)

    describe "for []", ->
      it "runs 'sudo networksetup -setdnsservers {network_service} Empty'", ->
        @switcher.setDnsServers([])
        cmd = 'sudo networksetup -setdnsservers Wi-Fi Empty'
        expect(execSync_stdout).to.have.been.calledWith(cmd)

    describe "for ['1.2.3.4', '5.6.7.8']", ->
      it "runs 'sudo networksetup -setdnsservers {network_service} {servers}'", ->
        @switcher.setDnsServers(['1.2.3.4', '5.6.7.8'])
        cmd = 'sudo networksetup -setdnsservers Wi-Fi 1.2.3.4 5.6.7.8'
        expect(execSync_stdout).to.have.been.calledWith(cmd)

  describe "#setSearchDomains", ->
    describe "for null", ->
      it "runs 'sudo networksetup -setsearchdomains {network_service} Empty'", ->
        @switcher.setSearchDomains(null)
        cmd = 'sudo networksetup -setsearchdomains Wi-Fi Empty'
        expect(execSync_stdout).to.have.been.calledWith(cmd)

    describe "for []", ->
      it "runs 'sudo networksetup -setsearchdomains {network_service} Empty'", ->
        @switcher.setSearchDomains([])
        cmd = 'sudo networksetup -setsearchdomains Wi-Fi Empty'
        expect(execSync_stdout).to.have.been.calledWith(cmd)

    describe "for ['domain1', 'domain2']", ->
      it "runs 'sudo networksetup -setsearchdomains {network_service} {searchdomains}'", ->
        @switcher.setSearchDomains(['domain1', 'domain2'])
        cmd = 'sudo networksetup -setsearchdomains Wi-Fi domain1 domain2'
        expect(execSync_stdout).to.have.been.calledWith(cmd)
