require './spec_helper'

execSync =
  stdout: sinon.stub()

sandbox = require 'sandboxed-module'
MacDnsSwitcher = sandbox.require '../lib/mac_dns_switcher',
  requires:
    execSync: execSync


describe "MacDnsSwitcher", ->
  beforeEach ->
    @switcher = new MacDnsSwitcher(network_service: 'iPhone USB')

  describe "#setDnsServers", ->
    describe "for null", ->
      it "runs 'sudo networksetup -setdnsservers {network_service} Empty'", ->
        @switcher.setDnsServers(null)
        cmd = 'sudo networksetup -setdnsservers "iPhone USB" Empty'
        expect(execSync.stdout).to.have.been.calledWith(cmd)

    describe "for []", ->
      it "runs 'sudo networksetup -setdnsservers {network_service} Empty'", ->
        @switcher.setDnsServers([])
        cmd = 'sudo networksetup -setdnsservers "iPhone USB" Empty'
        expect(execSync.stdout).to.have.been.calledWith(cmd)

    describe "for ['1.2.3.4', '5.6.7.8']", ->
      it "runs 'sudo networksetup -setdnsservers {network_service} {servers}'", ->
        @switcher.setDnsServers(['1.2.3.4', '5.6.7.8'])
        cmd = 'sudo networksetup -setdnsservers "iPhone USB" 1.2.3.4 5.6.7.8'
        expect(execSync.stdout).to.have.been.calledWith(cmd)

  describe "#setSearchDomains", ->
    describe "for null", ->
      it "runs 'sudo networksetup -setsearchdomains {network_service} Empty'", ->
        @switcher.setSearchDomains(null)
        cmd = 'sudo networksetup -setsearchdomains "iPhone USB" Empty'
        expect(execSync.stdout).to.have.been.calledWith(cmd)

    describe "for []", ->
      it "runs 'sudo networksetup -setsearchdomains {network_service} Empty'", ->
        @switcher.setSearchDomains([])
        cmd = 'sudo networksetup -setsearchdomains "iPhone USB" Empty'
        expect(execSync.stdout).to.have.been.calledWith(cmd)

    describe "for ['domain1', 'domain2']", ->
      it "runs 'sudo networksetup -setsearchdomains {network_service} {searchdomains}'", ->
        @switcher.setSearchDomains(['domain1', 'domain2'])
        cmd = 'sudo networksetup -setsearchdomains "iPhone USB" domain1 domain2'
        expect(execSync.stdout).to.have.been.calledWith(cmd)

  describe "#getDnsServers", ->
    it "runs 'networksetup -getdnsservers {network_service}'", ->
      @switcher.getDnsServers()
      cmd = 'networksetup -getdnsservers "iPhone USB"'
      expect(execSync.stdout).to.have.been.calledWith(cmd)

  describe "#getSearchDomains", ->
    it "runs 'networksetup -getsearchdomains {network_service}'", ->
      @switcher.getSearchDomains()
      cmd = 'networksetup -getsearchdomains "iPhone USB"'
      expect(execSync.stdout).to.have.been.calledWith(cmd)

  describe "#activate(profile)", ->
    beforeEach ->
      @switcher = new MacDnsSwitcher()

    it "calls setDnsServers", ->
      profile =
        nameservers: ['1.2.3.4']

      sinon.spy(@switcher, 'setDnsServers')
      @switcher.activate(profile)
      expect(@switcher.setDnsServers).to.have.been.calledWith(['1.2.3.4'])

    it "calls setSearchDomains", ->
      profile =
        search_domains: ['domain1']

      sinon.spy(@switcher, 'setSearchDomains')
      @switcher.activate(profile)
      expect(@switcher.setSearchDomains).to.have.been.calledWith(['domain1'])

