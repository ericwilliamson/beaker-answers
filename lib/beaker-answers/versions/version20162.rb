require 'beaker-answers/versions/version20161'

module BeakerAnswers
  # This class provides answer file information for PE version 2016.2
  #
  # @api private
  class Version20162 < Version20161
    # The version of PE that this set of answers is appropriate for
    def self.pe_version_matcher
      /\A2016\.2/
    end

    def generate_answers
      the_answers = super

      if @format == :bash
        return the_answers
      elsif @format == :hiera
        # The hiera answer file format will get all answers, regardless of role it is being installed on
        hiera_hash = {}
        hiera_hash["console_admin_password"] = the_answers[:q_puppet_enterpriseconsole_auth_password]
        hiera_hash["puppet_enterprise::certificate_authority_host"] = the_answers[:q_puppetmaster_certname]
        hiera_hash["puppet_enterprise::puppet_master_host"] = the_answers[:q_puppetmaster_certname]
        hiera_hash["puppet_enterprise::console_host"] = the_answers[:q_puppetmaster_enterpriseconsole_hostname]
        hiera_hash["puppet_enterprise::puppetdb_host"] = the_answers[:q_puppetdb_hostname]
        hiera_hash["puppet_enterprise::database_host"] = the_answers[:q_database_host]
        hiera_hash["puppet_enterprise::pcp_broker_host"] = the_answers[:q_puppetmaster_certname]
        hiera_hash["puppet_enterprise::mcollective_middleware_hosts"] = [the_answers[:q_puppetmaster_certname]]
        hiera_hash["puppet_enterprise::puppetdb_database_password"] = the_answers[:q_puppetdb_database_password]
        hiera_hash["puppet_enterprise::classifier_database_password"] = the_answers[:q_classifier_database_password]
        hiera_hash["puppet_enterprise::activity_database_password"] = the_answers[:q_activity_database_password]
        hiera_hash["puppet_enterprise::rbac_database_password"] = the_answers[:q_rbac_database_password]
        hiera_hash["puppet_enterprise::orchestrator_database_password"] = the_answers[:q_orchestrator_database_password]
      else
        raise "Don't know how to generate answers for format #{@format}"
      end
    end

  end
end
