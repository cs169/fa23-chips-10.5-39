# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.each_with_index.map do |official, index|
      office_data = find_office_data(rep_info.offices, index)
      update_or_create_representative(official, office_data)
    end
  end

  def self.find_office_data(offices, index)
    offices.find { |office| office.official_indices.include? index }
  end

  def self.update_or_create_representative(official, office_data)
    rep = find_or_initialize_by(ocdid: office_data.division_id)
    update_representative_attributes(rep, official, office_data)
    rep
  end

  def self.update_representative_attributes(rep, official, office_data)
    rep.name            = official.name
    rep.title           = office_data.name
    update_address(rep, official)
    rep.political_party = official.party
    rep.photo_url       = official.photo_url
    rep.save!
  end

  def self.update_address(rep, official)
    address = official.address&.first
    rep.address = address&.line1
    rep.city    = address&.city
    rep.state   = address&.state
    rep.zip     = address&.zip
  end
end
