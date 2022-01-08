class HomeController < ApplicationController
  before_action :set_associations, only: [:index]
  before_action :set_cards, only: [:index]

  def index
    session[:tasks_mode] = :cards
    @elements = arrange_with_lists(OrgUnit.accessible_by(current_ability).arrange)
  end

  private
    def arrange_with_lists(hash = {})
      # add lists associated to org_unit
      hash.each do |node, children|
        next if node.kind_of? List
        node.lists.each do |list|
          hash[node][list.decorate] = {}
        end
        hash[node].merge(arrange_with_lists(children))
      end
      # add lists without assigned org_unit
      listhash = {}
      List.accessible_by(current_ability).where(org_unit_id: nil).each do |list|
        listhash.tap do |h|
          h[list.decorate] = {}
        end
      end
      hash.merge(listhash)
    end

    def set_associations
      @users ||= Wobauth::User.active.order("sn, givenname")
      @org_units ||= OrgUnit.accessible_by(current_ability, :work_on)
      @lists ||= List.accessible_by(current_ability, :read).order(:name)
    end

    def set_cards
      return unless search_params.present?
      if search_params['org_unit_id'].present?
        @element = OrgUnit.accessible_by(current_ability)
                         .where(id: search_params['org_unit_id'])
                         .first
        return if @element.nil?
        @tasks = @element.tasks.accessible_by(current_ability)

      elsif search_params['list_id'].present?
        @element = List.accessible_by(current_ability)
                       .where(id: search_params['list_id'])
                       .first
        return if @element.nil?
        @tasks = @element.tasks.accessible_by(current_ability)

      elsif search_params['private'].present?
        @tasks = Task.accessible_by(current_ability)
                                .where(org_unit_id: nil, list_id: nil)
      end
      @columns = State.not_archived
      @filter ||= @search_params.slice("org_unit_id", "list_id", "private")
      @url = request.url
    end

    def search_params
      @search_params ||= params.permit(*submit_parms,
                          :org_unit_id, :list_id, :private,
                        ).to_hash
                         .reject{|k, v| (v.blank? || submit_parms.include?(k))}
    end

    def submit_parms
      [ "utf8", "authenticity_token", "commit", "format" ]
    end
end
