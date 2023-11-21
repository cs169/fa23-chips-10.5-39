# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      rep = Representative.find_or_initialize_by(ocdid: ocdid_temp)
      reps.push(update_rep_attributes(rep, official, title_temp))
    end
    reps
  end

  def self.get_addr(official)
    return {} if official.address&.first.nil?

    {
      address: official.address.first.line1,
      city:    official.address.first.city,
      state:   official.address.first.state,
      zip:     official.address.first.zip
    }
  end

  def self.update_rep_attributes(rep, official, title)
    address = get_addr(official)
    rep.update!(
      name:            official.name,
      title:           title,
      address:         address[:address],
      city:            address[:city],
      state:           address[:state],
      zip:             address[:zip],
      political_party: official.party,
      photo_url:       official.photo_url
    )
    rep
  end
end
