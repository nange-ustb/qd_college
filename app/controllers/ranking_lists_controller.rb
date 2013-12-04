# -*- encoding : utf-8 -*-
class RankingListsController < ApplicationController
  before_filter :authenticate_user!

  layout 'fight'

  def home
    @ranking_list_weeks = RankingListWeek.where(" stage = #{RankingListWeek.current_week} and gold_count > 0 ").reorder(' gold_count desc, ranking_lists.updated_at asc ').page(params[:page] || 1).per(10)
    @ranking_list_years = RankingListYear.where(" gold_count > 0 ").reorder(' gold_count desc, ranking_lists.updated_at asc ').page(params[:page] || 1).per(10)
  end

  def ranking_list_weeks
    @ranking_list_weeks = RankingListWeek.where(" stage = #{RankingListWeek.current_week} and gold_count > 0 ").search(params[:ranking_list_weeks] || {}).reorder(' gold_count desc, ranking_lists.updated_at asc ').page(params[:page] || 1).per(10)
  end

  def ranking_list_years
    @ranking_list_years = RankingListYear.where(" gold_count > 0 ").search(params[:ranking_list_years] || {}).reorder(' gold_count desc, ranking_lists.updated_at asc ').page(params[:page] || 1).per(10)
  end


end
