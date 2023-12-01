# frozen_string_literal: true

require 'net/http'
require 'json'

class CampaignFinance
  API_BASE_URI = 'https://api.propublica.org/campaign-finance/v1'
  API_KEY = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'

  def self.search_candidates(cycle, query)
    uri = URI("#{API_BASE_URI}/#{cycle}/candidates/search.json?query=#{query}")
    fetch_data(uri)
  end

  def self.get_candidate(cycle, fec_id)
    uri = URI("#{API_BASE_URI}/#{cycle}/candidates/#{fec_id}.json")
    fetch_data(uri)
  end

  def self.get_top_candidates(cycle, category)
    uri = URI("#{API_BASE_URI}/#{cycle}/candidates/leaders/#{category}.json")
    fetch_data(uri)
  end

  def self.fetch_data(uri)
    request = Net::HTTP::Get.new(uri)
    request['X-API-Key'] = API_KEY

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    Rails.logger.error "Failed to fetch data from ProPublica API: #{e.message}"
    nil
  end
end
