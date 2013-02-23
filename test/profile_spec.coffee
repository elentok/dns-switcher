require './spec_helper'
Profile = require '../lib/profile'

path = require 'path'

Profile._configPath = path.resolve('test/fixtures/dot-dns.coffee')

describe "Profile", ->
  describe ".getNames", ->
    it "loads the profiles names from the config files", ->
      names = Profile.getNames()
      expect(names).to.eql ['profile1', 'profile2']

  describe ".findByName", ->
    describe "#for profile1", ->
      it "returns the profile", ->
        profile = Profile.findByName('profile1')
        expect(profile).to.be.instanceof(Profile)
        expect(profile.search_domains).to.eql ['domain1', 'domain2']
        expect(profile.nameservers).to.eql ['4.3.2.1']

    describe "#for profile2", ->
      it "returns the profile", ->
        profile = Profile.findByName('profile2')
        expect(profile).to.be.instanceof(Profile)
        expect(profile.nameservers).to.eql ['1.2.3.4', '5.6.7.8']
        expect(profile.search_domains).to.be.null

  describe "#activate(switcher)", ->
    it "calls switcher.setDnsServers", ->
      profile = new Profile(nameservers: 'bla')
      switcher =
        setDnsServers: sinon.spy()
        setSearchDomains: ->
      profile.activate(switcher)
      expect(switcher.setDnsServers).to.have.been.calledWith 'bla'

    it "calls switcher.setSearchDomains", ->
      profile = new Profile(search_domains: 'bla')
      switcher =
        setDnsServers: ->
        setSearchDomains: sinon.spy()
      profile.activate(switcher)
      expect(switcher.setSearchDomains).to.have.been.calledWith 'bla'

