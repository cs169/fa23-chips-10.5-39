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
      rep.update!(
	      name: official.name, 
	      title: title_temp,
	      address: official.address&.first&.line1,
	      city: official.address&.first&.city,
	      state: official.address&.first&.state,
	      zip: official.address&.first&.zip,
	      political_party: official.party,
	      photo_url: official.photo_url
		 )
      reps.push(rep)
    end

    reps
  end
end
