# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :destroy

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      rep_attributes = extract_representative_info(official, rep_info.offices, index)
      rep = Representative.find_or_create_by(rep_attributes.slice(:name, :ocdid))
      rep.update!(rep_attributes)
      reps << rep
    end

    reps
  end

  def self.extract_representative_info(official, offices, index)
    related_office = offices.find { |office| office.official_indices.include?(index) }
    division_id = related_office&.division_id || ''
    office_title = related_office&.name || ''

    {
      name:            official.name,
      ocdid:           division_id,
      title:           office_title,
      address:         address_detail(official, :line1),
      city:            address_detail(official, :city),
      state:           address_detail(official, :state),
      zip:             address_detail(official, :zip),
      political_party: official.party,
      photo_url:       official.photo_url || ''
    }
  end

  def self.address_detail(official, key)
    official.address&.first&.public_send(key) || ''
  end
end
