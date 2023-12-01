# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
  def index
    if params[:cycle].present? && params[:category].present?
      @candidates = CampaignFinance.get_top_candidates(params[:cycle], params[:category])
    elsif params[:cycle].present? && params[:query].present?
      @candidates = CampaignFinance.search_candidates(params[:cycle], params[:query])
    end
  end

  def show
    return unless params[:cycle].present? && params[:id].present?

    @candidate = CampaignFinance.get_candidate(params[:cycle], params[:id])
  end
end
